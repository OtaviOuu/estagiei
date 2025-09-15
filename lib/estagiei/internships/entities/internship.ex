defmodule Estagiei.Internships.Entities.Internship do
  use Ecto.Schema
  import Ecto.Changeset

  @fields [:company, :description, :title, :url]
  schema "internships" do
    field :company, :string
    field :description, :string
    field :title, :string
    field :url, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(internship \\ %__MODULE__{}, attrs) do
    internship
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
