defmodule GameTest do
  use ExUnit.Case
  doctest Hangman.Game
  alias Hangman.Game
  @cant_reveal_word_error "[Error] Can't reveal word in the middle of a game"

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
    assert {_,
            %{
              game_state: :bad_guess,
              letters: ["_", "_", "_", "_", "_"],
              turns_left: 6,
              letters_used: ["x"]
            }} = Game.new_game("hello") |> Game.make_move("x")
  end

  test "original word when state is lost" do
    {game, _} = Game.new_game("a", 1) |> Game.make_move("b")

    assert :lost = game.game_state
    "a" = Game.original_word(game)
  end

  test "original word when state is won" do
    {game, _} = Game.new_game("a", 1) |> Game.make_move("a")

    assert :won = game.game_state
    "a" = Game.original_word(game)
  end

  test "original should not reveal when game is initializing" do
    game = Game.new_game("a", 1)

    assert :initializing = game.game_state
    assert @cant_reveal_word_error = Game.original_word(game)
  end

  test "original should not reveal when game is in good guess state" do
    {game, _} = Game.new_game("ab", 1) |> Game.make_move("a")

    assert :good_guess = game.game_state
    assert @cant_reveal_word_error = Game.original_word(game)
  end

  test "original should not reveal when game is in bad guess state" do
    {game, _} = Game.new_game("ab", 2) |> Game.make_move("x")

    assert :bad_guess = game.game_state
    assert @cant_reveal_word_error = Game.original_word(game)
  end

  test "original should not reveal when game is in already used state" do
    {game, _} = Game.new_game("ab", 2) |> Game.make_move("x")
    {game, _} = game |> Game.make_move("x")

    assert :already_used = game.game_state
    assert @cant_reveal_word_error = Game.original_word(game)
  end
end
