defmodule Estagiei.Internships do
  alias Estagiei.Internships.Repositories.InternshipRepository

  defdelegate list_internships, to: InternshipRepository, as: :list_internships
end
