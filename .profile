#!/usr/bin/env bash
# 0: priority of profiles
# 1: ~/.bash_profile (empty)
# 2: ~/.bash_login (empty)
# 3: ~/.profile (default)

# Custom Variables

__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"

__dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
__base="$( basename ${__file} .sh )"
__tmp_dir="$(mktemp --directory)"

__local_ip=$(local_ip)
__ip=$(ip_address)

# Custom Paths
export TERM=xterm

# Custom Functions
local_ip(){
	ifconfig | perl -nle 's/dr:(\S+)/print $1/e' | sed -n '1p'
}


ip_address(){
	curl ipinfo.io/ip
}

update_profile(){
	source $HOME/.profile
}

current_timestamp(){
	echo $(date "+%Y.%m.%d-%H.%M.%S")
}

current_time(){
	echo $(date +"%m/%d/%y | %T %p | %B | %Y | %A | (%Z)")
}


list_all(){
	ls -a
}


# Custom Aliases
alias ip-address=ip_address
alias localip=local_ip

alias update=update_profile
alias ls=list_all



# Docker Workflow
# Docker Functions

docker_images_clean(){
	docker rmi $(docker images -a | grep "^<none>" | awk '{print $3}')
}

docker_build(){
	#build the image with no-cache and tag the image with a name
	docker build --no-cache -t $1 .
	#docker-compose up -d
}


docker_remove(){
	docker rmi $1
}
docker_clean(){
	#http://stackoverflow.com/questions/32723111/how-to-remove-old-and-unused-docker-images
    docker rm -v $(docker ps --filter status=exited -q 2>/dev/null) 2>/dev/null
    docker rmi $(docker images --filter dangling=true -q 2>/dev/null) 2>/dev/null
	docker rmi -f $(docker images -q -a -f dangling=true)

	#Remove all stopped containers
	docker rm $(docker ps -a | grep Exited | awk '{print $1}')
	#Clean up un-tagged docker images
	docker rmi $(docker images -q --filter "dangling=true")
}

docker_remove_all_images_and_containers(){
	#http://stackoverflow.com/questions/32723111/how-to-remove-old-and-unused-docker-images
    docker rm -v $(docker ps --filter status=exited -q 2>/dev/null) 2>/dev/null
    docker rmi $(docker images --filter dangling=true -q 2>/dev/null) 2>/dev/null
	docker stop $(docker ps -a -q)
	docker rm $(docker ps -a -q)
	docker rm $(docker ps -a -q)
	# Delete all images
	docker rmi $(docker images -q)
	
}

docker_save(){
	#save image to file
	docker ps -a
	docker save $1 > image.tar

	#load from file
	docker load < image.tar
}

docker_export(){
	#export container to file
	#docker ps -a
	echo "backing up container $1"
	#docker export $1 | gzip > $1.$(date "+%Y.%m.%d.%H%M%S").tar.gz
	docker export $1 > $1.$(date "+%Y.%m.%d.%H%M%S").tar
	echo "backup complete"
}

docker_import(){
	#import from file
	tar -c $1 | docker import - $2
}

docker_id(){
	docker inspect --format='{{.ID}}' $(docker ps -aq --no-trunc)
}

docker_name(){
	docker inspect --format='{{.Name}}' $(docker ps -aq --no-trunc)
}

docker_load(){
	docker load --input $1
}

docker_run_web(){
	docker run -p 80:80 -v $(pwd) --name $1 $2
}

docker_run(){
	docker run -itd -v $(pwd) --name $1 $2
}


docker_ssh(){
	if [ docker exec -it $1 /bin/bash -c "export TERM=xterm; exec bash" -eq 0 ]; then
		docker exec -it $1 /bin/bash -c "export TERM=xterm; exec bash"
	else
		docker exec -it $1 /bin/ash -c "export TERM=xterm; exec ash"
	fi
	
	
	# BASH=$(docker exec -it $1 echo $SHELL)
	#docker exec -it $1 bin/bash
	#smart terminal
	#docker exec -it $1 /bin/bash -c "export TERM=xterm; exec bash"	
	# docker exec -it $1 $(echo $BASH | xargs) -c "export TERM=xterm; exec bash"
}




docker_copy(){
	docker cp $1 $(pwd)
}
docker_up(){
	
	if docker-machine status | grep -q 'Stopped'; then
		echo "starting docker machine"
		docker-machine start
	fi
	$(update)
	echo "syncing docker-machine - enviroment"
	eval $(docker-machine env)
	echo "synced"
}



# Docker Aliases
alias docker-images-clean=docker_images_clean
alias docker-remove-all=docker_remove_all_images_and_containers
alias docker-clean=docker_clean
alias docker-env="eval $(docker-machine env)"
alias docker-containers="docker ps -a --format 'table {{.Names}}\t{{.Image}}\t{{.ID}}\t{{.RunningFor}}\t{{.Labels}}'"
alias docker-status="docker ps -a --format 'table {{.Names}}\t{{.Image}}\t{{.ID}}\t{{.Status}}'"
alias docker-start="docker-machine start"
alias docker-stop="docker-machine stop"
alias docker-build=docker_build
alias docker-ssh=docker_ssh
alias docker-up=docker_up
alias docker-down="docker-machine stop"
alias docker-ip="docker-machine ip default"
alias docker-remove=docker_remove
alias docker-save=docker_save
alias docker-export=docker_export
alias docker-import=docker_import
alias docker-id=docker_id
alias docker-name=docker_name
alias docker-images="docker images"
alias docker-load=docker_load
alias docker-run=docker_run
alias docker-copy=docker_copy
alias dc-up="docker-compose up -d"
alias dc-start="docker-compose up -d"
alias dc-down="docker-compose down"
alias dc-stop="docker-compose down"
alias dc-ps="docker-compose ps"
