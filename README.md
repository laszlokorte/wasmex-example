# Wasmaex

This is a simple experiment to communicate between [Rust](https://www.rust-lang.org/) and [Elixir](https://www.elixir-lang.org/) via [WebAssembly](https://webassembly.org/) using the Elixir [WasmEx](https://hexdocs.pm/wasmex/Wasmex.html) module.

## Quick run

```sh
pushd wasmaru; cargo build --target wasm32-wasip2; popd;
pushd wasmaex; mix run -e 'Wasmaex.hello(\"Ada\")'; popd;
```

## Compile Rust to Wasm

```sh
$ cd wasmaru
$ cargo build --target wasm32-wasip2
```

This compiles the [`wasmaru/src/lib.rs`](./wasmaru/src/lib.rs) file into a [Wasm component](https://component-model.bytecodealliance.org) `wasm` file.
The component interface is defined in [`wasmaru/wit/host.wit`](wasmaru/wit/host.wit).

## Run Elixir Module

```sh
$ mix deps.get # Installs dependencies
$ mix run -e 'Wasmaex.hello(\"Ada\")'
# Rust called the Elixir my_print function with str:
# [lib/wasmaex.ex:36: Wasmaex.my_print/1]
# str #=> "Hello, Ada!"
#
# Rust returned the length of your name: 3
```

```sh
$ mix test # alternatively run unit tests
```

The `Wasmaex` module reads the `wasm` file, starts a Wasm Interpreter as a GenServer and passes the given name as
string to the wasm module. This is handled by the `{:wasmex, "~> 0.13.0"}` Elixir package.

## Prerequisites

The rust compiler target [`wasm32-wasip1`](https://doc.rust-lang.org/rustc/platform-support/wasm32-wasip1.html) must be installed:

```sh
rustup target add wasm32-wasip1
```
