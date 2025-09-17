defmodule Estagiei.Crawlers.Core.UspEesc.ExtractAllJobs do
  alias Estagiei.HttpClient
  alias Estagiei.Parser

  @domain "https://eesc.usp.br"
  @main_page_url "#{@domain}/estagios"

  @slug_suffix "-usp-eesc"

  def call do
    with {:ok, html} <- HttpClient.get("#{@main_page_url}/posts.php"),
         {:ok, document} <- Parser.parse_html(html) do
      jobs = extract_jobs(document)
      {:ok, jobs}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  defp extract_jobs(document) do
    document
    |> Floki.find("h5 a")
    |> Enum.map(&extract_job_details/1)
  end

  defp extract_job_details(job_html) do
    href = Floki.attribute(job_html, "href") |> List.first()

    {:ok, main_page_html} = HttpClient.get("#{@main_page_url}/#{href}")
    {:ok, main_page_tree} = Parser.parse_html(main_page_html)

    title =
      main_page_tree
      |> Floki.find("h5.title-not")
      |> Floki.text()
      |> String.trim()

    description =
      main_page_tree
      |> Floki.find("#v-pills-tabContent .mt-4")
      |> Floki.raw_html()

    %{
      title: title,
      description: description,
      slug: generate_slug(title),
      company: "USP - EESC",
      url: "#{@main_page_url}/#{href}"
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
