defmodule Estagiei.Internships do
  alias Estagiei.Internships.Repositories.InternshipRepository

  defdelegate list_internships, to: InternshipRepository, as: :list_internships
  defdelegate get_internship!(id), to: InternshipRepository, as: :get_internship!
  # sei lá se é bom isso
  defdelegate get_internship_by_slug!(slug),
    to: InternshipRepository,
    as: :get_internship_by_slug!

  defdelegate create_internship(attrs), to: InternshipRepository, as: :create_internship
end
