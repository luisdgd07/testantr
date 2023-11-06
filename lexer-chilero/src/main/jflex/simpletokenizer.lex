package gt.edu.url.compiler;

import java_cup.runtime.Symbol;

%%

%{

    // Max size of string constants
    static int MAX_STR_CONST = 1025;

    // For assembling string constants
    StringBuffer string_buf = new StringBuffer();

    private int curr_lineno = 1;
    int get_curr_lineno() {
	return curr_lineno;
    }

    private AbstractSymbol filename;

    void set_filename(String fname) {
	filename = AbstractTable.stringtable.addString(fname);
    }

    AbstractSymbol curr_filename() {
	return filename;
    }
%}

%init{

%init}

%eofval{


    switch(zzLexicalState) {
        case YYINITIAL:
        /* nada */
        break;
    }
    return new Symbol(TokenConstants.EOF);
%eofval}

%class CoolLexer
%cup

%%

<YYINITIAL>"=>"			{ /* Ejemplo de regla */
                                  return new Symbol(TokenConstants.DARROW); }

.                               { /* Ejemplo de regla */
                                  System.err.println("LEXER BUG - UNMATCHED: " + yytext()); }
