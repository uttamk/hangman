defmodule Hangman.Game do
  defstruct(
    game_state: :initializing,
    turns_left: 7
  )
  def new_game() do
    %Hangman.Game{}
  end
end
