defmodule Exnumerator.KeywordListEnum do
  def cast(values, term) do
    atom_term = if is_binary(term), do: String.to_atom(term), else: term

    if Keyword.has_key?(values, atom_term) do
      {:ok, atom_term}
    else
      find_value(values, term)
    end
  end

  def load(values, term), do: find_value(values, term)

  def dump(values, term) do
    atom_term = if is_binary(term), do: String.to_atom(term), else: term

    if value = Keyword.get(values, atom_term) do
      {:ok, value}
    else
      with {:ok, key} <- find_value(values, term), do: {:ok, Keyword.get(values, key)}
    end
  end

  defp find_value(values, term) do
    found_element = Enum.find(values, fn {_key, value} -> value == term end)

    case found_element do
      nil -> :error
      {key, _value} -> {:ok, key}
    end
  end
end
