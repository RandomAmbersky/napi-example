.PHONY: build shell

build:
	npm run build

run:
	docker-compose run --rm --build napi-rs

shell:
	docker-compose run --rm --build napi-rs sh
