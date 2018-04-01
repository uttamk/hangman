defmodule GameTest do
  use ExUnit.Case
  doctest Hangman.Game

  test "state when new game" do
    game = Hangman.Game.new_game()

    assert game.game_state == :initializing
    assert game.turns_left == 7
  end
end
