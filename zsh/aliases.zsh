alias ls='lsd'
alias la='ls -a'
alias ll='ls -al'
alias lt='ls --tree'

alias grep='grep --color=auto'

alias mm="docker-compose run --rm app sh -c 'python manage.py makemigrations'"
alias m="docker-compose run --rm app sh -c 'python manage.py migrate'"
alias dcb="docker-compose build"
alias dcu="docker-compose up"
alias dcub="docker-compose up --build"
alias dumpdata="docker-compose run --rm app sh -c 'python manage.py dumpdata --exclude=auth --exclude=contenttypes -v 1 --indent=2 -o data.json'"
alias loaddata="docker-compose run --rm app sh -c 'python manage.py load_data'"
alias createsu="docker-compose run --rm app sh -c 'python manage.py createsuperuser'"

alias cps='sudo cp config.def.h config.h'
alias smki='sudo make clean install'

t() {
	if [[ $# -eq 0 ]]; then
		tmux
	elif [[ "$1" =~ ^[0-9]+$ ]]; then
		tmux a -t $1
	else
		tmux $1
	fi
}
