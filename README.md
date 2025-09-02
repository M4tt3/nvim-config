# Dependencies

First of all install `lua5.1` and [`luarocks`](https://luarocks.org/) for `lazy.nvim` to work:

    sudo apt install lua5.1 liblua5.1-dev
    wget https://luarocks.org/releases/luarocks-3.12.2.tar.gz
    tar zxpf luarocks-3.12.2.tar.gz
    cd luarocks-3.12.2
    ./configure && make && sudo make install
    sudo luarocks install luasocket

Check that everything worked fine:
    
    lua
    Lua 5.1.5  Copyright (C) 1994-2012 Lua.org, PUC-Rio
    > require "socket"

Then install dependencies for `clangd`:
    
    sudo apt install clang libstdc++-12-dev libstdc++-11-dev

*NOTE*: Look for all the versions of gcc in `/usr/bin/` and install approprate 'libstdc` library.

To make telescope work install:

    sudo apt-get install ripgrep

Get nerd fonts [here](https://www.nerdfonts.com/font-downloads) to make nvim tree icons work:
This will automatically install 0xProto font:

    cd ~/.local/share/fonts
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/0xProto.zip
    unzip 0xProto.zip
    rm 0xProto.zip LICENSE README.md

