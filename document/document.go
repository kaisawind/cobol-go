package document

import (
	"fmt"
	"os"
	"regexp"
	"strings"

	"github.com/antlr/antlr4/runtime/Go/antlr/v4"
	"github.com/kaisawind/cobol/constant"
	"github.com/kaisawind/cobol/gen/preprocessor"
	"github.com/kaisawind/cobol/line"
	"github.com/kaisawind/cobol/options"
)

var (
	execution = fmt.Sprintf(
		`.*(%s|%s|%s|%s|%s|%s|%s|%s|%s|%s\s+%s|%s\s+%s|%s\s+%s).*`,
		constant.CBL,
		constant.COPY,
		constant.PROCESS,
		constant.REPLACE,
		constant.EJECT,
		constant.SKIP1,
		constant.SKIP2,
		constant.SKIP3,
		constant.TITLE,
		constant.EXEC, constant.SQL,
		constant.EXEC, constant.SQLIMS,
		constant.EXEC, constant.CICS,
	)
	executionReg = regexp.MustCompile(execution)
)

func ParseFile(filename string, opts ...options.Option) string {
	buf, err := os.ReadFile(filename)
	if err != nil {
		return ""
	}
	return Parse(string(buf), opts...)
}

func Parse(text string, opts ...options.Option) string {
	code := line.Combine(line.NewLinkedLine(strings.NewReader(text), opts...))
	return parseProcessedCode(code, opts...)
}

func parseProcessedCode(code string, opts ...options.Option) string {
	if executionReg.MatchString(code) {
		is := antlr.NewInputStream(code)
		lexer := preprocessor.NewCobol85PreprocessorLexer(is)
		cts := antlr.NewCommonTokenStream(lexer, antlr.LexerDefaultTokenChannel)
		cpp := preprocessor.NewCobol85PreprocessorParser(cts)
		listener := NewPreprocessorListener(cts, opts...)
		antlr.ParseTreeWalkerDefault.Walk(listener, cpp.StartRule())
		code = listener.GetText()
	}
	return code
}
