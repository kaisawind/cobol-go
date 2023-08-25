package procedure

import (
	"github.com/antlr/antlr4/runtime/Go/antlr/v4"
	"github.com/kaisawind/cobol/asg/conv"
	"github.com/kaisawind/cobol/gen/cobol85"
	"github.com/kaisawind/cobol/pb"
)

type SentenceVisitor struct {
	cobol85.BaseCobol85Visitor
	sentence *pb.Sentence
}

func NewSentenceVisitor(sentence *pb.Sentence) *SentenceVisitor {
	return &SentenceVisitor{
		sentence: sentence,
	}
}

func (v *SentenceVisitor) VisitStatement(ctx *cobol85.StatementContext) interface{} {
	v.sentence.Statements = append(v.sentence.Statements, conv.Statement(ctx))
	return v.VisitChildren(ctx)
}

func (v *SentenceVisitor) VisitSentence(ctx *cobol85.SentenceContext) any {
	return v.VisitChildren(ctx)
}

func (v *SentenceVisitor) Visit(tree antlr.ParseTree) any {
	return tree.Accept(v)
}

func (v *SentenceVisitor) VisitChildren(node antlr.RuleNode) any {
	for _, child := range node.GetChildren() {
		child.(antlr.ParseTree).Accept(v)
	}
	return nil
}
