defmodule Estagiei.Workers.UspEescWorker do
  use Oban.Worker, queue: :default, max_attempts: 3

  alias Estagiei.Crawlers.Core.UspEesc.ExtractAllJobs
  alias Estagiei.Crawlers.FilterForNewJobs
  alias Estagiei.Internships
  alias Estagiei.Repo

  @impl Oban.Worker
  def perform(_args) do
    {:ok, jobs_attrs} =
      ExtractAllJobs.call()
      |> FilterForNewJobs.call()

    Repo.transact(fn ->
      jobs_attrs
      |> Enum.each(&create_internship_and_broadcast/1)

      {:ok, :done}
    end)
  end

  defp create_internship_and_broadcast(attrs) do
    case Internships.create_internship(attrs) do
      {:ok, internship} ->
        Estagiei.Internships.Events.NewInternship.broadcast(internship)
        {:ok, internship}

      error ->
        error
    end
  end
end
