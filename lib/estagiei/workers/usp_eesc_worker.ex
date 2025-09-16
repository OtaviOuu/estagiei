defmodule Estagiei.Workers.UspEescWorker do
  use Oban.Worker, queue: :default, max_attempts: 3

  alias Estagiei.Crawlers.Core.UspEesc.ExtractAllJobs
  alias Estagiei.Crawlers.Core.UspEesc.FilterForNewJobs

  @impl Oban.Worker
  def perform(_args) do
    jobs =
      ExtractAllJobs.call()
      |> FilterForNewJobs.call()

    IO.inspect(jobs, label: "New USP EESC Jobs")
    :ok
  end
end
