package visitor

import (
	"github.com/antlr4-go/antlr/v4"
	"github.com/kaisawind/cobol-go/asg/visitor/data"
	"github.com/kaisawind/cobol-go/gen/cobol85"
	"github.com/kaisawind/cobol-go/pb"
)

type DataDivisionVisitor struct {
	cobol85.BaseCobol85Visitor
	division *pb.DataDivision
}

func NewDataDivisionVisitor(division *pb.DataDivision) *DataDivisionVisitor {
	return &DataDivisionVisitor{
		division: division,
	}
}

func (v *DataDivisionVisitor) VisitLinkageSection(ctx *cobol85.LinkageSectionContext) interface{} {
	section := &pb.LinkageSection{}
	v.division.LinkageSection = section
	vr := data.NewLinkageSectionVisitor(section)
	return vr.Visit(ctx)
}

func (v *DataDivisionVisitor) VisitCommunicationSection(ctx *cobol85.CommunicationSectionContext) interface{} {
	section := &pb.CommunicationSection{}
	v.division.CommunicationSection = section
	vr := data.NewCommunicationSectionVisitor(section)
	return vr.Visit(ctx)
}

func (v *DataDivisionVisitor) VisitDataBaseSection(ctx *cobol85.DataBaseSectionContext) interface{} {
	section := &pb.DataBaseSection{}
	v.division.DataBaseSection = section
	vr := data.NewDataBaseSectionVisitor(section)
	return vr.Visit(ctx)
}

func (v *DataDivisionVisitor) VisitLocalStorageSection(ctx *cobol85.LocalStorageSectionContext) interface{} {
	section := &pb.LocalStorageSection{}
	v.division.LocalStorageSection = section
	vr := data.NewLocalStorageSectionVisitor(section)
	return vr.Visit(ctx)
}

func (v *DataDivisionVisitor) VisitProgramLibrarySection(ctx *cobol85.ProgramLibrarySectionContext) interface{} {
	section := &pb.ProgramLibrarySection{}
	v.division.ProgramLibrarySection = section
	vr := data.NewProgramLibrarySectionVisitor(section)
	return vr.Visit(ctx)
}

func (v *DataDivisionVisitor) VisitReportSection(ctx *cobol85.ReportSectionContext) interface{} {
	section := &pb.ReportSection{}
	v.division.ReportSection = section
	vr := data.NewReportSectionVisitor(section)
	return vr.Visit(ctx)
}

func (v *DataDivisionVisitor) VisitScreenSection(ctx *cobol85.ScreenSectionContext) interface{} {
	section := &pb.ScreenSection{}
	v.division.ScreenSection = section
	vr := data.NewScreenSectionVisitor(section)
	return vr.Visit(ctx)
}

func (v *DataDivisionVisitor) VisitWorkingStorageSection(ctx *cobol85.WorkingStorageSectionContext) interface{} {
	section := &pb.WorkingStorageSection{}
	v.division.WorkingStorageSection = section
	vr := data.NewWorkingStorageSectionVisitor(section)
	return vr.Visit(ctx)
}

func (v *DataDivisionVisitor) VisitFileSection(ctx *cobol85.FileSectionContext) interface{} {
	section := &pb.FileSection{}
	v.division.FileSection = section
	vr := data.NewFileSectionVisitor(section)
	return vr.Visit(ctx)
}

func (v *DataDivisionVisitor) VisitDataDivisionSection(ctx *cobol85.DataDivisionSectionContext) interface{} {
	return v.VisitChildren(ctx)
}

func (v *DataDivisionVisitor) VisitDataDivision(ctx *cobol85.DataDivisionContext) any {
	return v.VisitChildren(ctx)
}

func (v *DataDivisionVisitor) Visit(tree antlr.ParseTree) any {
	return tree.Accept(v)
}

func (v *DataDivisionVisitor) VisitChildren(node antlr.RuleNode) any {
	for _, child := range node.GetChildren() {
		child.(antlr.ParseTree).Accept(v)
	}
	return nil
}
