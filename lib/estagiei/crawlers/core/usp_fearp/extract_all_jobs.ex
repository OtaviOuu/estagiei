defmodule Estagiei.Crawlers.Core.UspFearp.ExtractAllJobs do
  alias Estagiei.HttpClient
  alias Estagiei.Parser

  @domain "https://www.fearp.usp.br"
  @main_page_url "#{@domain}/estagio/item/1116-vagas-online.html"

  @slug_suffix "-usp-fearp"

  def call do
    with {:ok, html} <- HttpClient.get(@main_page_url),
         {:ok, document} <- Parser.parse_html(html) do
      jobs = extract_jobs(document)
      {:ok, jobs}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  defp extract_jobs(document) do
    document
    |> Floki.find("a[href*='/images/estagio/Vagas/']")
    |> Enum.map(&extract_job_details/1)
  end

  defp extract_job_details(job) do
    href = Floki.attribute(job, "href") |> List.first()
    title = Floki.text(job) |> String.trim()

    %{
      title: title,
      slug: generate_slug(title),
      company: "USP - FEARP",
      description: "desd",
      url: "#{@domain}#{href}"
    }
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
