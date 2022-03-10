defmodule Templex do
  @moduledoc """
  Documentation for `Templex`.
  """

  @doc """

  ## Examples

      iex> TemplexTest.dmy_data()
      iex> |> Templex.create_data()
      %{0 => %{0 => "a", 1 => "b"}, 1 => %{0 => "c", 1 => "d"}}

  """
  def create_data(data) do
    data
    |> String.split(~r/\n/)
    |> Enum.filter(&(&1 != ""))
    |> CSV.decode()
    |> Enum.map(&elem(&1, 1))
    |> Enum.map(&Enum.with_index(&1))
    |> Enum.map(fn kv ->
      Enum.map(kv, fn x -> %{elem(x, 1) => elem(x, 0)} end)
      |> Enum.reduce(&Map.merge(&1, &2))
    end)
    |> Enum.with_index()
    |> Enum.map(&%{elem(&1, 1) => elem(&1, 0)})
    |> Enum.reduce(&Map.merge(&1, &2))
  end

  @doc """

  ## Examples

      iex> TemplexTest.dmy_data()
      iex> |> Templex.create_data()
      iex> |> Templex.create_sentence(&TemplexTest.dmy_temp/1)
      \"0: a\\n1: b\\n0: c\\n1: d\\n\"

  """
  def create_sentence(data, template_fn) do
    data
    |> Enum.reduce("", fn x, acc ->
      x = elem(x, 1)
      acc <> template_fn.(x)
    end)
  end
end
