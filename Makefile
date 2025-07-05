BINARY = search
TARGET_NAME = SearchEngine

.PHONY: build run test clean release

build:
	swift build -c debug
	cp .build/debug/$(TARGET_NAME) ./$(BINARY)

run: build
	./$(BINARY) $(ARGS)

test:
	swift test

clean:
	swift package clean
	rm -f ./$(BINARY)

release:
	swift build -c release
	cp .build/release/$(TARGET_NAME) ./$(BINARY)
