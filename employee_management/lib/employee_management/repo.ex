defmodule EmployeeManagement.Repo do
  use Ecto.Repo,
    otp_app: :employee_management,
    adapter: Ecto.Adapters.Postgres
end
