defmodule EstagieiWeb.EstagioLive.Index do
  use EstagieiWeb, :live_view
  alias Estagiei.Internships

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :internships, Internships.list_internships())}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <div class="overflow-x-auto">
        <table class="table table-xs table-pin-rows table-pin-cols">
          <thead>
            <tr>
              <td>Vaga</td>
              <td>Fonte</td>
              <td>Views</td>
            </tr>
          </thead>
          <tbody>
            <tr
              :for={internship <- @internships}
              phx-click="handle_job_click"
              phx-value-slug={internship.slug}
              class="hover cursor-pointer hover:bg-base-200"
            >
              <td>{internship.title}</td>
              <td>{internship.company}</td>
              <td>10</td>
            </tr>
          </tbody>
        </table>
      </div>
    </Layouts.app>
    """
  end

  def handle_event("handle_job_click", %{"slug" => job_slug}, socket) do
    socket =
      socket
      |> push_navigate(to: ~p"/estagios/#{job_slug}")

    {:noreply, socket}
  end
end
