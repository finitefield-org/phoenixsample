defmodule EmployeeManagement.Repo.Migrations.CreateEmployees do
  use Ecto.Migration

  def change do
    create table(:employees) do
      add :name, :string
      add :address, :string
      add :phone, :string
      add :email, :string
      add :birth_date, :date
      add :department, :string
      add :contract_type, :string
      add :join_date, :date

      timestamps(type: :utc_datetime)
    end
  end
end
