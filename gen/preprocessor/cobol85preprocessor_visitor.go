// Code generated from java-escape by ANTLR 4.11.1. DO NOT EDIT.

package preprocessor // Cobol85Preprocessor
import "github.com/antlr/antlr4/runtime/Go/antlr/v4"

// A complete Visitor for a parse tree produced by Cobol85PreprocessorParser.
type Cobol85PreprocessorVisitor interface {
	antlr.ParseTreeVisitor

	// Visit a parse tree produced by Cobol85PreprocessorParser#startRule.
	VisitStartRule(ctx *StartRuleContext) interface{}

	// Visit a parse tree produced by Cobol85PreprocessorParser#compilerOptions.
	VisitCompilerOptions(ctx *CompilerOptionsContext) interface{}

	// Visit a parse tree produced by Cobol85PreprocessorParser#compilerXOpts.
	VisitCompilerXOpts(ctx *CompilerXOptsContext) interface{}

	// Visit a parse tree produced by Cobol85PreprocessorParser#compilerOption.
	VisitCompilerOption(ctx *CompilerOptionContext) interface{}

	// Visit a parse tree produced by Cobol85PreprocessorParser#execCicsStatement.
	VisitExecCicsStatement(ctx *ExecCicsStatementContext) interface{}

	// Visit a parse tree produced by Cobol85PreprocessorParser#execSqlStatement.
	VisitExecSqlStatement(ctx *ExecSqlStatementContext) interface{}

	// Visit a parse tree produced by Cobol85PreprocessorParser#execSqlImsStatement.
	VisitExecSqlImsStatement(ctx *ExecSqlImsStatementContext) interface{}

	// Visit a parse tree produced by Cobol85PreprocessorParser#copyStatement.
	VisitCopyStatement(ctx *CopyStatementContext) interface{}

	// Visit a parse tree produced by Cobol85PreprocessorParser#copySource.
	VisitCopySource(ctx *CopySourceContext) interface{}

	// Visit a parse tree produced by Cobol85PreprocessorParser#copyLibrary.
	VisitCopyLibrary(ctx *CopyLibraryContext) interface{}

	// Visit a parse tree produced by Cobol85PreprocessorParser#prefixingPhrase.
	VisitPrefixingPhrase(ctx *PrefixingPhraseContext) interface{}

	// Visit a parse tree produced by Cobol85PreprocessorParser#replacingPhrase.
	VisitReplacingPhrase(ctx *ReplacingPhraseContext) interface{}

	// Visit a parse tree produced by Cobol85PreprocessorParser#replaceArea.
	VisitReplaceArea(ctx *ReplaceAreaContext) interface{}

	// Visit a parse tree produced by Cobol85PreprocessorParser#replaceByStatement.
	VisitReplaceByStatement(ctx *ReplaceByStatementContext) interface{}

	// Visit a parse tree produced by Cobol85PreprocessorParser#replaceOffStatement.
	VisitReplaceOffStatement(ctx *ReplaceOffStatementContext) interface{}

	// Visit a parse tree produced by Cobol85PreprocessorParser#replaceClause.
	VisitReplaceClause(ctx *ReplaceClauseContext) interface{}

	// Visit a parse tree produced by Cobol85PreprocessorParser#directoryPhrase.
	VisitDirectoryPhrase(ctx *DirectoryPhraseContext) interface{}

	// Visit a parse tree produced by Cobol85PreprocessorParser#familyPhrase.
	VisitFamilyPhrase(ctx *FamilyPhraseContext) interface{}

	// Visit a parse tree produced by Cobol85PreprocessorParser#replaceable.
	VisitReplaceable(ctx *ReplaceableContext) interface{}

	// Visit a parse tree produced by Cobol85PreprocessorParser#replacement.
	VisitReplacement(ctx *ReplacementContext) interface{}

	// Visit a parse tree produced by Cobol85PreprocessorParser#ejectStatement.
	VisitEjectStatement(ctx *EjectStatementContext) interface{}

	// Visit a parse tree produced by Cobol85PreprocessorParser#skipStatement.
	VisitSkipStatement(ctx *SkipStatementContext) interface{}

	// Visit a parse tree produced by Cobol85PreprocessorParser#titleStatement.
	VisitTitleStatement(ctx *TitleStatementContext) interface{}

	// Visit a parse tree produced by Cobol85PreprocessorParser#pseudoText.
	VisitPseudoText(ctx *PseudoTextContext) interface{}

	// Visit a parse tree produced by Cobol85PreprocessorParser#charData.
	VisitCharData(ctx *CharDataContext) interface{}

	// Visit a parse tree produced by Cobol85PreprocessorParser#charDataSql.
	VisitCharDataSql(ctx *CharDataSqlContext) interface{}

	// Visit a parse tree produced by Cobol85PreprocessorParser#charDataLine.
	VisitCharDataLine(ctx *CharDataLineContext) interface{}

	// Visit a parse tree produced by Cobol85PreprocessorParser#cobolWord.
	VisitCobolWord(ctx *CobolWordContext) interface{}

	// Visit a parse tree produced by Cobol85PreprocessorParser#prefixWord.
	VisitPrefixWord(ctx *PrefixWordContext) interface{}

	// Visit a parse tree produced by Cobol85PreprocessorParser#literal.
	VisitLiteral(ctx *LiteralContext) interface{}

	// Visit a parse tree produced by Cobol85PreprocessorParser#filename.
	VisitFilename(ctx *FilenameContext) interface{}

	// Visit a parse tree produced by Cobol85PreprocessorParser#charDataKeyword.
	VisitCharDataKeyword(ctx *CharDataKeywordContext) interface{}
}
