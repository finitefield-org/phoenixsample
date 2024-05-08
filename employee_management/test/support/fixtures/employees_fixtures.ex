defmodule EmployeeManagement.EmployeesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `EmployeeManagement.Employees` context.
  """

  @doc """
  Generate a employee.
  """
  def employee_fixture(attrs \\ %{}) do
    {:ok, employee} =
      attrs
      |> Enum.into(%{
        address: "some address",
        birth_date: ~D[2024-05-06],
        contract_type: "some contract_type",
        department: "some department",
        email: "some email",
        join_date: ~D[2024-05-06],
        name: "some name",
        phone: "some phone"
      })
      |> EmployeeManagement.Employees.create_employee()

    employee
  end
end
