.PHONY: build shell

build:
	npm run build

shell:
	docker-compose run --rm --build napi-rs sh
