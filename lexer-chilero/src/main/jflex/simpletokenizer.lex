package gt.edu.url.compiler;

import java_cup.runtime.Symbol;

%%

class = [cC][lL][aA][sS][sS]|[cC][lL][aA][sS][eE]
else = [eE][lL][sS][eE]|[dD][eE][lL][oO][cC][oO][nN][tT][rR][aA][rR][iI][oO]
fi = [fF][iI]|[iI][sS]
if = [iI][fF]|[sS][iI]
in = [iI][nN]|[eE][nN]
inherits = [iI][nN][hH][eE][rR][iI][tT][sS]|[hH][eE][rR][eE][dD][aA]
isvoid = [iI][sS][vV][oO][iI][dD]|[eE][sS][vV][aA][cC][iI][oO]
let = [lL][eE][tT]|[lL][aA][vV][aA][rR]
loop = [lL][oO]{2}[pP]|[cC][iI][cC][lL][oO]
pool = [pP][oO]{2}[lL]|[oO][lL][cC][iI][cC]
then = [tT][hH][eE][nN]|[eE][nN][tT][oO][nN][cC][eE][sS]
while = [wW][hH][iI][lL][eE]|[mM][iI][eE][nN][tT][rR][aA][sS]
case = [cC][aA][sS][eE]|[eE][nN][cC][aA][sS][oO]
esac = [eE][sS][aA][cC]|[oO][sS][aA][cC][nN][eE]
new = [nN][eE][wW]|[nN][uU][eE][vV][oO]
of = [oO][fF]|[dD][eE]
not = [nN][oO][tT]|[nN][eE][lL]
llaveizq="{"
llaveder="}"
parentesisizq="("
parentesisder=")"
dospuntos=":"
puntoycoma=";"
coma=","
punto="."
arroba="@"
negacion="~"
igual= "="
asterisco="*"
diagonal="/"
mas="+"
menos="-"
menor="<"
asignacion="<-"
seleccionexpresion="=>"
menorigual="<="
identificadortipo=[A-Z][a-zA-Z_0-9]*
identificadorobjeto=[a-z][a-zA-Z_0-9]*
false = ("f")[aA][lL][sS][eE]|("f")[aA][lL][sS][oO]
true = ("t")[rR][uU][eE]|("v")[eE][rR][dD][aA][dD][eE][rR][oO]
entero = [0-9]+
espacioblanco=[ \f\r\t\v]
comentariolinea="--"(.)*
%{

  
    static int MAX_STR_CONST = 1025;

  
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
   
    Boolean errorCadenaTamanio=false;
    Boolean errorCadenaNull=false;
    Boolean hayErrorCadena=false;
    Boolean existeDiagonalInversa=false;
   
    void reiniciarErrorCadenaTamanio(){
        errorCadenaTamanio=false;
    }
    void reiniciarErrorCadenaNull(){
        errorCadenaNull=false;
    }
    void reiniciarExisteDiagonalInversa(){
        existeDiagonalInversa=false;
    }
    void hayErrorCadena(){
        hayErrorCadena=false;
    }
%}

%init{

%init}

%eofval{
   
    switch(zzLexicalState) {
     
        case YYINITIAL:
        /* nada */
        break;
        
        case STRING:
            yybegin(YYINITIAL);
            return new Symbol(TokenConstants.ERROR,"EOF in string constant");
        
        case MULTI_COMMENTARIO:
            yybegin(YYINITIAL);
            return new Symbol(TokenConstants.ERROR,"EOF in multi-line comment");
    }
    return new Symbol(TokenConstants.EOF);
%eofval}

%public
%class CoolLexer
%cup
%state STRING
%state MULTI_COMMENTARIO
%%

<YYINITIAL>{class} {return new Symbol(TokenConstants.CLASS);}
<YYINITIAL>{else} {return new Symbol(TokenConstants.ELSE);}
<YYINITIAL>{fi} {return new Symbol(TokenConstants.FI);}
<YYINITIAL>{if} {return new Symbol(TokenConstants.IF);}
<YYINITIAL>{in} {return new Symbol(TokenConstants.IN);}
<YYINITIAL>{inherits} {return new Symbol(TokenConstants.INHERITS);}
<YYINITIAL>{isvoid} {return new Symbol(TokenConstants.ISVOID);}
<YYINITIAL>{let} {return new Symbol(TokenConstants.LET);}
<YYINITIAL>{loop} {return new Symbol(TokenConstants.LOOP);}
<YYINITIAL>{pool} {return new Symbol(TokenConstants.POOL);}
<YYINITIAL>{then} {return new Symbol(TokenConstants.THEN);}
<YYINITIAL>{while} {return new Symbol(TokenConstants.WHILE);}
<YYINITIAL>{case} {return new Symbol(TokenConstants.CASE);}
<YYINITIAL>{esac} {return new Symbol(TokenConstants.ESAC);}
<YYINITIAL>{new} {return new Symbol(TokenConstants.NEW);}
<YYINITIAL>{of} {return new Symbol(TokenConstants.OF);}
<YYINITIAL>{not} {return new Symbol(TokenConstants.NOT);}
<YYINITIAL>{false} {return new Symbol(TokenConstants.BOOL_CONST,false);}
<YYINITIAL>{true} {return new Symbol(TokenConstants.BOOL_CONST,true);}
<YYINITIAL>{llaveizq} {return new Symbol(TokenConstants.LBRACE);}
<YYINITIAL>{llaveder} {return new Symbol(TokenConstants.RBRACE);}
<YYINITIAL>{parentesisizq} {return new Symbol(TokenConstants.LPAREN);}
<YYINITIAL>{parentesisder} {return new Symbol(TokenConstants.RPAREN);}
<YYINITIAL>{dospuntos} {return new Symbol(TokenConstants.COLON);}
<YYINITIAL>{puntoycoma} {return new Symbol(TokenConstants.SEMI);}
<YYINITIAL>{coma} {return new Symbol(TokenConstants.COMMA);}
<YYINITIAL>{punto} {return new Symbol(TokenConstants.DOT);}
<YYINITIAL>{arroba} {return new Symbol(TokenConstants.AT);}
<YYINITIAL>{negacion} {return new Symbol(TokenConstants.NEG);}
<YYINITIAL>{igual} {return new Symbol(TokenConstants.EQ);}
<YYINITIAL>{asterisco} {return new Symbol(TokenConstants.MULT);}
<YYINITIAL>{diagonal} {return new Symbol(TokenConstants.DIV);}
<YYINITIAL>{mas} {return new Symbol(TokenConstants.PLUS);}
<YYINITIAL>{menos} {return new Symbol(TokenConstants.MINUS);}
<YYINITIAL>{menor} {return new Symbol(TokenConstants.LT);}
<YYINITIAL>{asignacion} {return new Symbol(TokenConstants.ASSIGN);}
<YYINITIAL>{seleccionexpresion} {return new Symbol(TokenConstants.DARROW);}
<YYINITIAL>{menorigual} {return new Symbol(TokenConstants.LE);}
<YYINITIAL>{identificadortipo} {AbstractSymbol idType=AbstractTable.idtable.addString(yytext());
                                return new Symbol(TokenConstants.TYPEID,idType);}
