defmodule EstagieiWeb.EstagioLive.Index do
  use EstagieiWeb, :live_view
  alias Estagiei.Internships

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :internships, Internships.list_internships())}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <div class="bg-base-100 sticky top-0 z-10 shadow-sm border-b border-base-200">
        <div class="container mx-auto px-4 py-4">
          <div class="flex flex-wrap gap-4 items-center justify-between">
            <div class="flex gap-2">
              <div class="form-control">
                <input
                  type="text"
                  placeholder="Buscar estágios..."
                  class="input input-bordered w-full max-w-xs"
                />
              </div>
              <select class="select select-bordered">
                <option disabled selected>Área</option>
                <option>Tecnologia</option>
                <option>Marketing</option>
                <option>Vendas</option>
                <option>Design</option>
              </select>
              <select class="select select-bordered">
                <option disabled selected>Localização</option>
                <option>São Paulo</option>
                <option>Rio de Janeiro</option>
                <option>Belo Horizonte</option>
                <option>Remoto</option>
              </select>
            </div>
            <div class="flex gap-2">
              <button class="btn btn-outline btn-sm">
                <.icon name="hero-funnel" class="w-4 h-4" /> Filtros
              </button>
              <button class="btn btn-primary btn-sm">
                <.icon name="hero-plus" class="w-4 h-4" /> Novo Estágio
              </button>
            </div>
          </div>
        </div>
      </div>

      <div class="container mx-auto px-4 py-8">
        <.general_stats_card internships_counter={length(@internships)} />
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          <.job_info_card :for={internship <- @internships} internship={internship} />

          <div :if={length(@internships) > 0} class="flex justify-center mt-12">
            <button class="btn btn-outline btn-wide">
              Carregar mais estágios <.icon name="hero-chevron-down" class="w-4 h-4" />
            </button>
          </div>
        </div>
      </div>

      <div class="fixed bottom-6 right-6 z-50 md:hidden">
        <button class="btn btn-primary btn-circle btn-lg shadow-2xl">
          <.icon name="hero-plus" class="w-6 h-6" />
        </button>
      </div>
    </Layouts.app>
    """
  end

  def job_info_card(assigns) do
    ~H"""
    <div class="card bg-base-100 shadow-xl hover:shadow-2xl transition-all duration-300 hover:-translate-y-2">
      <div phx-click="handle_job_click" phx-value-id={@internship.id} class="card-body cursor-pointer">
        <div class="flex items-start justify-between mb-4">
          <div class="flex-1">
            <div class="flex items-start justify-between">
              <div>
                <h2 class="card-title text-lg font-bold line-clamp-2">
                  {@internship.title}
                </h2>
                <p class="text-sm text-base-content/70">{@internship.slug}</p>
              </div>
            </div>
          </div>
        </div>
        
    <!-- Tags/Badges -->
        <div class="flex flex-wrap gap-2 mb-4">
          <div class="badge badge-primary badge-sm">Tecnologia</div>
          <div class="badge badge-secondary badge-sm">Remoto</div>
          <div class="badge badge-accent badge-sm">Meio período</div>
        </div>
        
    <!-- Descrição -->
        <p class="text-sm text-base-content/80 mb-4 line-clamp-3">
          Oportunidade única de estágio em uma empresa inovadora. Desenvolva suas habilidades em um ambiente colaborativo e dinâmico.
        </p>
        
    <!-- Informações adicionais -->
        <div class="space-y-2 mb-4">
          <div class="flex items-center text-sm text-base-content/70">
            <.icon name="hero-map-pin" class="w-4 h-4 mr-2" /> São Paulo, SP
          </div>
          <div class="flex items-center text-sm text-base-content/70">
            <.icon name="hero-currency-dollar" class="w-4 h-4 mr-2" /> R$ 1.200,00 - R$ 1.500,00
          </div>
          <div class="flex items-center text-sm text-base-content/70">
            <.icon name="hero-clock" class="w-4 h-4 mr-2" /> Publicado há 2 dias
          </div>
        </div>
        
    <!-- Ações do card -->
        <div class="card-actions justify-end">
          
    <!-- Logo da Universidade como tag -->
          <div class="flex-shrink-0 ml-2">
            <div class="flex items-center gap-1 bg-base-200 rounded-full px-2 py-1 border">
              <img
                src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmqA3GPtvSBXShKTapJzheR0q8q6VudcI3MQ&s"
                alt="Logo da Universidade"
                class="w-5 h-5 rounded-full object-cover"
              />
              <span class="text-xs font-medium text-base-content/80">
                EESC - USP
              </span>
            </div>
          </div>
        </div>
      </div>
      
    <!-- Barra colorida no topo -->
      <div class="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-primary to-secondary rounded-t-2xl">
      </div>
    </div>
    """
  end

  def general_stats_card(assigns) do
    ~H"""
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
      <div class="stat bg-base-100 shadow-lg rounded-box">
        <div class="stat-figure text-primary">
          <.icon name="hero-briefcase" class="w-8 h-8" />
        </div>
        <div class="stat-title">Total de Estágios</div>
        <div class="stat-value text-primary">
          {@internships_counter}
        </div>
        <div class="stat-desc">Vagas disponíveis</div>
      </div>

      <div class="stat bg-base-100 shadow-lg rounded-box">
        <div class="stat-figure text-secondary">
          <.icon name="hero-building-office-2" class="w-8 h-8" />
        </div>
        <div class="stat-title">Empresas</div>
        <div class="stat-value text-secondary">45</div>
        <div class="stat-desc">Parceiras ativas</div>
      </div>

      <div class="stat bg-base-100 shadow-lg rounded-box">
        <div class="stat-figure text-accent">
          <.icon name="hero-users" class="w-8 h-8" />
        </div>
        <div class="stat-title">Candidatos</div>
        <div class="stat-value text-accent">1.2K</div>
        <div class="stat-desc">Este mês</div>
      </div>
    </div>
    """
  end

  def handle_event("handle_job_click", %{"id" => job_id}, socket) do
    socket =
      socket
      |> push_navigate(to: ~p"/estagios/#{job_id}")

    {:noreply, socket}
  end
end
