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
  def game_state(%{game_state: game_state}, original_word) when game_state in [:lost] do
    alert_div = alert(@responses[game_state])
    Enum.join([alert_div, "\n", original_word_div(original_word)]) |> raw()
  end

  def game_state(tally, _) do
    state = tally.game_state

    @responses[state] |> alert() |> raw()
  end

  defp original_word_div(original_word) do
    """
      <div class="alert-danger">
        The word is #{original_word}
      </div>
    """
  end

  defp alert({class, message}) do
    """
      <div class="alert-#{class}">
        #{message}
      </div>
    """
  end
end