<YYINITIAL>{identificadorobjeto} {AbstractSymbol idObject=AbstractTable.idtable.addString(yytext());
                                return new Symbol(TokenConstants.OBJECTID,idObject);}

<YYINITIAL>{entero} {AbstractSymbol num = AbstractTable.inttable.addInt(Integer.parseInt(yytext()));
                    return new Symbol(TokenConstants.INT_CONST,num);}
<YYINITIAL> "*)" {return new Symbol(TokenConstants.ERROR, "Unmatched *)");}
<YYINITIAL> "\n" {curr_lineno++;}
<YYINITIAL>{espacioblanco} {/* No hacer nada xd */}
<YYINITIAL>{comentariolinea} {/* No hacer nada xd */}

<YYINITIAL> (\") {string_buf.setLength(0);reiniciarErrorCadenaTamanio();
                  reiniciarErrorCadenaNull();reiniciarExisteDiagonalInversa();hayErrorCadena();
                  yybegin(STRING);}
<YYINITIAL> ("(*") {yybegin(MULTI_COMMENTARIO);}

<STRING> \" {


if((!existeDiagonalInversa) && (string_buf.length()>0)&&(string_buf.charAt(string_buf.length()-1) == '\\')) {
        string_buf.setCharAt(string_buf.length()-1,'\"');
} else {
      
        yybegin(YYINITIAL);
        if(errorCadenaNull) {
            return new Symbol(TokenConstants.ERROR, new String("String contains null character"));
        }if(errorCadenaTamanio) {
            return new Symbol(TokenConstants.ERROR, new String("String constant too long"));
        }if(!hayErrorCadena){
            AbstractSymbol string = AbstractTable.stringtable.addString(string_buf.toString());
            return new Symbol(TokenConstants.STR_CONST, string);
        }
    }
}
<STRING> (\n) {curr_lineno++;
if(string_buf.length()!= 0) {
    int menor=string_buf.length()-1;
    char caracterMenor = string_buf.charAt(menor);
    if(caracterMenor == '\\' && (!existeDiagonalInversa)) {
        string_buf.setCharAt(menor, '\n');
    } else { 
        hayErrorCadena=true;
        return new Symbol(TokenConstants.ERROR, "Unterminated string constant");
    }
} else {
    hayErrorCadena=true;
    return new Symbol(TokenConstants.ERROR, "Unterminated string constant");
}
} 
<STRING> [^\n] {if((!errorCadenaTamanio)&&(!errorCadenaNull)){
if(yytext().charAt(0)=='\0'){
    errorCadenaNull=true;
    hayErrorCadena=true;
}else{
    if(string_buf.length()>0){
        int menosUno=string_buf.length()-1;
        char caracterMenor=string_buf.charAt(menosUno);
        if(caracterMenor=='\\'&&(!errorCadenaNull)){
            char chars=yytext().charAt(0);
          
            if(chars=='b'||chars=='t'||chars=='n'||chars=='f'||chars=='\\'){
                if(chars=='b'){
                    string_buf.setCharAt(menosUno, '\b');
                }else if(chars=='t'){
                    string_buf.setCharAt(menosUno, '\t');
                }else if(chars=='n'){
                    string_buf.setCharAt(menosUno, '\n');
                }else if(chars=='f'){
                    string_buf.setCharAt(menosUno, '\f');
                }else if(chars=='\\'){
                     string_buf.setCharAt(menosUno, chars);
                     existeDiagonalInversa=true;
                }
            }else{
                string_buf.setCharAt(menosUno, chars);
            }
        }else{
            if(yytext().charAt(0) == '\\') {
                existeDiagonalInversa = false;
            }
            string_buf.append(yytext());
        }
    }else{
        string_buf.append(yytext());
    }
    if(string_buf.length() >= MAX_STR_CONST) {
        hayErrorCadena=true;
        errorCadenaTamanio = true;
    }
}
}
}
<MULTI_COMMENTARIO> "\n" {curr_lineno++;}
<MULTI_COMMENTARIO> [^] {/*nada*/}
<MULTI_COMMENTARIO> ("*)") {yybegin(YYINITIAL);}

[^] { return new Symbol(TokenConstants.ERROR,yytext());}