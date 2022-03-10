#! /usr/bin/env elixir

Mix.install([{:csv, "~> 2.4"}])
IEx.Helpers.c("lib/templex.ex")

template_fn = fn x ->
  """
  -----------------------
  名前: #{x[1]}
  出身: #{x[0]}
  """
end

"""
北海道,田中
沖縄,木下
"""
|> Templex.create_data()
|> Templex.create_sentence(template_fn)
|> IO.puts
