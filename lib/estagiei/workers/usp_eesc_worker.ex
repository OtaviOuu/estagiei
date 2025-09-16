defmodule Estagiei.Workers.UspEescWorker do
  use Oban.Worker, queue: :default, max_attempts: 3

  alias Estagiei.Crawlers.Core.UspEesc.ExtractAllJobs
  alias Estagiei.Crawlers.Core.UspEesc.FilterForNewJobs
  alias Estagiei.Internships.Repositories.InternshipRepository

  @impl Oban.Worker
  @spec perform(any()) :: :error | :ok
  def perform(_args) do
    {:ok, jobs_attrs} =
      ExtractAllJobs.call()
      |> FilterForNewJobs.call()

    jobs_attrs
    |> Enum.each(fn job_attr ->
      case InternshipRepository.create_internship(job_attr) do
        {:ok, _internship} ->
          :error

        {:error, changeset} ->
          IO.inspect(changeset.errors, label: "Failed to create internship")
          {:error, "Failed to create internship"}
      end
    end)
  end
end
