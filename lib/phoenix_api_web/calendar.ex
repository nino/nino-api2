defmodule CalendarParams do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field(:title, :string)
    field(:start_date, :date)
    field(:interval, :integer)
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, [:title, :start_date, :interval])
    |> validate_required([:title, :start_date, :interval])
    |> validate_length(:title, min: 1)
    |> validate_number(:interval, greater_than_or_equal_to: 1)
  end
end

defmodule CalendarUtils do
  defp pluralize(singular, plural, count) do
    if count == 1 do
      singular
    else
      plural
    end
  end

  def delayed_event(title, start_date, days_delay) do
    delayed_date = Date.add(start_date, days_delay)

    %ICalendar.Event{
      summary: "#{days_delay} #{pluralize(~c"day", ~c"days", days_delay)} since #{title}",
      dtstart: delayed_date,
      dtend: delayed_date
    }
  end
end
