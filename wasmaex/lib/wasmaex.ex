defmodule Wasmaex do
  @moduledoc """
  Documentation for `Wasmaex`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Wasmaex.hello()
      :world

  """
  def hello do
    bytes =
      File.read!("../wasmaru/target/wasm32-unknown-unknown/release/wasmaru.wasm")

    # starts a GenServer running a Wasm instance
    {:ok, pid} = Wasmex.start_link(%{bytes: bytes})
    {:ok, [42]} == Wasmex.call_function(pid, "sum", [50, -8])
  end
end
