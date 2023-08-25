#!/bin/sh

antlr4 -Dlanguage=Go -visitor -package cobol85 cobol85/Cobol85.g4
antlr4 -Dlanguage=Go -visitor -package preprocessor preprocessor/Cobol85Preprocessor.g4