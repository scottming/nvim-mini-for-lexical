# neovim config for Lexical

This is a minimal configuration for a custom LS in neovim. The key is to append the custom LS configuration to lspconfig, so regardless of whether you are using mason or others, you can use this repository's minimal configuration as a reference.

## Installation

```bash
$ git clone git@github.com:scottming/nvim-mini-for-lexical.git ~/.config/nvim-mini-for-lexical
```

Change the `cmd` path: https://github.com/scottming/nvim-mini-for-lexical/blob/master/init.lua#L16, then open a Elixir project file generated by `mix`:

```
$ mix new ~/Code/dummy
$ NVIM_APPNAME=nvim-mini-for-lexical nvim ~/Code/dummy/test/dummy_test.exs
```

press `<space>`, `l`, `i`, you should see the Lexical attached
