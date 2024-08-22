MAKEFLAGS += --silent

OPTIONS ?= --build --remove-orphans --force-recreate

APP ?= app

all:
	docker-compose up $(OPTIONS) -d

%:
	docker-compose up $(OPTIONS) $@ -d
	docker-compose ps -a

healthcheck:
	docker inspect $(APP) --format "{{ (index (.State.Health.Log) 0).Output }}"

test:
	#dotnet test
	./tests/test.sh

clean:
	docker-compose down --remove-orphans -v --rmi local
	dotnet clean
	rm -rf ./{bin,obj}

-include .env
