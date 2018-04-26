defmodule Gallows.Views.Helpers.GameStateHelper do
  import Phoenix.HTML, only: [raw: 1]
  @responses %{
    won: {:success, "You Won !"},
    lost: {:danger, "You Lost !"},
    good_guess: {:success, "Good guess !"},
    bad_guess: {:warning, "Bad guess !"},
    already_used: {:info, "Already guessed !"},
    initializing: {:info, "Ready to Roll !"}
  }
  def game_state(tally) do
    state = tally.game_state

    @responses[state] |> alert()
  end

  defp alert({class, message}) do
    """
      <div class="alert-#{class}">
        #{message}
      </div>
    """
    |> raw()
  end
end
