defmodule Estagiei.Internships.Entities.Internship do
  use Ecto.Schema
  import Ecto.Changeset

  schema "internships" do
    field :company, :string
    field :description, :string
    field :title, :string
    field :url, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(internship, attrs) do
    internship
    |> cast(attrs, [:company, :description, :title, :url])
    |> validate_required([:company, :description, :title, :url])
  end
end
