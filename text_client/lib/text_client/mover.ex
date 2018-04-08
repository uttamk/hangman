require IEx;

defmodule TextClient.Mover do
  def move(state) do
    {gs, tally} = Hangman.make_move(state.game_service, state.guessed)
    %{state | game_service: gs, tally: tally}
  end
end
