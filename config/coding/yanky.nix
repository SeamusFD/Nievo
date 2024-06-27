{ plugins, ... }:
{
  pkg = plugins.yanky-nvim;
  event = "VeryLazy";
  config = true;
}
