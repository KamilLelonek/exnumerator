defmodule Exnumerator.StringListEnum do
  def cast(values, term), do: transform(values, term)
  def load(values, term), do: transform(values, term)
  def dump(values, term), do: transform(values, term)

  defp transform(values, term), do: maybe_term(term in values, term)

  defp maybe_term(true, term), do: {:ok, term}
  defp maybe_term(false, _term), do: :error
end
