defmodule Estagiei.Workers.UspFearpWorker do
  use Oban.Worker, queue: :default, max_attempts: 3

  alias Estagiei.Crawlers.Core.UspFearp.ExtractAllJobs
  alias Estagiei.Crawlers.FilterForNewJobs
  alias Estagiei.Internships
  alias Estagiei.Repo

  @impl Oban.Worker
  def perform(_args) do
    {:ok, jobs_attrs} =
      ExtractAllJobs.call()
      |> FilterForNewJobs.call()

    Repo.transact(fn ->
      IO.inspect(jobs_attrs, label: "New USP FEARP Jobs Found")

      jobs_attrs
      |> Enum.each(&Internships.create_internship(&1))

      {:ok, :done}
    end)
  end
end
