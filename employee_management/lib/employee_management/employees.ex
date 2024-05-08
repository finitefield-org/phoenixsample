defmodule EmployeeManagement.Employees do
  @moduledoc """
  The Employees context.
  """

  import Ecto.Query, warn: false
  alias EmployeeManagement.Repo

  alias EmployeeManagement.Employees.Employee

  @doc """
  Returns the list of employees.

  ## Examples

      iex> list_employees()
      [%Employee{}, ...]

  """
  def list_employees(params) do
    query = from(e in Employee)

    query =
      if params["contract_type"] in ["full_time", "contract", "part_time"] do
        from e in query, where: e.contract_type == ^params["contract_type"]
      else
        query
      end

    query =
      if params["department"] != "" do
        from e in query, where: e.department == ^params["department"]
      else
        query
      end

    query =
      if params["join_date_from"] != "" do
        from e in query, where: e.join_date >= ^params["join_date_from"]
      else
        query
      end

    query =
      if params["join_date_to"] != "" do
        from e in query, where: e.join_date <= ^params["join_date_to"]
      else
        query
      end

    Repo.all(query)
  end

  def list_employees() do
    Repo.all(Employee)
  end

  @doc """
  Gets a single employee.

  Raises `Ecto.NoResultsError` if the Employee does not exist.

  ## Examples

      iex> get_employee!(123)
      %Employee{}

      iex> get_employee!(456)
      ** (Ecto.NoResultsError)

  """
  def get_employee!(id), do: Repo.get!(Employee, id)

  @doc """
  Creates a employee.

  ## Examples

      iex> create_employee(%{field: value})
      {:ok, %Employee{}}

      iex> create_employee(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_employee(attrs \\ %{}) do
    %Employee{}
    |> Employee.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a employee.

  ## Examples

      iex> update_employee(employee, %{field: new_value})
      {:ok, %Employee{}}

      iex> update_employee(employee, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_employee(%Employee{} = employee, attrs) do
    employee
    |> Employee.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a employee.

  ## Examples

      iex> delete_employee(employee)
      {:ok, %Employee{}}

      iex> delete_employee(employee)
      {:error, %Ecto.Changeset{}}

  """
  def delete_employee(%Employee{} = employee) do
    Repo.delete(employee)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking employee changes.

  ## Examples

      iex> change_employee(employee)
      %Ecto.Changeset{data: %Employee{}}

  """
  def change_employee(%Employee{} = employee, attrs \\ %{}) do
    Employee.changeset(employee, attrs)
  end
end
