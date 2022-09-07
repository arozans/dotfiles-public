jt(){
	first_arg=$1
	second_arg=$2
	shift
	shift
	rest_args="$@"
	task mod $first_arg -in -inthe +work pro:$second_arg $rest_args 
}
taskopen(){
        first_arg=$1
        echo $first_arg
        open $(task _get $first_arg.annotations.${2-1}.description)
}
jiraopen(){
        first_arg=$1
        echo $first_arg
        open $(task _get $first_arg.jiraurl)
}
wttr()
{
	local request="wttr.in/${1-Warsaw}"
	request+='?Fq'
	[ "$(tput cols)" -lt 125 ] && request+='n'
	curl -H "Accept-Language: ${LANG%_*}" --compressed "$request"
}
ff()
{
	local dir="${@-$(PWD)}"
	local resolved_dir=$(fasd ${dir} -dl -1)
	python3  "$HOME"/.config/custom_scripts/fullpath.py $resolved_dir | fzf --height 30% --preview 'bat --style=full --color=always --line-range :25 "$(cut -c20- <(echo {}))" 2>/dev/null || tree -C "$(cut -c20- <(echo {}))"' --keep-right |  >/dev/null 2>&1  | cut -c20-  # | tee >(tr -d '\n' | pbcopy)
}
ffp()
{
	dir="${@-$(PWD)}"

        if [ -z "$dir" ]
        then
	       dir="$PWD"
        fi

	local selected_file="$(ff "$dir")"

	if [ -f "$selected_file" ]
	then
		cd "$(python3 "$HOME"/.config/custom_scripts/parent_dir_adder.py $selected_file)" # && echo "$(PWD)/$(ls -A)" | tr -d '\n' | pbcopy
	elif [ -d "$selected_file" ]
	then
		cd $selected_file
	fi
}
ffc()
{
	realpath "$1" | tee >(tr -d '\n' | pbcopy)
}
ffm()
{
	mv "$(ff "$1")" .
}
wat()
{
	csvlook -I "$@" | less -S
}
rec()
{
	fasd -$1 -t -l -R | fzf --height 30% --preview 'bat --style=full --color=always --line-range :25 {} 2>/dev/null || tree -C {}' --keep-right |  >/dev/null 2>&1  | tee >(tr -d '\n' | pbcopy)
}
sql_values()
{
	local tmp_file="$(mktemp)"
	cat - | python3 /Users/antoni.rozanski/.config/custom_scripts/sql_values_creator.py >> $tmp_file
	echo $tmp_file
}
clipboard_values()
{
	cat $(pbpaste | sql_values) | tee >(pbcopy) | tr -cd \( | wc -c |  awk '{print "Your new values block contains " $1 " entries. yay"}'
}
review()
{
	git reset --hard && git checkout master && git pull && ( git checkout "$1"_rv 2>/dev/null || git checkout -b "$1"_rv origin/"$1" ) && git pull && git reset --soft $(git merge-base HEAD origin/master)
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
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
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
