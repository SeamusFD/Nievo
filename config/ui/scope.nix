{ plugins, ... }:
{
  pkg = plugins.scope-nvim;
  name = "scope-nvim";
  event = "VeryLazy";
}
