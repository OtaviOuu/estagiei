defmodule Estagiei.Repo.Migrations.CreateInternships do
  use Ecto.Migration

  def change do
    create table(:internships) do
      add :company, :string
      add :description, :text
      add :title, :string
      add :slug, :string, null: false
      add :url, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:internships, [:slug])
  end
end
