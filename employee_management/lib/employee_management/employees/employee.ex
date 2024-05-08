defmodule EmployeeManagement.Employees.Employee do
  use Ecto.Schema
  import Ecto.Changeset

  schema "employees" do
    field :name, :string
    field :address, :string
    field :phone, :string
    field :email, :string
    field :birth_date, :date
    field :department, :string
    field :contract_type, :string
    field :join_date, :date

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(employee, attrs) do
    employee
    |> cast(attrs, [
      :name,
      :address,
      :phone,
      :email,
      :birth_date,
      :department,
      :contract_type,
      :join_date
    ])
    |> validate_required([
      :name,
      :address,
      :phone,
      :email,
      :birth_date,
      :department,
      :contract_type,
      :join_date
    ])
    |> validate_inclusion(:contract_type, ["full_time", "contract", "part_time"])
  end
end
