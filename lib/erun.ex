defmodule Erun do
  def main([]) do
    IO.puts("Usage: ./erun <filename> arg1, arg2, ...")
    exit({:shutdown, 1})
  end
  def main([filename | args]) do
    Agent.start_link(fn -> args end, name: __MODULE__)
    Code.eval_file(filename)
  end

  def args() do
    Agent.get(__MODULE__, &(&1))
  end
end
