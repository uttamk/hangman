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
    Map.put(game, :used, MapSet.put(game.used, guess))
  end

  def tally(game) do
    game
  end

end
