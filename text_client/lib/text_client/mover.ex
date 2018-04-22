require IEx;

defmodule TextClient.Mover do
  def move(state) do
    tally = Hangman.make_move(state.game_service, state.guessed)
    %{state | game_service: state.game_service, tally: tally}
  end
end
