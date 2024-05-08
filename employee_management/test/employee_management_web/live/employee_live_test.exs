defmodule EmployeeManagementWeb.EmployeeLiveTest do
  use EmployeeManagementWeb.ConnCase

  import Phoenix.LiveViewTest
  import EmployeeManagement.EmployeesFixtures

  @create_attrs %{name: "some name", address: "some address", phone: "some phone", email: "some email", birth_date: "2024-05-06", department: "some department", contract_type: "some contract_type", join_date: "2024-05-06"}
  @update_attrs %{name: "some updated name", address: "some updated address", phone: "some updated phone", email: "some updated email", birth_date: "2024-05-07", department: "some updated department", contract_type: "some updated contract_type", join_date: "2024-05-07"}
  @invalid_attrs %{name: nil, address: nil, phone: nil, email: nil, birth_date: nil, department: nil, contract_type: nil, join_date: nil}

  defp create_employee(_) do
    employee = employee_fixture()
    %{employee: employee}
  end

  describe "Index" do
    setup [:create_employee]

    test "lists all employees", %{conn: conn, employee: employee} do
      {:ok, _index_live, html} = live(conn, ~p"/employees")

      assert html =~ "Listing Employees"
      assert html =~ employee.name
    end

    test "saves new employee", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/employees")

      assert index_live |> element("a", "New Employee") |> render_click() =~
               "New Employee"

      assert_patch(index_live, ~p"/employees/new")

      assert index_live
             |> form("#employee-form", employee: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#employee-form", employee: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/employees")

      html = render(index_live)
      assert html =~ "Employee created successfully"
      assert html =~ "some name"
    end

    test "updates employee in listing", %{conn: conn, employee: employee} do
      {:ok, index_live, _html} = live(conn, ~p"/employees")

      assert index_live |> element("#employees-#{employee.id} a", "Edit") |> render_click() =~
               "Edit Employee"

      assert_patch(index_live, ~p"/employees/#{employee}/edit")

      assert index_live
             |> form("#employee-form", employee: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#employee-form", employee: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/employees")

      html = render(index_live)
      assert html =~ "Employee updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes employee in listing", %{conn: conn, employee: employee} do
      {:ok, index_live, _html} = live(conn, ~p"/employees")

      assert index_live |> element("#employees-#{employee.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#employees-#{employee.id}")
    end
  end

  describe "Show" do
    setup [:create_employee]

    test "displays employee", %{conn: conn, employee: employee} do
      {:ok, _show_live, html} = live(conn, ~p"/employees/#{employee}")

      assert html =~ "Show Employee"
      assert html =~ employee.name
    end

    test "updates employee within modal", %{conn: conn, employee: employee} do
      {:ok, show_live, _html} = live(conn, ~p"/employees/#{employee}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Employee"

      assert_patch(show_live, ~p"/employees/#{employee}/show/edit")

      assert show_live
             |> form("#employee-form", employee: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#employee-form", employee: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/employees/#{employee}")

      html = render(show_live)
      assert html =~ "Employee updated successfully"
      assert html =~ "some updated name"
    end
  end
end
