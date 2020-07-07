CONTAINER ?=

install:
	./install.sh

build:
	docker-compose build

start:
	docker-compose up -d --remove-orphans

stop:
	docker-compose stop

restart: stop build start

debug: stop build
	docker-compose up --remove-orphans

reset:
	docker rm docker_elk_kibana_1 docker_elk_elasticsearch_1 docker_elk_logstash_1
	docker volume rm docker_elk_elasticsearch

logs:
	docker-compose logs -f $(CONTAINER)
