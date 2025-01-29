setup:
	bin/setup
	yarn install
	yarn build
	yarn build:css
	bin/rails db:fixtures:load

start:
	bin/dev

console:
	bin/rails console

test:
	NODE_ENV=test bin/rails test

.PHONY: test
