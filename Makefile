SHELL := /bin/bash

.PHONY: up
up:
	docker-compose build && docker-compose up
