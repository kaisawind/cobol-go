package test

import (
	"fmt"
	"os"
	"path"
	"regexp"
	"strings"
	"testing"

	"github.com/antlr/antlr4/runtime/Go/antlr/v4"
	"github.com/kaisawind/cobol/document"
	"github.com/kaisawind/cobol/gen/cobol85"
	"github.com/kaisawind/cobol/options"
)

var (
	re1 = regexp.MustCompile(`[\s]+`)
	re2 = regexp.MustCompile(`[\s]+\)`)
)

func cleanTree(s string) string {
	s = strings.ReplaceAll(s, "\\r", "")
	s = strings.ReplaceAll(s, "\\n", "")
	s = strings.ReplaceAll(s, "\r", "")
	s = strings.ReplaceAll(s, "\n", "")
	s = re1.ReplaceAllString(s, " ")
	s = re2.ReplaceAllString(s, ")")
	return s
}

func TestAstHello(t *testing.T) {
	rootdir := "./testdata/cobol/ast"
	filePath := path.Join(rootdir, "HelloWorld.cbl")
	treePath := filePath + ".tree"
	treeBuf, err := os.ReadFile(treePath)
	if err != nil {
		t.Error(err)
		t.FailNow()
	}
	opts := options.NewOptions()
	processed := document.ParseFile(filePath, opts)
	if processed == "" {
		t.FailNow()
	}

	is := antlr.NewInputStream(processed)
	lexer := cobol85.NewCobol85Lexer(is)
	cts := antlr.NewCommonTokenStream(lexer, antlr.LexerDefaultTokenChannel)
	cpp := cobol85.NewCobol85Parser(cts)

	tree := antlr.TreesStringTree(cpp.StartRule(), []string{}, cpp)

	t.Log(cleanTree(tree))
	fmt.Println(strings.Repeat("-", 78))
	t.Log(cleanTree(string(treeBuf)))

}

func TestAst(tt *testing.T) {
	rootdir := "./testdata/cobol/ast"
	for _, dirName := range DIRS {
		tt.Run(dirName, func(t *testing.T) {
			parentDir := path.Join(rootdir, dirName)
			files, err := os.ReadDir(parentDir)
			if err != nil {
				t.Error(err)
				t.FailNow()
			}
			for _, file := range files {
				if file.IsDir() {
					continue
				}
				ext := path.Ext(file.Name())
				isCobol := false
				for _, v := range COBOL_EXTS {
					if strings.EqualFold(v, ext) {
						isCobol = true
						break
					}
				}
				if !isCobol {
					continue
				}
				t.Log(file.Name())
				opts := options.NewOptions().AddCopyBookDirectory(parentDir).SetFormat(dir2format(dirName))
				filename := path.Join(parentDir, file.Name())
				processed := document.ParseFile(filename, opts)
				is := antlr.NewInputStream(processed)
				lexer := cobol85.NewCobol85Lexer(is)
				cts := antlr.NewCommonTokenStream(lexer, antlr.LexerDefaultTokenChannel)
				cpp := cobol85.NewCobol85Parser(cts)

				tree := antlr.TreesStringTree(cpp.StartRule(), []string{}, cpp)

				treeBuf, err := os.ReadFile(filename + ".tree")
				if err != nil {
					t.Error(err)
					t.FailNow()
				}
				cleanedTree := cleanTree(tree)
				cleanedFileTree := cleanTree(string(treeBuf))
				if cleanedTree != cleanedFileTree {
					t.Log(cleanedTree)
					fmt.Println(strings.Repeat("-", 78))
					t.Log(cleanedFileTree)
					t.FailNow()
				}
			}
		})
	}
}

func TestReplaceAmbiguous(t *testing.T) {
	rootdir := "./testdata/cobol/ast"
	dirName := "variable"
	parentDir := path.Join(rootdir, dirName)
	fileName := "ReplaceAmbiguous.cbl"
	opts := options.NewOptions().AddCopyBookDirectory(parentDir).SetFormat(dir2format(dirName))
	filename := path.Join(parentDir, fileName)
	processed := document.ParseFile(filename, opts)
	is := antlr.NewInputStream(processed)
	lexer := cobol85.NewCobol85Lexer(is)
	cts := antlr.NewCommonTokenStream(lexer, antlr.LexerDefaultTokenChannel)
	cpp := cobol85.NewCobol85Parser(cts)

	tree := antlr.TreesStringTree(cpp.StartRule(), []string{}, cpp)

	treeBuf, err := os.ReadFile(filename + ".tree")
	if err != nil {
		t.Error(err)
		t.FailNow()
	}
	cleanedTree := cleanTree(tree)
	cleanedFileTree := cleanTree(string(treeBuf))
	if cleanedTree != cleanedFileTree {
		t.Log(cleanedTree)
		fmt.Println(strings.Repeat("-", 78))
		t.Log(cleanedFileTree)
		t.FailNow()
	}
}
