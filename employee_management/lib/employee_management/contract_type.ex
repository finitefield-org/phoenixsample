defmodule EmployeeManagement.ContractType do
  def get_name(contract_type) do
    case contract_type do
      "full_time" -> "正社員"
      "contract" -> "契約社員"
      "part_time" -> "派遣社員"
      _ -> ""
    end
  end
end
