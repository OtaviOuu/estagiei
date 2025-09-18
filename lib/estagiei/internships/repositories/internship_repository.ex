defmodule Estagiei.Internships.Repositories.InternshipRepository do
  @moduledoc """
  The Internships context.
  """

  import Ecto.Query, warn: false
  alias Estagiei.Repo

  alias Estagiei.Internships.Entities.Internship

  @doc """
  Returns the list of internships.

  ## Examples

      iex> list_internships()
      [%Internship{}, ...]

  """
  def list_internships(opts \\ []) do
    case Keyword.get(opts, :search) do
      nil ->
        Repo.all(Internship)

      "" ->
        Repo.all(Internship)

      search ->
        like_pattern = "%#{search}%"

        Internship
        |> order_by(desc: :inserted_at)
        |> where([i], ilike(i.title, ^like_pattern))
        |> Repo.all()
    end
  end

  @doc """
  Gets a single internship.

  Raises `Ecto.NoResultsError` if the Internship does not exist.

  ## Examples

      iex> get_internship!(123)
      %Internship{}

      iex> get_internship!(456)
      ** (Ecto.NoResultsError)

  """
  def get_internship!(id), do: Repo.get!(Internship, id)
  def get_internship_by_slug!(slug), do: Repo.get_by!(Internship, slug: slug)

  @doc """
  Creates a internship.

  ## Examples

      iex> create_internship(%{field: value})
      {:ok, %Internship{}}

      iex> create_internship(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_internship(attrs) do
    %Internship{}
    |> Internship.changeset(attrs)
    |> Repo.insert(on_conflict: :nothing, conflict_target: :slug)
  end

  @doc """
  Updates a internship.

  ## Examples

      iex> update_internship(internship, %{field: new_value})
      {:ok, %Internship{}}

      iex> update_internship(internship, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_internship(%Internship{} = internship, attrs) do
    internship
    |> Internship.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a internship.

  ## Examples

      iex> delete_internship(internship)
      {:ok, %Internship{}}

      iex> delete_internship(internship)
      {:error, %Ecto.Changeset{}}

  """
  def delete_internship(%Internship{} = internship) do
    Repo.delete(internship)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking internship changes.

  ## Examples

      iex> change_internship(internship)
      %Ecto.Changeset{data: %Internship{}}

  """
  def change_internship(%Internship{} = internship, attrs \\ %{}) do
    Internship.changeset(internship, attrs)
  end
end
