defmodule Hangman.Game do
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
      letters: word |> String.codepoints,
      turns_left: turns_left
    }
  end

  def new_game() do
    %Hangman.Game{}
  end

  def make_move(game, guess) do
      {accept_move(game, guess, MapSet.member?(game.used, guess)), tally(game)}
  end

  def accept_move(game, guess,_already_used = true) do
    Map.put(game, :game_state, :already_used)
  end


  def accept_move(game, guess, _not_already_used) do
    letter_set = MapSet.new(game.letters)
    %{game |
        used: MapSet.put(game.used, guess),
        turns_left: game.turns_left - 1
     }
     |> eval_move(guess, MapSet.member?(letter_set, guess))
  end

  def eval_move(game, guess, _correct_guess = true) do
    letter_set = MapSet.new(game.letters)

    new_state = maybe_won(MapSet.subset?(letter_set, game.used))

    Map.put(game, :game_state, new_state)
  end


  def eval_move(game, guess, _incorrect_guess = _) do
    new_state = maybe_lost(game.turns_left)
    Map.put(game, :game_state, new_state)
  end

  def maybe_lost(_no_turns_left = 0), do: :lost
  def maybe_lost(_turns_left_=_), do: :bad_guess


  def maybe_won(_all_letters_matched = true), do: :won
  def maybe_won(_), do: :good_guess

  def tally(game) do
    game
  end

end
