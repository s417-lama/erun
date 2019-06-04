# Erun

Run your Elixir scripts with dependencies of your favorite Mix projects!

In Elixir scripts, you cannot use external libraries, such as [Jason](https://github.com/michalmuskala/jason), by using `elixir` command.
If you want to use functionalities of external Mix projects, you are forced to create new Mix projects to download dependencies.
You cannot even install Mix projects globally in your system.

By using `erun`, new Mix projects are not necessary for disposable scripts.
`erun` resolves the problem simply by wrapping Mix projects in escript.
If `erun` is installed with Mix dependencies you specified, you can run Elixir scripts anywhere you want.

For example, if you install `erun` with [Jason](https://github.com/michalmuskala/jason),
```sh
%{foo: "bar"}
|> Jason.encode!
|> IO.puts
```
the code above (`foo.exs`) can be executed as
```sh
$ erun foo.exs
{"foo":"bar"}
```

## Usage

1. clone
```sh
git clone git@github.com:s417-lama/erun.git
```

2. modify `mix.exs` to include dependencies you want
```elixir
  defp deps do
    [
      {:super_package, "~> 1.0"},
      ...
    ]
  end
```

3. get deps
```sh
mix deps.get
```

4. compile and install
```sh
mix escript.install
```

5. try to run
```sh
$ erun -e "IO.puts :hello"
hello
```

## Args

By calling `Erun.args/0`, you can get commandline arguments.

If you save the code below
```elixir
IO.inspect Erun.args
```
as `get_args.exs`, the result would be:
```sh
$ erun get_args.exs foo bar 1
["foo", "bar", "1"]
```
Args are given as a list of string.

## Implementation

The implementation is so simple.
`erun` simply calls `Code.eval_string/1` or `Code.eval_file/1`.
