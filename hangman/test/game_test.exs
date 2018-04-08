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

    assert {%{game_state: :already_used}, _} = game |> Game.make_move("h")
  end

  test "state when bad guess" do
    assert {%{game_state: :bad_guess}, _} = Game.new_game("hello") |> Game.make_move("x")
  end

  test "state when good guess" do
    assert {%{game_state: :good_guess}, _} = Game.new_game("hello") |> Game.make_move("h")
  end

  test "state when game is lost" do
    {game, _} = Game.new_game("it", 2) |> Game.make_move("h")

    assert {%{game_state: :lost, turns_left: 0}, _} = game |> Game.make_move("e")
  end

  test "state when game is won" do
    {game, _} = Game.new_game("it", 2) |> Game.make_move("i")

    assert {%{game_state: :won}, _} = game |> Game.make_move("t")
  end

  test "tally when good guess" do
    assert {_, %{game_state: :good_guess, letters: ["_", "_", "l", "l", "_"], turns_left: 7}} =
             Game.new_game("hello") |> Game.make_move("l")
  end

  test "tally when bad guess" do
    assert {_, %{game_state: :bad_guess, letters: ["_", "_", "_", "_", "_"], turns_left: 6,  letters_used: ["x"]}} =
             Game.new_game("hello") |> Game.make_move("x")
  end
end
