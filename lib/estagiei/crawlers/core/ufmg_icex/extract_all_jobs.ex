defmodule Estagiei.Crawlers.Core.UfmgIcex.ExtractAllJobs do
  alias Estagiei.HttpClient
  @domain "https://www.icex.ufmg.br"
  @slug_suffix "-ufmg-icex"
  def call do
    with {:ok, html} <-
           HttpClient.get("#{@domain}/icex_novo/oportunidades/"),
         {:ok, document} <- Floki.parse_document(html) do
      jobs = extract_jobs(document)
      {:ok, jobs}
    end
  end

  defp extract_jobs(document) do
    document
    |> Floki.find(".eael-timeline-post-inner")
    |> Enum.map(&extract_job_details/1)
  end

  defp extract_job_details(job_html) do
    href =
      job_html
      |> Floki.find(".eael-timeline-post-link")
      |> Floki.attribute("href")
      |> List.first()

    with {:ok, job_html} <- HttpClient.get(href),
         {:ok, job_tree} <- Floki.parse_document(job_html) do
      description =
        job_tree
        |> Floki.find(".entry-content.clear")
        |> Floki.raw_html()

      title =
        job_tree
        |> Floki.find("h1.entry-title")
        |> Floki.text()
        |> String.trim()

      %{
        url: href,
        description: description,
        company: "UFMG - ICEX",
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
