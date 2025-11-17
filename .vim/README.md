# Personal Vim settings

## Dependencies

To use this config, first download some dependencies:

```sh
# Vim-plug
sh -c 'curl -fLo "$HOME"/.vim/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Some runtimes are needed, install only those you don't have
sudo pacman -S nodejs npm python python-pip ruby rubygems

# Download neovim packages
sudo pacman -S python-neovim
gem install neovim
sudo npm i -g neovim

# Some other dependencies
sudo pacman -S xsel fzf ripgrep fd the_silver_searcher prettier universal-ctags
```

Then execute `:PlugInstall` inside vim and it should be ready.

## Keybindings

This are some Keybindings besides default ones:

| Key                    | Action                                 |
| ---------------------- | -------------------------------------- |
| **jk** or **kj**       | Go to normal mode (from insert)        |
| **alt + [hjkl]**       | Resize split                           |
| **control + [hjkl]**   | Navigate splits                        |
| **control + s**        | Save                                   |
| **control + q**        | Save and quit                          |
| **tab**                | Next buffer                            |
| **shift + tab**        | Previous buffer                        |
| **control + b**        | Close buffer                           |
| **shift + <** or **>** | Indent one level or remove it (visual) |

**_Plugin keybindings_**:

| Key           | Action                                        |
| ------------- | --------------------------------------------- |
| **space + f** | Fuzzy search                                  |
| **space + /** | Comment selected line or block                |
| **space + n** | Toggle NerdTree                               |
| **space + p** | Format document with prettier                 |
| **shift + k** | Function or class documentation and arg types |
