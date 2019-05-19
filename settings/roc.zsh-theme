# Git Info
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[white]%}on%{$reset_color%} %{$fg[cyan]%}git%{$fg[white]%}:%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔"

: <<'FORMAT'
Prompt format:

PRIVILEGES USER @ MACHINE in DIRECTORY on git:BRANCH STATE [TIME]
COMMAND


FORMAT

PROMPT="%{$fg_bold[green]%}♨  %{$reset_color%}\
%{$fg[cyan]%}%n\
%{$fg[white]%}@\
%{$fg[green]%}%m \
%{$fg[white]%}in \
%{$fg_bold[yellow]%}%~%{$reset_color%}\
${git_info} \
%{$fg[white]%}[%*]
%{$fg[yellow]%}♬  %{$reset_color%}"
