defmodule Estagiei.Repo.Migrations.CreateInternships do
  use Ecto.Migration

  def change do
    create table(:internships) do
      add :company, :string
      add :description, :string
      add :title, :string
      add :url, :string

      timestamps(type: :utc_datetime)
    end
  end
end
