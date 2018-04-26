defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view
  import Gallows.Views.Helpers.GameStateHelper

  def turn(turns_left, target) when turns_left <= target do
      "opacity: 1"
  end

  def turn(turns_left, target) do
      "opacity: 0.1"
  end
  def new_game(conn) do
    button("New Game", to: hangman_path(conn, :new_game))
  end

  def game_over?(%{game_state: game_state}) do
    game_state in [:won, :lost]
  end
end
