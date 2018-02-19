defmodule Exnumerator.KeywordListEnum do
  def cast(values, term) do
    with atom_term = atom_term(term), true <- Keyword.has_key?(values, atom_term) do
      {:ok, atom_term}
    else
      _ -> find_value(values, term)
    end
  end

  def load(values, term), do: find_value(values, term)

  def dump(values, term) do
    with nil <- Keyword.get(values, atom_term(term)),
         {:ok, key} <- find_value(values, term) do
      {:ok, Keyword.get(values, key)}
    else
      :error -> :error
      value -> {:ok, value}
    end
  end

  defp atom_term(term)
       when is_binary(term),
       do: String.to_atom(term)

  defp atom_term(term), do: term

  defp find_value(values, term) do
    with {key, _value} <- key_by_value(values, term), do: {:ok, key}
  end

  defp key_by_value(values, term), do: Enum.find(values, :error, &matching(term, &1))

  defp matching(term, {_key, term}), do: true
  defp matching(_term, _tuple), do: false
end
