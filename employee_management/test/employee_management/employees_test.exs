defmodule EmployeeManagement.EmployeesTest do
  use EmployeeManagement.DataCase

  alias EmployeeManagement.Employees

  describe "employees" do
    alias EmployeeManagement.Employees.Employee

    import EmployeeManagement.EmployeesFixtures

    @invalid_attrs %{name: nil, address: nil, phone: nil, email: nil, birth_date: nil, department: nil, contract_type: nil, join_date: nil}

    test "list_employees/0 returns all employees" do
      employee = employee_fixture()
      assert Employees.list_employees() == [employee]
    end

    test "get_employee!/1 returns the employee with given id" do
      employee = employee_fixture()
      assert Employees.get_employee!(employee.id) == employee
    end

    test "create_employee/1 with valid data creates a employee" do
      valid_attrs = %{name: "some name", address: "some address", phone: "some phone", email: "some email", birth_date: ~D[2024-05-06], department: "some department", contract_type: "some contract_type", join_date: ~D[2024-05-06]}

      assert {:ok, %Employee{} = employee} = Employees.create_employee(valid_attrs)
      assert employee.name == "some name"
      assert employee.address == "some address"
      assert employee.phone == "some phone"
      assert employee.email == "some email"
      assert employee.birth_date == ~D[2024-05-06]
      assert employee.department == "some department"
      assert employee.contract_type == "some contract_type"
      assert employee.join_date == ~D[2024-05-06]
    end

    test "create_employee/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Employees.create_employee(@invalid_attrs)
    end

    test "update_employee/2 with valid data updates the employee" do
      employee = employee_fixture()
      update_attrs = %{name: "some updated name", address: "some updated address", phone: "some updated phone", email: "some updated email", birth_date: ~D[2024-05-07], department: "some updated department", contract_type: "some updated contract_type", join_date: ~D[2024-05-07]}

      assert {:ok, %Employee{} = employee} = Employees.update_employee(employee, update_attrs)
      assert employee.name == "some updated name"
      assert employee.address == "some updated address"
      assert employee.phone == "some updated phone"
      assert employee.email == "some updated email"
      assert employee.birth_date == ~D[2024-05-07]
      assert employee.department == "some updated department"
      assert employee.contract_type == "some updated contract_type"
      assert employee.join_date == ~D[2024-05-07]
    end

    test "update_employee/2 with invalid data returns error changeset" do
      employee = employee_fixture()
      assert {:error, %Ecto.Changeset{}} = Employees.update_employee(employee, @invalid_attrs)
      assert employee == Employees.get_employee!(employee.id)
    end

    test "delete_employee/1 deletes the employee" do
      employee = employee_fixture()
      assert {:ok, %Employee{}} = Employees.delete_employee(employee)
      assert_raise Ecto.NoResultsError, fn -> Employees.get_employee!(employee.id) end
    end

    test "change_employee/1 returns a employee changeset" do
      employee = employee_fixture()
      assert %Ecto.Changeset{} = Employees.change_employee(employee)
    end
  end
end
