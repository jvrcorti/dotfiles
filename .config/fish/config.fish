
# Default configuration
set  fish_greeting
set TERM "xterm-256color"
set -gx EDITOR nvim

### AUTOCOMPLETE AND HIGHLIGHT COLORS ###
set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brcyan
set fish_color_error '#ff6c6b'
set fish_color_param brcyan

# Prompt Sashimi file (https://github.com/isacikgoz/sashimi.git)
# name: sashimi
function fish_prompt
  set -l last_status $status
  set -l cyan (set_color -o cyan)
  set -l yellow (set_color -o yellow)
  set -g red (set_color -o red)
  set -g blue (set_color -o blue)
  set -l green (set_color -o green)
  set -g normal (set_color magenta)

  set -l ahead (_git_ahead)
  set -g whitespace ' '

  if test $last_status = 0
    set initial_indicator "$green󰈺"
   #set status_indicator "$normal=$cyan=$green"
    set status_indicator "$green"
  else
    set initial_indicator "$red✖ $last_status"
    set status_indicator "$red"
  end
  set -l cwd $cyan(basename (prompt_pwd))

  if [ (_git_branch_name) ]

    if test (_git_branch_name) = 'main'
      set -l git_branch (_git_branch_name)
      set git_info "$normal git:($red$git_branch$normal)"
    else
      set -l git_branch (_git_branch_name)
      set git_info "$normal git:($blue$git_branch$normal)"
    end

    if [ (_is_git_dirty) ]
      set -l dirty "$yellow ✗"
      set git_info "$git_info$dirty"
    end
  end

  # Notify if a command took more than 5 minutes
  if [ "$CMD_DURATION" -gt 300000 ]
    echo The last command took (math "$CMD_DURATION/1000") seconds.
  end

  echo -n -s $initial_indicator $whitespace $cwd $git_info $whitespace $ahead $status_indicator $whitespace
end

function _git_ahead
  set -l commits (command git rev-list --left-right '@{upstream}...HEAD' 2>/dev/null)
  if [ $status != 0 ]
    return
  end
  set -l behind (count (for arg in $commits; echo $arg; end | grep '^<'))
  set -l ahead  (count (for arg in $commits; echo $arg; end | grep -v '^<'))
  switch "$ahead $behind"
    case ''     # no upstream
    case '0 0'  # equal to upstream
      return
    case '* 0'  # ahead of upstream
      echo "$blue↑$normal_c$ahead$whitespace"
    case '0 *'  # behind upstream
      echo "$red↓$normal_c$behind$whitespace"
    case '*'    # diverged from upstream
      echo "$blue↑$normal$ahead $red↓$normal_c$behind$whitespace"
  end
end

function _git_branch_name
  echo (command git symbolic-ref HEAD 2>/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty 2>/dev/null)
end

# Functions needed for !! and !$
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

# The bindings for !! and !$
if [ "$fish_key_bindings" = "fish_vi_key_bindings" ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end


# Usefull aliases
# Replace ls with exa
alias ls='exa -al --colour=always --group-directories-first --icons' #preferred listing
alias la='exa -a --colour=always --group-directories-first --icons' #all files and dirs
alias ll='exa -l --colour=always --group-directories-first --icons' #long format
alias lt='exa -aT --colour=always --group-directories-first --icons' #tree listing
alias ..='cd ..'
alias ...='cd ../..'
alias upg='brew upgrade'
alias nfish='nvim ~/.config/fish/config.fish'
# Alias entornos virtuales activate
alias pvcac='source $HOME/Desktop/workspace/virtualenv/djangocac/bin/activate.fish'

if status is-interactive
    # Commands to run in interactive sessions can go here
    eval "$(/opt/homebrew/bin/brew shellenv)"
    source ("/opt/homebrew/bin/starship" init fish --print-full-init | psub)
    # Run Neofetch displays information
    neofetch	
end
