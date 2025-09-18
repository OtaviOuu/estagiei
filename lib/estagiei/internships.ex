defmodule Estagiei.Internships do
  alias Estagiei.Internships.Repositories.InternshipRepository

  defdelegate list_internships(opts \\ []), to: InternshipRepository, as: :list_internships
  defdelegate get_internship!(id), to: InternshipRepository, as: :get_internship!

  defdelegate subscribe_to_new_internship_events,
    to: Estagiei.Internships.Events.NewInternship,
    as: :subscribe

  # sei lá se é bom isso
  defdelegate get_internship_by_slug!(slug),
    to: InternshipRepository,
    as: :get_internship_by_slug!

  defdelegate create_internship(attrs), to: InternshipRepository, as: :create_internship
end
