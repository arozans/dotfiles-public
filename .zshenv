jt (){
	first_arg=$1
	second_arg=$2
	shift
	shift
	rest_args="$@"
	task mod $first_arg -in -inthe -hass -personal pro:$second_arg $rest_args 
}

wttr()
{
	local request="wttr.in/${1-Warsaw}"
	request+='?Fq'
	[ "$(tput cols)" -lt 125 ] && request+='n'
	curl -H "Accept-Language: ${LANG%_*}" --compressed "$request"
}

# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() {
  IFS=$'\n' out=("$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
echo $key
    [ "$key" = ctrl-o ] && xdg-open "$file" || ${EDITOR:-vim} "$file"
  fi
}

# c - browse chrome history
# from: https://junegunn.kr/2015/04/browsing-chrome-history-with-fzf/
c() {
  local cols sep
  cols=$(( COLUMNS / 3 ))
  sep='{::}'

  cp -f ~/.config/google-chrome/Default/History /tmp/h

  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
  awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
  fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs open
}
       
timem() {
source ~/r/timemerger/venv/bin/activate
export PYTHONPATH=$PYTHONPATH:/home/ant/r/timemerger
}

#assign taskw task to the timew entry
assign(){
     taskw_id=$1
     timew_id=$2
     uuid="$(task _get $taskw_id.uuid)"
     desc="$(task _get $taskw_id.description)"
     echo "Adding tags: $uuid and $desc"
     timew_act="$(timew summary :ids 2d before tomorrow | grep $timew_id | tr -s ' ')"
     echo "To timew entry: $timew_act"
     timew tag $timew_id "$uuid" "$desc"
}
tisum()
{
	days=${1:-2}
	all_args=("$@")
	rest_args=("${all_args[@]:1}")
	timew summary :ids "$days"d before tomorrow $rest_args
}
