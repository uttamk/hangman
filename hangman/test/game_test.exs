defmodule GameTest do
  use ExUnit.Case
  doctest Hangman.Game
  alias Hangman.Game

  test "state when new game" do
    game = Game.new_game()

    assert game.game_state == :initializing
    assert game.turns_left == 7
  end

  test "state when same letter is guessed again" do
    {game, _} = Game.new_game("hello") |> Game.make_move("h")
    {game, _} = game |> Game.make_move("h")

    assert game.game_state == :already_used

  end


  test "state when bad guess" do
    {game, _} = Game.new_game("hello") |> Game.make_move("x")

    assert game.game_state == :bad_guess
  end

  test "state when good guess" do
    {game, _} = Game.new_game("hello") |> Game.make_move("h")

    assert game.game_state == :good_guess
  end

  test "state when game is lost" do
    {game, _} = Game.new_game("it", 2) |> Game.make_move("h")
    {game, _} = game |> Game.make_move("e")

    assert game.game_state == :lost
  end


  test "state when game is won" do
    {game, _} = Game.new_game("it", 2) |> Game.make_move("i")
    {game, _} = game |> Game.make_move("t")

    assert game.game_state == :won
  end
end
