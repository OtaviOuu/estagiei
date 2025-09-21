defmodule Estagiei.Workers.UnicampWorker do
  use Oban.Worker, queue: :default, max_attempts: 3

  alias Estagiei.Crawlers.Core.Unicamp.ExtractAllJobs
  alias Estagiei.Internships

  @impl Oban.Worker
  def perform(_args) do
    {:ok, jobs_attrs} =
      ExtractAllJobs.call()

    jobs_attrs
    |> Enum.each(&Internships.create_internship/1)
  end
end
