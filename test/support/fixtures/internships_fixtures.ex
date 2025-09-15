defmodule Estagiei.InternshipsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Estagiei.Internships` context.
  """

  @doc """
  Generate a internship.
  """
  def internship_fixture(attrs \\ %{}) do
    {:ok, internship} =
      attrs
      |> Enum.into(%{
        company: "some company",
        description: "some description",
        title: "some title",
        url: "some url"
      })
      |> Estagiei.Internships.Repositories.InternshipRepository.create_internship()

    internship
  end
end
