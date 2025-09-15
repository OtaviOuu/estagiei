defmodule Estagiei.Interships.Entities.Intership do
  use Ecto.Schema
  import Ecto.Changeset

  @fields ~w(company description title url)
  @primary_key {:id, :binary_id, autogenerate: true}
  schema "interships" do
    field :company, :string
    field :description, :string
    field :title, :string
    field :url, :string
    timestamps()
  end
end
