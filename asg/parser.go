package asg

import (
	"os"
	"path"
	"strings"

	"github.com/antlr/antlr4/runtime/Go/antlr/v4"
	"github.com/kaisawind/cobol/asg/conv"
	"github.com/kaisawind/cobol/asg/visitor"
	"github.com/kaisawind/cobol/document"
	"github.com/kaisawind/cobol/gen/cobol85"
	"github.com/kaisawind/cobol/options"
	"github.com/kaisawind/cobol/pb"
	"golang.org/x/text/cases"
	"golang.org/x/text/language"
)

func AnalyzeFile(filename string, opts ...options.Option) *pb.Program {
	if filename == "" {
		return nil
	}
	program := &pb.Program{}
	AnalyzeCompilationUnit(filename, program, opts...)
	return program
}

func GetCompilationUnitName(filename string) string {
	return cases.Title(language.English).String(strings.TrimSuffix(path.Base(filename), path.Ext(filename)))
}

func AnalyzeCompilationUnit(filename string, program *pb.Program, opts ...options.Option) {
	name := GetCompilationUnitName(filename)
	processed := document.ParseFile(filename, opts...)

	is := antlr.NewInputStream(processed)
	lexer := cobol85.NewCobol85Lexer(is)
	cts := antlr.NewCommonTokenStream(lexer, antlr.LexerDefaultTokenChannel)
	cpp := cobol85.NewCobol85Parser(cts)

	ctx := cpp.StartRule()

	tree := conv.TreesStringTree(ctx, cpp.GetRuleNames(), 0)
	os.WriteFile(filename+".tree", []byte(tree), os.ModePerm)

	vr := visitor.NewCompilationUnitVisitor(name, program)

	vr.Visit(ctx)
}
