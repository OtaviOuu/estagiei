defmodule Estagiei.Internships do
  alias Estagiei.Internships.Repositories.InternshipRepository

  defdelegate list_internships, to: InternshipRepository, as: :list_internships
  defdelegate get_internship!(id), to: InternshipRepository, as: :get_internship!
end
