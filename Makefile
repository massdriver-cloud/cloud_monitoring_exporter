SHELL := /bin/bash

.PHONY: server
server: ## Start the development server w/ iex
	set -o allexport; source env/dev.env; set -o allexport; iex -S mix
