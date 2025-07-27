# vimmers
This vim enhancement package sets up various vim parameter configurations and functions and most importantly helps installing vim plugins from github via vim-plug. More about vim-plug at https://github.com/junegunn/vim-plug.

# Installation
Using basherbee ```basherbee install chetanc10/vimmers```  

# Features
## c10vimrc
Various vim controls and key-mappings are sourced to enhance vim experience.
- code browsing: tab resized to 4 spaces, diff mode keymap, cursor-line keymap, cscope-quickfix keymaps, vimgrep keymaps
- window management: Shift through multiple vim splits
- save/exit controls: keymaps to save and/or exit files in insert and normal modes
- disable bell: disable audio/visual indicators on vim action errors
and other minor keymaps/controls.. Refer to c10vimrc for each control/keymap

## vim-plug-vimrc
Provides a pre-defined list of very useful installed by default when installing vimmers package. New packages are installed with ```vimplugs``` command after vimmers installation.

## vimplugs
This bash command helps with vim-plugin management (installation, updates and removal) of vim plugins. Do ```vimplugs -h``` for more.

## vimpro.vim
This is an extension for vimrc to help with few common features. It's recommended to use ```vimpro``` bash command which invokes vimpro.vim on demand and has easier command line approach.

## vimpro
This bash command uses vimpro.vim and command line arguments to act on 1 or more files. Following operations are possible with vimpro.
- Indent single file
- Indent all files in a directory
- Replace string in a file
- Replace string in all files in a directory
- Replace print/log functions with syslog in a file (linux code only!)
- Replace print/log functions with syslog in all files in a directory (linux code only!)
