alias ls='ls --color=auto'
alias ll='ls -al --color=auto'
alias grep='grep --color=auto'

alias slim_prod="ssh -i ~/projects/iotecbol/SLM/keys/dev1.iotecbol.com_key.pem azureuser@52.150.16.68"
alias slim_dev="ssh -i ~/projects/iotecbol/SLM/keys/dev6.iotecbol.com_key.pem azureuser@52.146.36.9"
alias slim_demo="ssh -i ~/projects/iotecbol/SLM/keys/test-iotecbol-vm_key.pem azureuser@172.174.254.36"
alias slim_seattle="ssh -i ~/Documents/iotecbol/prod-eus1-vm-1_key.pem iotecbol@20.55.101.99"

alias get_prod_data="scp -i ~/projects/iotecbol/SLM/keys/dev1.iotecbol.com_key.pem azureuser@52.150.16.68:/home/azureuser/SLM/slim_api/app/data.json ~/Downloads/production_data.json"
alias get_prod_data="scp -i ~/projects/iotecbol/SLM/keys/dev6.iotecbol.com_key.pem azureuser@52.146.36.9:/home/azureuser/SLM/slim_api/app/data.json ~/Downloads/dev_data.json"
alias get_demo_data="scp -i ~/projects/iotecbol/SLM/keys/test-iotecbol-vm_key.pem azureuser@172.174.254.36:/home/azureuser/SLM/slim_api/app/data.json ~/Downloads/demo_data.json"
alias get_seattle_data="scp -i ~/Documents/work/iotecbol/io_keys/prod-eus1-vm-1_key.pem iotecbol@20.55.101.99:/home/iotecbol/SLM/slim_api/app/data.json ~/Downloads/seattle_data.json"

alias mm="docker-compose run --rm app sh -c 'python manage.py makemigrations'"
alias m="docker-compose run --rm app sh -c 'python manage.py migrate'"
alias dcb="docker-compose build"
alias dcu="docker-compose up"
alias dcub="docker-compose up --build"
alias dumpdata="docker-compose run --rm app sh -c 'python manage.py dumpdata --exclude=auth --exclude=contenttypes -v 1 --indent=2 -o data.json'"
alias loaddata="docker-compose run --rm app sh -c 'python manage.py loaddata data.json'"
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
