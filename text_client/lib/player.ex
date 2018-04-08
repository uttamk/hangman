defmodule TextClient.Player do
  alias TextClient.{State, Summary, Prompter, Mover}

  def play(_state = %State{tally: %{game_state: :lost}, game_service: game_service}) do
    exit_with_message(["Sorry, you lost the game !","\n", "The word was #{game_service.letters}"])
  end
  def play(_state = %State{tally: %{game_state: :won}}) do
    exit_with_message("Congratulations, you won the game!")
  end

  def play(state = %State{tally: %{game_state: :good_guess}}) do
    continue_with_message(state, "You have guessed correctly !")
  end

  def play(state = %State{tally: %{game_state: :bad_guess}}) do
    continue_with_message(state, "Wrong guess !")
  end

  def play(state = %State{tally: %{game_state: :already_used}}) do
    continue_with_message(state, "Letter is already used !")
  end

  def play(state) do
    continue(state)
  end

  def continue(state) do
    state
      |> Summary.display()
      |> Prompter.accept_move()
      |> Mover.move()
      |> play()
  end

  defp continue_with_message(state, msg) do
      IO.puts(msg)
      continue(state)
  end

  defp exit_with_message(msg) do
    IO.puts(msg)
    exit(:normal)
  end
end
