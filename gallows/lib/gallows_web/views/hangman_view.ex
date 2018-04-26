defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view
  def new_game(conn) do
    button("New Game", to: hangman_path(conn, :new_game))
  end

  def game_over?(%{game_state: game_state}) do
    game_state in [:won, :lost]
  end
  @responses %{
    won: {:success, "You Won !"},
    lost: {:danger, "You Lost !"},
    good_guess: {:success, "Good guess !"},
    bad_guess: {:warning, "Bad guess !"},
    already_used: {:info, "Already guessed !"},
    initializing: {:info, "Ready to Roll !"},
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
    """ |> raw()
  end
end
