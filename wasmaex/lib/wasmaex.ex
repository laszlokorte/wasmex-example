defmodule Wasmaex do
  @moduledoc """
  Documentation for `Wasmaex`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Wasmaex.hello("Josy")
      4

  """
  def hello(name) when is_binary(name) do
    bytes =
      File.read!("../wasmaru/target/wasm32-wasip2/debug/wasmaru.wasm")

    {:ok, pid} =
      Wasmex.Components.start_link(%{
        bytes: bytes,
        imports: %{
          "print" => {:fn, &Wasmaex.my_print/1}
        }
      })

    {:ok, length} = pid |> GenServer.call({:call_function, "run", [name]})
    IO.puts("Rust returned the length of your name: #{length}")
    GenServer.stop(pid)

    length
  end

  def my_print(str) do
    IO.puts("Rust called the Elixir my_print function with str:")
    dbg(str)
  end
end
