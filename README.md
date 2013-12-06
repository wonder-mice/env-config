env-config
==========
Configure your unix tools once and forever.

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
 * readline: vi editing mode
 * bash: cute hello kitty to welcome you in a new shell
 * bash: vim as default editor
 * bash: minimalistic command prompt (current dir name only)
 * bash: git branch name in command prompt
 * bash: bash-prompt-mark - mark command prompt with text note
 * bash: add color (ls, grep, ...)
 * bash: "l" for "ls -lah"
 * bash: command complition for git
 * bash: command complition for subversion
 * fish: cute hello kitty to welcome you in a new shell
 * fish: git branch name in command prompt
 * fish: minimalistic command prompt (current dir name only)
 * fish: "l" for "ls -lah"
 * vim: syntax highlighting
 * vim: store backup files in ~/.vim/backup
 * vim: store swap files in ~/.vim/swap
 * git: "git st" for "git status"
 * git: "git df" for "git diff"
 * git: "git dfc" for "git diff --cached"
 * git: "git lol" and "git lola" for awesome formated log
 * git: add color
 * tool: x - numerate command output for later reference
 * tool: getpassword - securely pass sensitive data via command arguments
Done!
$ # exit and create new terminal tab or window
```

The nice thing about this is that env-config tries to apply minimal
modifications to existing files and to store all its files in one place.
Only following files will be modified by appending small (2-3 lines) piece of
initialization code (to source/include original configuration file):
* ~/.inputrc
* ~/.bashrc
* ~/.config/fish/config.fish
* ~/.vimrc
* ~/.gitconfig

All copied files will be put into ~/.env-config directory.

Configuration of following tools is available out of the box:
 * readline library (http://cnswww.cns.cwru.edu/php/chet/readline/rltop.html)
 * bash shell (http://www.gnu.org/software/bash/)
 * fish shell (http://fishshell.com/)
 * vim (http://www.vim.org/)
 * git (http://git-scm.com/)
