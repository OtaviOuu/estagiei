defmodule EstagieiWeb.EstagioLive.Index do
  use EstagieiWeb, :live_view
  alias Estagiei.Internships

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :internships, Internships.list_internships())}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <div class="hero bg-gradient-to-r from-primary to-secondary text-primary-content py-16">
        <div class="hero-content text-center">
          <div class="max-w-md">
            <h1 class="text-5xl font-bold mb-4">Estágios</h1>
            <p class="text-lg opacity-90">Encontre as melhores oportunidades de estágio</p>
          </div>
        </div>
      </div>

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
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
          <div class="stat bg-base-100 shadow-lg rounded-box">
            <div class="stat-figure text-primary">
              <.icon name="hero-briefcase" class="w-8 h-8" />
            </div>
            <div class="stat-title">Total de Estágios</div>
            <div class="stat-value text-primary">{length(@internships)}</div>
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

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          <div
            :for={internship <- @internships}
            class="card bg-base-100 shadow-xl hover:shadow-2xl transition-all duration-300 hover:-translate-y-2"
          >
            <div class="card-body">
              <!-- Header with Company Logo/Icon -->
              <div class="flex items-start justify-between mb-4">
                <div class="flex items-center">
                  <div class="avatar placeholder mr-3">
                    <div class="bg-primary text-primary-content rounded-full w-12">
                      <span class="text-xl font-bold">{String.first(internship.title)}</span>
                    </div>
                  </div>
                  <div>
                    <h2 class="card-title text-lg font-bold line-clamp-2">
                      {internship.title}
                    </h2>
                    <p class="text-sm text-base-content/70">Empresa XYZ</p>
                  </div>
                </div>
                <div class="dropdown dropdown-end">
                  <label tabindex="0" class="btn btn-ghost btn-sm btn-circle">
                    <.icon name="hero-ellipsis-vertical" class="w-4 h-4" />
                  </label>
                  <ul
                    tabindex="0"
                    class="dropdown-content menu p-2 shadow bg-base-100 rounded-box w-52"
                  >
                    <li><a>Ver detalhes</a></li>
                    <li><a>Editar</a></li>
                    <li><a>Excluir</a></li>
                  </ul>
                </div>
              </div>

              <div class="flex flex-wrap gap-2 mb-4">
                <div class="badge badge-primary badge-sm">Tecnologia</div>
                <div class="badge badge-secondary badge-sm">Remoto</div>
                <div class="badge badge-accent badge-sm">Meio período</div>
              </div>

              <p class="text-sm text-base-content/80 mb-4 line-clamp-3">
                Oportunidade única de estágio em uma empresa inovadora. Desenvolva suas habilidades em um ambiente colaborativo e dinâmico.
              </p>

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

              <div class="card-actions justify-end">
                <button class="btn btn-ghost btn-sm">
                  <.icon name="hero-heart" class="w-4 h-4" />
                </button>
                <button class="btn btn-ghost btn-sm">
                  <.icon name="hero-share" class="w-4 h-4" />
                </button>
                <button class="btn btn-primary btn-sm">
                  Candidatar-se
                </button>
              </div>
            </div>

            <div class="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-primary to-secondary rounded-t-2xl">
            </div>
          </div>
        </div>

        <div :if={@internships == []} class="flex flex-col items-center justify-center py-16">
          <div class="text-6xl mb-4">🎯</div>
          <h3 class="text-2xl font-bold mb-2">Nenhum estágio encontrado</h3>
          <p class="text-base-content/70 mb-6 text-center max-w-md">
            Parece que não há estágios disponíveis no momento. Que tal cadastrar o primeiro?
          </p>
          <button class="btn btn-primary">
            <.icon name="hero-plus" class="w-4 h-4" /> Cadastrar Estágio
          </button>
        </div>

        <div :if={length(@internships) > 0} class="flex justify-center mt-12">
          <button class="btn btn-outline btn-wide">
            Carregar mais estágios <.icon name="hero-chevron-down" class="w-4 h-4" />
          </button>
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
end
