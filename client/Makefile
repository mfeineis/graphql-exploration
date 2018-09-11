all:
	./private/elm make ./src/Main.elm --output ./dist/app.js

build.log: ./src/*
	make all | tee ./build.log

clean:
	rm -rf ./dist/
	mkdir -p ./dist/
	mkdir -p ./logs/
	touch ./build.log

generate-schema:
	npx elm-graphql http://localhost:4000/graphql --base Api.Generated --output ./src/

serve:
	./private/elm reactor --port=8080

watch:
	(while true; do make -q build.log || make build.log ; sleep 1; done) | grep -v 'make\[1\]'

watch-tests:
	npx elm-test --watch --compiler=./private/elm tests/Test/**/*.elm

.PHONY: all clean
