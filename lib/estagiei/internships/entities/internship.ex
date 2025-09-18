defmodule Estagiei.Internships.Entities.Internship do
  use Ecto.Schema
  import Ecto.Changeset

  @fields [:company, :description, :title, :url, :slug]
  @required_fields [:company, :title, :url, :slug]
  @primary_key {:id, :binary_id, autogenerate: true}
  schema "internships" do
    field :company, :string
    field :description, :string
    field :title, :string
    field :slug, :string
    field :url, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(internship \\ %__MODULE__{}, attrs) do
    internship
    |> cast(attrs, @fields ++ @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:slug)
  end
end
