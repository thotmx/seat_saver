defmodule SeatSaver.Seat do
  use SeatSaver.Web, :model

  schema "seats" do
    field :seat_number, :integer
    field :occupied, :boolean, default: false

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:seat_number, :occupied])
    |> validate_required([:seat_number, :occupied])
  end
end

defimpl Poison.Encoder, for: SeatSaver.Seat do
  def encode(model, opts) do
    %{id: model.id,
      seatNumber: model.seat_number,
      occupied: model.occupied} |> Poison.Encoder.encode(opts)
  end
end
