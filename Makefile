MAKEFLAGS += --silent

BASEDIR = $(shell git rev-parse --show-toplevel)
OPTIONS ?= --build --remove-orphans --force-recreate

DB ?= db
APP ?= app

.PHONY: all docker healthcheck test clean

all: docker test

docker:
	docker-compose up $(OPTIONS) -d

%:
	docker-compose up $(OPTIONS) $@ -d
	docker-compose ps -a

healthcheck:
	docker inspect $(APP) --format "{{ (index (.State.Health.Log) 0).Output }}"

test:
	# dotnet test
	while ! \
		[[ "$$(docker inspect --format "{{json .State.Health }}" $(DB) | jq -r ".Status")" == "healthy" ]];\
		do \
		echo "waiting $(DB) ..."; \
		sleep 1; \
		done
	sleep 1
	[ -f ${BASEDIR}/tests/test.sh ] && ${BASEDIR}/tests/test.sh

clean:
	dotnet clean
	rm -rf ${BASEDIR}/{bin,obj}
	docker-compose down --remove-orphans -v --rmi local

-include .env
