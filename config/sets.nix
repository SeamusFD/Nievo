{ ...
}: {
  config = {
    opts = {
      # Enable relative line numbers
      number = true;

      clipboard = "unnamedplus";
      confirm = true;
      wrap = false;
      showmode = false;

      # Set tabs to 2 spaces
      shiftwidth = 2;
      shiftround = true;
      tabstop = 2;
      smartindent = true;
      expandtab = true;

      mouse = "a";

      # Enable incremental searching
      hlsearch = true;
      incsearch = true;

      pumblend = 10;
      pumheight = 10;

      # Enable ignorecase + smartcase for better searching
      ignorecase = true;
      smartcase = true; # Don't ignore case with capitals

      # Decrease updatetime
      updatetime = 50; # faster completion (4000ms default)

      # Enable persistent undo history
      swapfile = false;
      backup = false;
      undofile = true;

      # Enable 24-bit colors
      termguicolors = true;

      # Always keep 8 lines above/below cursor unless at start/end of file
      scrolloff = 8;

      # Reduce which-key timeout to 10ms
      timeoutlen = 10;

      # Set encoding type
      encoding = "utf-8";
      fileencoding = "utf-8";
      # Enable chars list
      list = true; # Show invisible characters (tabs, eol, ...)
      #listchars = "tab:|->,lead:·,space: ,trail:•,extends:→,precedes:←,nbsp:␣";

      # More space in the neovim command line for displaying messages
      cmdheight = 2;
      laststatus = 3; # (https://neovim.io/doc/user/options.html#'laststatus')
    };
  };
}
