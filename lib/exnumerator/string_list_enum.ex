defmodule Exnumerator.StringListEnum do
  def cast(values, term) do
    if term in values do
      {:ok, term}
    else
      :error
    end
  end

  def load(values, term) do
    if term in values do
      {:ok, term}
    else
      :error
    end
  end

  def dump(values, term) do
    if term in values do
      {:ok, term}
    else
      :error
    end
  end
end
