defmodule Estagiei.Workers.UspFearpWorker do
  use Oban.Worker, queue: :default, max_attempts: 3

  alias Estagiei.Crawlers.Core.UspFearp.ExtractAllJobs
  alias Estagiei.Crawlers.FilterForNewJobs
  alias Estagiei.Internships

  @impl Oban.Worker
  def perform(_args) do
    {:ok, jobs_attrs} =
      ExtractAllJobs.call()
      |> FilterForNewJobs.call()

    jobs_attrs
    |> Enum.each(&Internships.create_internship(&1))
  end
end
