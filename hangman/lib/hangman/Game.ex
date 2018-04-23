defmodule Hangman.Game do
  alias Hangman.Game
  defstruct(
    letters: [],
    game_state: :initializing,
    turns_left: 7,
    used: MapSet.new()
  )

  def new_game(word) do
    new_game(word, 7)
  end

  def new_game(word, turns_left) do
    %Hangman.Game{
      letters: word |> String.codepoints(),
      turns_left: turns_left
    }
  end

  def new_game() do
    new_game(Dictionary.random_word(), 7)
  end

  def make_move(game, guess) do
    game = accept_move(game, guess, MapSet.member?(game.used, guess))
    {game, tally(game)}
  end

  def tally(game) do
    %{
      game_state: game.game_state,
      letters: reveal_guesses(game.letters, game.used),
      turns_left: game.turns_left,
      letters_used: MapSet.to_list(game.used)
    }
  end

  def original_word(%Game{game_state: :won, letters: letters}), do: Enum.join(letters)
  def original_word(%Game{game_state: :lost, letters: letters}), do: Enum.join(letters)
  def original_word(_in_progress_game), do: "[Error] Can't reveal word in the middle of a game"

  ##########################################################################################################

  defp accept_move(game, _guess, _already_used = true) do
    Map.put(game, :game_state, :already_used)
  end

  defp accept_move(game, guess, _not_already_used) do
    letter_set = MapSet.new(game.letters)

    %{game | used: MapSet.put(game.used, guess)}
    |> eval_move(MapSet.member?(letter_set, guess))
  end

  defp eval_move(game, _correct_guess = true) do
    letter_set = MapSet.new(game.letters)
    %{game | game_state: maybe_won(MapSet.subset?(letter_set, game.used))}
  end

  defp eval_move(game, _incorrect_guess) do
    %{game | game_state: maybe_lost(game.turns_left - 1), turns_left: game.turns_left - 1}
  end

  defp maybe_lost(_no_turns_left = 0), do: :lost
  defp maybe_lost(_turns_left_ = _), do: :bad_guess

  defp maybe_won(_all_letters_matched = true), do: :won
  defp maybe_won(_), do: :good_guess

  defp reveal_guesses(letters, used) do
    letters |> Enum.map(fn letter -> reveal_letter(letter, MapSet.member?(used, letter)) end)
  end

  defp reveal_letter(letter, _is_guessed = true), do: letter
  defp reveal_letter(_, _not_guessed), do: "_"
end
