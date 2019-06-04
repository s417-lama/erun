defmodule Erun do
  def main(["-e", string | args]) do
    Agent.start_link(fn -> args end, name: __MODULE__)
    Code.eval_string(string)
  end
  def main([filename | args]) do
    Agent.start_link(fn -> args end, name: __MODULE__)
    Code.eval_file(filename)
  end
  def main(_) do
    IO.puts(:stderr, """
      Usage: ./erun [options] [eval_string | file] arg1, arg2, ...

        -e eval_string          Evaluates the given eval_string
      """)
    exit({:shutdown, 1})
  end

  def args() do
    Agent.get(__MODULE__, &(&1))
  end
end
