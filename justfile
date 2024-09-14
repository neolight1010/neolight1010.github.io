default: build

build: clean
    mkdir dist/
    cp -r src/* dist/

clean:
    rm -rf dist/

watch-build:
    watchexec -w src just build

watch-server:
    browser-sync start -ws dist
