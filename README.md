# SampleInky

A sample application showing basic use of the Inky eInk display library.

## Getting started on host development

There is a library called `inky_host_dev` which helps with rendering things locally for development. You need to run without halting for this, so either `mix run --no-halt` or `iex -S mix` or the display will blink past.

```
mix deps.get
mix run --no-halt # or iex -S mix
```

## Burning firmware to device

To start your Nerves app:
  * `export MIX_TARGET=my_target` or prefix every command with
    `MIX_TARGET=my_target`. For example, `MIX_TARGET=rpi0`
  * Install dependencies with `mix deps.get`
  * Create firmware with `mix firmware`
  * Burn to an SD card with `mix firmware.burn`
