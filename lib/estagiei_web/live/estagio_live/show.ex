defmodule EstagieiWeb.EstagioLive.Show do
  use EstagieiWeb, :live_view
  alias Estagiei.Internships

  def mount(%{"slug" => job_slug}, _session, socket) do
    internship = Internships.get_internship_by_slug!(job_slug)
    {:ok, assign(socket, :internship, internship)}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.link patch={~p"/estagios"}>
        <button class="btn btn-outline btn-info mb-4">&larr; Voltar</button>
      </.link>
      <h1>{@internship.title}</h1>
      <.description :if={@internship.description} internship={@internship} />
      <.pdf :if={!@internship.description} internship={@internship} />
    </Layouts.app>
    """
  end

  defp pdf(assigns) do
    ~H"""
    <iframe src={@internship.url} width="100%" height="800px"></iframe>
    """
  end

  defp description(assigns) do
    ~H"""
    <div class="prose max-w-none">
      {raw(@internship.description)}
    </div>
    """
  end
end
