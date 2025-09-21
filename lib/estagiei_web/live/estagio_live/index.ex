defmodule EstagieiWeb.EstagioLive.Index do
  use EstagieiWeb, :live_view
  alias Estagiei.Internships

  def mount(_params, _session, socket) do
    if connected?(socket), do: Internships.subscribe_to_new_internship_events()

    search_form = to_form(%{"search" => ""})

    socket =
      socket
      |> assign(:search_form, search_form)
      |> stream(:internships, Internships.list_internships())

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <div class="overflow-x-auto p-4">
        <.form
          for={@search_form}
          phx-change="search"
          phx-debounce="500"
          class="mb-4 flex w-full justify-center"
        >
          <.input field={@search_form[:search]} placeholder="Search" />
        </.form>
        <table class="table table-xs table-pin-rows table-pin-cols">
          <thead>
            <tr>
              <td>Vaga</td>
              <td>Fonte</td>
              <td>Data da Coleta</td>
              <td>Views</td>
            </tr>
          </thead>
          <pre>
            {@aaa}
          </pre>
          <tbody id="internships-table" phx-update="stream">
            <tr
              :for={{dom_id, internship} <- @streams.internships}
              phx-click="handle_job_click"
              id={"#{dom_id}"}
              phx-value-slug={internship.slug}
              phx-mounted={JS.add_class("animate-fade-in")}
              class="hover cursor-pointer hover:bg-base-200 transition-all"
            >
              <td>
                {internship.title}
              </td>
              <td>
                {internship.company}
              </td>
              <td>{internship.inserted_at |> format_date()}</td>
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

  def handle_event("search", %{"search" => search}, socket) do
    new_list = Internships.list_internships(search: search)
    {:noreply, assign(socket, :internships, new_list)}
  end

  def handle_info({:new_internship, internship}, socket) do
    {:noreply, stream_insert(socket, :internships, internship, at: 0)}
  end

  defp format_date(date) do
    date
    |> NaiveDateTime.to_date()
    |> Date.to_iso8601()
  end
end
