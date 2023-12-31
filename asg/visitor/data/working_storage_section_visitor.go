package data

import (
	"github.com/antlr4-go/antlr/v4"
	"github.com/kaisawind/cobol-go/asg/conv"
	"github.com/kaisawind/cobol-go/gen/cobol85"
	"github.com/kaisawind/cobol-go/pb"
)

type WorkingStorageSectionVisitor struct {
	cobol85.BaseCobol85Visitor
	section *pb.WorkingStorageSection
}

func NewWorkingStorageSectionVisitor(section *pb.WorkingStorageSection) *WorkingStorageSectionVisitor {
	return &WorkingStorageSectionVisitor{
		section: section,
	}
}

func (v *WorkingStorageSectionVisitor) VisitWorkingStorageSection(ctx *cobol85.WorkingStorageSectionContext) any {
	for _, ictx := range ctx.AllDataDescriptionEntry() {
		v.section.DataDescriptionEntries = append(v.section.DataDescriptionEntries, conv.DataDescriptionEntry(ictx))
	}
	return v.VisitChildren(ctx)
}

func (v *WorkingStorageSectionVisitor) Visit(tree antlr.ParseTree) any {
	return tree.Accept(v)
}

func (v *WorkingStorageSectionVisitor) VisitChildren(node antlr.RuleNode) any {
	for _, child := range node.GetChildren() {
		child.(antlr.ParseTree).Accept(v)
	}
	return nil
}
