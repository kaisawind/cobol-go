package procedure

import (
	"github.com/antlr/antlr4/runtime/Go/antlr/v4"
	"github.com/kaisawind/cobol/asg/conv"
	"github.com/kaisawind/cobol/gen/cobol85"
	"github.com/kaisawind/cobol/pb"
)

type ProcedureSectionHeaderVisitor struct {
	cobol85.BaseCobol85Visitor
	header *pb.ProcedureSectionHeader
}

func NewProcedureSectionHeaderVisitor(header *pb.ProcedureSectionHeader) *ProcedureSectionHeaderVisitor {
	return &ProcedureSectionHeaderVisitor{
		header: header,
	}
}

func (v *ProcedureSectionHeaderVisitor) VisitProcedureSectionHeader(ctx *cobol85.ProcedureSectionHeaderContext) any {
	v.header.SectionName = conv.SectionName(ctx.SectionName())
	if ctx.IntegerLiteral() != nil {
		v.header.IntegerLiteral = conv.IntegerLiteral(ctx.IntegerLiteral())
	}
	return v.VisitChildren(ctx)
}

func (v *ProcedureSectionHeaderVisitor) Visit(tree antlr.ParseTree) any {
	return tree.Accept(v)
}

func (v *ProcedureSectionHeaderVisitor) VisitChildren(node antlr.RuleNode) any {
	for _, child := range node.GetChildren() {
		child.(antlr.ParseTree).Accept(v)
	}
	return nil
}
