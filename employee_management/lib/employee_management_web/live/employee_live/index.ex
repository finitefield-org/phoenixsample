defmodule EmployeeManagementWeb.EmployeeLive.Index do
  use EmployeeManagementWeb, :live_view

  alias EmployeeManagement.Employees
  alias EmployeeManagement.Employees.Employee
  alias EmployeeManagement.ContractType

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:search_form, to_form(%{"contract_type" => ""}))
      |> stream(:employees, Employees.list_employees())

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Employee")
    |> assign(:employee, Employees.get_employee!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Employee")
    |> assign(:employee, %Employee{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Employees")
    |> assign(:employee, nil)
  end

  @impl true
  def handle_info({EmployeeManagementWeb.EmployeeLive.FormComponent, {:saved, employee}}, socket) do
    {:noreply, stream_insert(socket, :employees, employee)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    employee = Employees.get_employee!(id)
    {:ok, _} = Employees.delete_employee(employee)

    {:noreply, stream_delete(socket, :employees, employee)}
  end

  @impl true
  def handle_event("search", search_params, socket) do
    employees = Employees.list_employees(search_params)

    socket =
      socket
      |> assign(:search_form, to_form(search_params))
      |> stream(:employees, employees, reset: true)

    dbg(employees)
    {:noreply, socket}
  end
end
