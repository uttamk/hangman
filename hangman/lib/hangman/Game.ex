defmodule Hangman.Game do
  defstruct(
    letters: [],
    game_state: :initializing,
    turns_left: 7,
    used: MapSet.new()
  )

  def new_game(word) do
    %Hangman.Game{letters: word |> String.codepoints}
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

    Map.put(game, :used, MapSet.put(game.used, guess))
    |> eval_move(guess, MapSet.member?(letter_set, guess))
  end

  def eval_move(game, guess, _correct_guess = true) do
    Map.put(game, :game_state, :good_guess)
  end


  def eval_move(game, guess, _incorrect_guess = _) do
    Map.put(game, :game_state, :bad_guess)
  end

  def tally(game) do
    game
  end

end
