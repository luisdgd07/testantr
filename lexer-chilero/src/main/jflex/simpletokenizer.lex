package gt.edu.url.compiler;

import java_cup.runtime.Symbol;

%%

blanco=[ \f\r\t\v]
comen="--"(.)*
puntosdos=":"
puntocoma=";"
coma=","
punto="."
arroba="@"
no="~"
equals= "="
asterisco="*"
diagonal="/"
mas="+"
menos="-"
menor="<"
asig="<-"
sele="=>"
menorigual="<="
class = [cC][lL][aA][sS][sS]|[cC][lL][aA][sS][eE]
else = [eE][lL][sS][eE]|[dD][eE][lL][oO][cC][oO][nN][tT][rR][aA][rR][iI][oO]
fi = [fF][iI]|[eE][sS]
if = [iI][fF]|[sS][iI]
in = [iI][nN]|[eE][nN]
Curlyizquierdo="("
curlyderecho=")"
tipo=[A-Z][a-zA-Z_0-9]*
objeto=[a-z][a-zA-Z_0-9]*
false = ("f")[aA][lL][sS][eE]|("f")[aA][lL][sS][oO]
true = ("t")[rR][uU][eE]|("v")[eE][rR][dD][aA][dD][eE][rR][oO]
int = [0-9]+
inherits = [iI][nN][hH][eE][rR][iI][tT][sS]|[hH][eE][rR][eE][dD][aA][rR]
isvoid = [iI][sS][vV][oO][iI][dD]|[vV][aA][cC][iI][oO]
let = [lL][eE][tT]|[lL][eE][vV][aA][rR]
loop = [lL][oO]{2}[pP]|[bB][uU][cC][lL][eE]
pool = [pP][oO]{2}[lL]|[sS][uU][bB][iI][rR]
then = [tT][hH][eE][nN]|[eE][nN][tT][oO][nN][cC][eE][sS][tT][aA][nN][tT][oO]
while = [wW][hH][iI][lL][eE]|[mM][iI][eE][nN][tT][rR][aA][sS]
case = [cC][aA][sS][eE]|[eE][nN][cC][aA][sS][oO]
esac = [eE][sS][aA][cC]|[oO][sS][aA][cC][nN][eE]
new = [nN][eE][wW]|[nN][uU][eE][vV][oO]
of = [oO][fF]|[dD][eE]
not = [nN][oO][tT]|[nN][oO]
Keyizquierdo="{"
keyderecho="}"



%{

    static int MAX = 2048;
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
   
    Boolean EC=false;
    Boolean ED=false;
    Boolean ECT=false;
    Boolean ECN=false;
   
      void rED(){
        ED=false;
    }
    void EC(){
        EC=false;
    }
    void rECT(){
       ECT=false;
    }
    void rECN(){
        ECN=false;
    }
  
%}

%init{

%init}

%eofval{
    
    switch(zzLexicalState) {
       
        case YYINITIAL:
        /* */
        break;
        
        case STRING:
            yybegin(YYINITIAL);
            return new Symbol(TokenConstants.ERROR,"EOF in string constant");
     
        case COMENTS:
            yybegin(YYINITIAL);
            return new Symbol(TokenConstants.ERROR,"EOF in multi-line comment");
    }
    return new Symbol(TokenConstants.EOF);
%eofval}

%public
%class CoolLexer
%cup
%state STRING
%state COMENTS

%%

