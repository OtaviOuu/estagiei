defmodule Estagiei.Crawlers.Core.Unicamp.ExtractAllJobs do
  alias Estagiei.HttpClient

  @domain "https://carreiras.unicamp.br"
  @slug_suffix "-unicamp"
  def call do
    with {:ok, html} <-
           HttpClient.get("#{@domain}/oportunidades"),
         {:ok, document} <- Floki.parse_document(html) do
      jobs = extract_jobs(document)
      {:ok, jobs}
    end
  end

  defp extract_jobs(document) do
    document
    |> Floki.find(".w-full.m-auto")
    |> Enum.map(&extract_job_details/1)
  end

  defp extract_job_details(job_html) do
    href =
      job_html
      |> Floki.find("a")
      |> Floki.attribute("href")
      |> List.first()

    with {:ok, job_html} <- HttpClient.get("#{@domain}#{href}"),
         {:ok, job_tree} <- Floki.parse_document(job_html) do
      description =
        job_tree
        |> Floki.find(".flex.flex-col.gap-10")
        |> Floki.raw_html()

      title =
        job_tree
        |> Floki.find("h1.font-bold.text-customColorDark.text-center")
        |> Floki.text()
        |> String.trim()

      %{
        url: "#{@domain}#{href}",
        description: description,
        company: "Unicamp",
        title: title,
        slug: generate_slug(title)
      }
    end
  end

  defp generate_slug(title) do
    title
    |> String.downcase()
    |> String.normalize(:nfd)
    |> String.replace(~r/[\p{Mn}]/u, "")
    |> String.replace(~r/[^\w\s-]/u, "")
    |> String.replace(~r/\s+/, "-")
    |> String.replace(~r/-+/, "-")
    |> String.trim("-")
    |> String.replace_suffix("", @slug_suffix)
  end
end
