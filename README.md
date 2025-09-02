Before everything install packer by:

    git clone --depth 1 https://github.com/wbthomason/packer.nvim\ ~/.local/share/nvim/site/pack/packer/start/packer.nvim

To make telescope work install:

    sudo apt-get install ripgrep

Get nerd fonts [here](https://www.nerdfonts.com/font-downloads) to make nvim tree icons work:
This will automatically install 0xProto font:

    cd ~/.local/share/fonts
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/0xProto.zip
    unzip 0xProto.zip
    rm 0xProto.zip LICENSE README.md

Then run nvim an use:

    :PackerSync

Install lsps with `:Mason`:

1. lua-language-server
2. clangd 
