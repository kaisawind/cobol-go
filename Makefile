SERVICES = tree dobf preprocess func

define compile
	go build \
	-ldflags "-s -w" \
	-gcflags "all=-N -l" \
	-o bin/$(1) cmd/$(1)/main.go
endef

all: $(SERVICES)

proto:
	protoc -I/usr/local/include \
		-Ipb \
		--go_out=pb --go_opt=paths=source_relative \
		--go-grpc_out=pb --go-grpc_opt=paths=source_relative \
		pb/*.proto

$(SERVICES):
	$(call compile,$(@))