<YYINITIAL>{blanco} {/*  */}
<YYINITIAL>{comen} {/*  */}
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
<YYINITIAL>{Keyizquierdo} {return new Symbol(TokenConstants.LBRACE);}
<YYINITIAL>{keyderecho} {return new Symbol(TokenConstants.RBRACE);}
<YYINITIAL>{Curlyizquierdo} {return new Symbol(TokenConstants.LPAREN);}
<YYINITIAL>{curlyderecho} {return new Symbol(TokenConstants.RPAREN);}
<YYINITIAL>{puntosdos} {return new Symbol(TokenConstants.COLON);}
<YYINITIAL>{puntocoma} {return new Symbol(TokenConstants.SEMI);}
<YYINITIAL>{coma} {return new Symbol(TokenConstants.COMMA);}
<YYINITIAL>{punto} {return new Symbol(TokenConstants.DOT);}
<YYINITIAL>{arroba} {return new Symbol(TokenConstants.AT);}
<YYINITIAL>{no} {return new Symbol(TokenConstants.NEG);}
<YYINITIAL>{equals} {return new Symbol(TokenConstants.EQ);}
<YYINITIAL>{asterisco} {return new Symbol(TokenConstants.MULT);}
<YYINITIAL>{diagonal} {return new Symbol(TokenConstants.DIV);}
<YYINITIAL>{mas} {return new Symbol(TokenConstants.PLUS);}
<YYINITIAL>{menos} {return new Symbol(TokenConstants.MINUS);}
<YYINITIAL>{menor} {return new Symbol(TokenConstants.LT);}
<YYINITIAL>{asig} {return new Symbol(TokenConstants.ASSIGN);}
<YYINITIAL>{sele} {return new Symbol(TokenConstants.DARROW);}
<YYINITIAL>{menorigual} {return new Symbol(TokenConstants.LE);}
<YYINITIAL>{tipo} {AbstractSymbol idType=AbstractTable.idtable.addString(yytext());
                                return new Symbol(TokenConstants.TYPEID,idType);}
<YYINITIAL>{objeto} {AbstractSymbol idObject=AbstractTable.idtable.addString(yytext());
                                return new Symbol(TokenConstants.OBJECTID,idObject);}
<YYINITIAL>{int} {AbstractSymbol num = AbstractTable.inttable.addInt(Integer.parseInt(yytext()));
                    return new Symbol(TokenConstants.INT_CONST,num);}
<YYINITIAL> "*)" {return new Symbol(TokenConstants.ERROR, "Unmatched *)");}
<YYINITIAL> "\n" {curr_lineno++;}


<YYINITIAL> (\") {string_buf.setLength(0);rECT();
                  rECN();rED();EC();
                  yybegin(STRING);}
<YYINITIAL> ("(*") {yybegin(COMENTS);}

<STRING> \" {


if((!ED) && (string_buf.length()>0)&&(string_buf.charAt(string_buf.length()-1) == '\\')) {
        string_buf.setCharAt(string_buf.length()-1,'\"');
} else {
        
        yybegin(YYINITIAL);
        while(ECN) {
            return new Symbol(TokenConstants.ERROR, new String("String contains null character"));
        }while(ECT) {
            return new Symbol(TokenConstants.ERROR, new String("String constant too long"));
        }while(!EC){
            AbstractSymbol string = AbstractTable.stringtable.addString(string_buf.toString());
            return new Symbol(TokenConstants.STR_CONST, string);
        }
    }
}
<STRING> (\n) {curr_lineno++;
if(string_buf.length()!= 0) {
    int menor=string_buf.length()-1;
    char caracterMenor = string_buf.charAt(menor);
    if(caracterMenor == '\\' && (!ED)) {
        string_buf.setCharAt(menor, '\n');
    } else { 
        EC=true;
        return new Symbol(TokenConstants.ERROR, "demasiado larga");
    }
} else {
    EC=true;
    return new Symbol(TokenConstants.ERROR, "demasiado larga");
}
} 
<STRING> [^\n] {if((!ECT)&&(!ECN)){
if(yytext().charAt(0)=='\0'){
    ECN=true;
    EC=true;
}else{
    if(string_buf.length()>0){
        int menosUno=string_buf.length()-1;
        char caracterMenor=string_buf.charAt(menosUno);
        if(caracterMenor=='\\'&&(!ECN)){
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
                     ED=true;
                }
            }else{
                string_buf.setCharAt(menosUno, chars);
            }
        }else{
            if(yytext().charAt(0) == '\\') {
                ED = false;
            }
            string_buf.append(yytext());
        }
    }else{
        string_buf.append(yytext());
    }
    if(string_buf.length() >= MAX) {
        EC=true;
        ECT = true;
    }
}
}
}

<COMENTS> "\n" {curr_lineno++;}
<COMENTS> [^] {/* */}
<COMENTS> ("*)") {yybegin(YYINITIAL);}
[^] { return new Symbol(TokenConstants.ERROR,yytext());}