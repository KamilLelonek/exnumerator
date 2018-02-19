defmodule Exnumerator.AtomListEnum do
  def cast(values, term), do: transform(values, term, atom_term(term))
  def load(values, term), do: transform(values, term, atom_term(term))
  def dump(values, term), do: transform(values, term, "#{term}")

  defp transform(values, term, result), do: maybe_term(atom_term(term) in values, result)

  defp maybe_term(true, term), do: {:ok, term}
  defp maybe_term(false, _term), do: :error

  defp atom_term(term)
       when is_binary(term),
       do: String.to_atom(term)

  defp atom_term(term), do: term
end
