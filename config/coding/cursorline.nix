{ plugins, ... }:
{
  pkg = plugins.nvim-cursorline;
  event = "VeryLazy";
  config = true;
}
