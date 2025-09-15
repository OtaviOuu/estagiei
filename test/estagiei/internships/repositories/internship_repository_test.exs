defmodule Estagiei.Internships.Repositories.InternshipRepositoryTest do
  use Estagiei.DataCase

  alias Estagiei.Internships.Repositories.InternshipRepository

  describe "internships" do
    alias Estagiei.Internships.Entities.Internship

    import Estagiei.InternshipsFixtures

    @invalid_attrs %{description: nil, title: nil, url: nil, company: nil}

    test "list_internships/0 returns all internships" do
      internship = internship_fixture()
      assert InternshipRepository.list_internships() == [internship]
    end

    test "get_internship!/1 returns the internship with given id" do
      internship = internship_fixture()
      assert InternshipRepository.get_internship!(internship.id) == internship
    end

    test "create_internship/1 with valid data creates a internship" do
      valid_attrs = %{
        description: "some description",
        title: "some title",
        url: "some url",
        company: "some company"
      }

      assert {:ok, %Internship{} = internship} =
               InternshipRepository.create_internship(valid_attrs)

      assert internship.description == "some description"
      assert internship.title == "some title"
      assert internship.url == "some url"
      assert internship.company == "some company"
    end

    test "create_internship/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = InternshipRepository.create_internship(@invalid_attrs)
    end

    test "update_internship/2 with valid data updates the internship" do
      internship = internship_fixture()

      update_attrs = %{
        description: "some updated description",
        title: "some updated title",
        url: "some updated url",
        company: "some updated company"
      }

      assert {:ok, %Internship{} = internship} =
               InternshipRepository.update_internship(internship, update_attrs)

      assert internship.description == "some updated description"
      assert internship.title == "some updated title"
      assert internship.url == "some updated url"
      assert internship.company == "some updated company"
    end

    test "update_internship/2 with invalid data returns error changeset" do
      internship = internship_fixture()

      assert {:error, %Ecto.Changeset{}} =
               InternshipRepository.update_internship(internship, @invalid_attrs)

      assert internship == InternshipRepository.get_internship!(internship.id)
    end

    test "delete_internship/1 deletes the internship" do
      internship = internship_fixture()
      assert {:ok, %Internship{}} = InternshipRepository.delete_internship(internship)

      assert_raise Ecto.NoResultsError, fn ->
        InternshipRepository.get_internship!(internship.id)
      end
    end

    test "change_internship/1 returns a internship changeset" do
      internship = internship_fixture()
      assert %Ecto.Changeset{} = InternshipRepository.change_internship(internship)
    end
  end
end
