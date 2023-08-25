package visitor

import (
	"github.com/antlr/antlr4/runtime/Go/antlr/v4"
	"github.com/kaisawind/cobol/gen/cobol85"
	"github.com/kaisawind/cobol/pb"
)

type ProgramUnitsVisitor struct {
	cobol85.BaseCobol85Visitor
	compilationUnit *pb.CompilationUnit
}

func NewProgramUnitsVisitor(compilationUnit *pb.CompilationUnit) *ProgramUnitsVisitor {
	return &ProgramUnitsVisitor{
		compilationUnit: compilationUnit,
	}
}

func (v *ProgramUnitsVisitor) VisitProgramUnit(ctx *cobol85.ProgramUnitContext) any {
	programUnit := &pb.ProgramUnit{}
	v.compilationUnit.ProgramUnits = append(v.compilationUnit.ProgramUnits, programUnit)
	vr := NewProgramUnitVisitor(programUnit)
	return vr.VisitChildren(ctx)
}

func (v *ProgramUnitsVisitor) Visit(tree antlr.ParseTree) any {
	return tree.Accept(v)
}

func (v *ProgramUnitsVisitor) VisitChildren(node antlr.RuleNode) any {
	for _, child := range node.GetChildren() {
		child.(antlr.ParseTree).Accept(v)
	}
	return nil
}
