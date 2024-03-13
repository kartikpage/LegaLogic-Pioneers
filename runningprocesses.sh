function display_menu() {
	echo "1. check memory prosesses"
	echo "2. check pid"
	echo "3. exit"
}
function mem() {
	ps aux
}
function pid() {
	echo "Enter username "
	read username
	ps -u "$username" -o pid,ppid,%cpu,%mem,cmd
}
display_menu
read -r choice
case $choice in
	1)
	   mem
	   ;;
	2)
	   pid
	   ;;
	3)
	   exit 0
	   ;;	
