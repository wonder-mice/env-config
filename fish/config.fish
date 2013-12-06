# @env-config-doc * fish: cute hello kitty to welcome you in a new shell
function fish_greeting
	echo " /\_/\ "
	echo "( o.o )  ><((((o>"
	echo " > ^ < "
end

# @env-config-doc * fish: git branch name in command prompt
function envconfig_git_branch
	echo (git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1] /")
end

# @env-config-doc * fish: minimalistic command prompt (current dir name only)
function fish_prompt
	set_color blue
	echo -n (envconfig_git_branch)
    set_color green
    echo -n (basename (pwd))
    set_color normal
    echo -n '$ '
end

# @env-config-doc * fish: "l" for "ls -lah"
alias l="ls -lah"
