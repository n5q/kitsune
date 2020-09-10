
set SCM_THEME_PROMPT_DIRTY (set_color red)"✗"
set SCM_THEME_PROMPT_CLEAN (set_color --bold green)"✓"
set SCM_THEME_PROMPT_PREFIX (set_color --bold cyan)"("
set SCM_THEME_PROMPT_SUFFIX (set_color --bold cyan)")"(set color normal)
set -g __fish_git_prompt_show_informative_status true
set -g __fish_git_prompt_showcolorhints true

function fish_prompt
  set BC (cat /sys/class/power_supply/BAT0/capacity)
  echo -n (set_color --bold white)"╭─"
  echo -n (set_color --bold cyan)$USER@(hostname|cut -d . -f 1)
  echo -n (set_color --bold white)"─"
  echo -n (set_color --bold cyan)"("
  echo -n (set_color --bold white)(pwd)
  echo -n (set_color --bold cyan)")"
  __fish_git_prompt
  echo -e ''
  echo -n (set_color --bold white)"╰──"
  echo -n (set_color --bold cyan)"["(date '+%H:%M')"]-"
  set_color normal
  echo -n (set_color cyan)"("$BC"%)"
  echo -n (set_color --bold cyan)" - "
  if test $status -gt "0"
    echo -n (set_color --bold red)"\$ "
  else if [ (id -u) = "0" ]
    echo -n (set_color --bold green)"# "
  else if not test -e (jobs -l)
    echo -n (set_color --bold yellow)(jobs -l | wc -l) (bold_green)"\$ "
  else
    echo -n (set_color --bold green)"\$ "
  end
end

function fish_right_prompt
  set -l st $status

  if [ $st != 0 ];
    echo (set_color red) ↵ $st(set_color normal)
  end
end
