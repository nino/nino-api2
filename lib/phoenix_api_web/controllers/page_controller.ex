defmodule PhoenixApiWeb.PageController do
  use PhoenixApiWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def calendar(conn, params) do
    case CalendarParams.changeset(params) do
      %{valid?: true, changes: %{title: title, start_date: start_date, interval: interval}} ->
        conn
        |> put_resp_content_type("text/calendar")
        |> text(calendar_handler(title, start_date, interval))

      %{valid?: false, errors: errors} ->
        error_messages =
          errors
          |> Enum.map(fn {field, {message, _}} -> "#{field} #{message}" end)
          |> Enum.join(", ")

        conn
        |> put_status(:bad_request)
        |> json(%{errors: error_messages})
    end
  end

  defp calendar_handler(title, start_date, interval) do
    events =
      0..100
      |> Enum.map(fn factor ->
        CalendarUtils.delayed_event(title, start_date, factor * interval)
      end)

    ICalendar.Serialize.to_ics(%ICalendar{events: events})
  end
end
