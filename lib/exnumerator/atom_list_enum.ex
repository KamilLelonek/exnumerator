defmodule Exnumerator.AtomListEnum do
  def cast(values, term) when is_binary(term) do
    atom_term = String.to_atom(term)
    cast(values, atom_term)
  end

  def cast(values, term) do
    if term in values do
      {:ok, term}
    else
      :error
    end
  end

  def load(values, term) when is_binary(term) do
    atom_term = String.to_atom(term)
    load(values, atom_term)
  end

  def load(values, term) do
    if term in values do
      {:ok, term}
    else
      :error
    end
  end

  def dump(values, term) when is_binary(term) do
    atom_term = String.to_atom(term)
    dump(values, atom_term)
  end

  def dump(values, term) do
    if term in values do
      {:ok, Atom.to_string(term)}
    else
      :error
    end
  end
end
