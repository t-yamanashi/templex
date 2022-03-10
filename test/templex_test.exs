defmodule TemplexTest do
  use ExUnit.Case
  doctest Templex

  def dmy_data do
    """
    a,b
    c,d
    """
  end

  def dmy_temp(x) do
    """
    0: #{x[0]}
    1: #{x[1]}
    """
  end
end
