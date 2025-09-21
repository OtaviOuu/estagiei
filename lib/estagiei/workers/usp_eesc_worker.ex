defmodule Estagiei.Workers.UspEescWorker do
  use Oban.Worker, queue: :default, max_attempts: 3

  alias Estagiei.Crawlers.Core.UspEesc.ExtractAllJobs
  alias Estagiei.Crawlers.FilterForNewJobs
  alias Estagiei.Internships

  @impl Oban.Worker
  def perform(_args) do
    {:ok, jobs_attrs} =
      ExtractAllJobs.call()
      |> FilterForNewJobs.call()

    jobs_attrs
    |> Enum.each(&Internships.create_internship/1)
  end
end
