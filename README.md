env-config
==========
Configuring your unix work environment simplified.

It's a single place to store configuration files and favorite scripts
with ability to deploy them instantly on unix host. Several seconds and
unix environment is configured and ready for work. Tested on Mac OS X and
Linux.

First - fork it! Obviously you have preferences that doesn't match defaults.
You will also want to add some more vim plugins, bash completions, scripts
and other cool stuff. This document will use link to this repository
(https://github.com/wonder-mice/env-config.git)
assuming that it must be replaced with its fork.

After fork you have very little to do:
```bash
$ git clone https://github.com/wonder-mice/env-config.git env-config.git
$ ./env-config.git/install
 * Vi editing mode for readline library (bash, gdb, ...)
 * Cute hello kitty to welcome you in a new shell
 * Minimalistic bash command prompt (current dir name only)
 * Git branch name in bash command prompt
 * Add color to console programs (ls, grep, ...)
 * Bash command complition for git
 * Bash command complition for subversion
 * Syntax highlighting in Vim
 * Vim will store backup files in ~/.vim/backup
 * Vim will store swap files in ~/.vim/swap
 * Use "git st" for "git status"
 * Use "git df" for "git diff"
 * Use "git dfc" for "git diff --cached"
 * Use "git lol" for awesome formated git log (also try "git lol --all")
 * Add colors to git output
 * x tool to numerate command output for later reference (try "x -")
Done!
$ # exit and create new terminal tab or window
```

The nice thing about this is that env-config tries to apply minimal
modifications to existing files and to store all its files in one place.
Only following files will be modified by appending small (2-3 lines) piece of
initialization code (to source/include original configuration file):
* ~/.inputrc
* ~/.bashrc
* ~/.vimrc
* ~/.gitconfig

All copied files will be put into ~/.env-config directory.
