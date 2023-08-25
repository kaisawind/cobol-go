# Cobol Parser For Go

cobol parser for go.

**More:**
* antlrV4(cobol85) 👉 https://github.com/antlr/grammars-v4/tree/master/cobol85
* antlrV4 👉 https://github.com/antlr/antlr4
* cobol parser java 👉 https://github.com/uwol/proleap-cobol-parser
* Transform cobol 👉 https://github.com/proleap/proleap-cobol


## build

```bash
make build
```

## gen

for antlr gen code
```bash
go generate ./...
```

for protofbuf code
```bash
make proto
```

## TODO:
* transform to protobuf
* performance improvement