grammar Cool;


@members{
    StringBuffer string_buff = new StringBuffer();
}

sintactico: (clase SEMI)+                                                                                               #repeticionClase
        ;

clase: CLASS TYPEID (INHERITS TYPEID)? LBRACE (contenido_clase SEMI)* RBRACE                                            #definirClase
    ;

contenido_clase: OBJECTID LPAREN (parametro (COMMA parametro)*)?  RPAREN COLON TYPEID LBRACE expresion RBRACE           #metodoClase
        | OBJECTID COLON TYPEID (ASSIGN expresion)?                                                                     #variableCLase
        ;

parametro: OBJECTID COLON TYPEID                                                                                        #parametroClase
        ;

expresion: OBJECTID ASSIGN expresion                                                                                    #asignacionExpresion

        | expresion (AT TYPEID)? DOT OBJECTID LPAREN (expresion (COMMA expresion)*)? RPAREN                             #dispatchStExpresion
        
        | OBJECTID LPAREN (expresion (COMMA expresion)*)? RPAREN                                                        #dispatchDiExpresion
      
        | IF expresion THEN expresion ELSE expresion FI                                                                 #condicionalExpresion
        | WHILE expresion LOOP expresion POOL                                                                           #cicloExpresion
        
        | LBRACE (expresion SEMI)+ RBRACE                                                                               #bloqueExpresion
        
        | LET OBJECTID COLON TYPEID (ASSIGN expresion)? (COMMA OBJECTID COLON TYPEID (ASSIGN expresion)?)* IN expresion #letExpresion
       
        | CASE expresion OF (OBJECTID COLON TYPEID DARROW expresion SEMI)+ ESAC                                         #caseExpresion
       
        | NEW TYPEID                                                                                                    #nuevoTipoExpresion
      
        | NEG expresion                                                                                                 #negExpresion
        | ISVOID expresion                                                                                              #isvoidExpresion
        
        | expresion op=(MULT|DIV) expresion                                                                             #multDivExpresion
        | expresion op=(PLUS|MINUS) expresion                                                                           #plusMinusExpresion
    
        | expresion LT expresion                                                                                        #ltExpresion
        | expresion LE expresion                                                                                        #leExpresion
        | expresion EQ expresion                                                                                        #eqExpresion
       
        | NOT expresion                                                                                                 #notExpresion
        | LPAREN expresion RPAREN                                                                                       #parentesisExpresion
       
        | OBJECTID                                                                                                      #objetoTipoExpresion
        | INT_CONST                                                                                                     #intExpresion
        | STR_CONST                                                                                                     #stringExpresion
        | TRUE                                                                                                          #trueExpresion
        | FALSE                                                                                                         #falseExpresion
        ;

CLASS : ([cC][lL][aA][sS][sS]|[cC][lL][aA][sS][eE]) {setText("class");};
ELSE : ([eE][lL][sS][eE]|[dD][eE][lL][oO][cC][oO][nN][tT][rR][aA][rR][iI][oO]) {setText("else");};
FI : ([fF][iI]|[iI][sS]) {setText("fi");};
IF : ([iI][fF]|[sS][iI]) {setText("if");};
IN : ([iI][nN]|[eE][nN]) {setText("in");};
INHERITS : ([iI][nN][hH][eE][rR][iI][tT][sS]|[hH][eE][rR][eE][dD][aA]) {setText("inherits");};
ISVOID : ([iI][sS][vV][oO][iI][dD]|[eE][sS][vV][aA][cC][iI][oO]) {setText("isvoid");};
LET : ([lL][eE][tT]|[lL][aA][vV][aA][rR]) {setText("let");};
LOOP : ([lL][oO][oO][pP]|[cC][iI][cC][lL][oO]) {setText("loop");};
POOL : ([pP][oO][oO][lL]|[oO][lL][cC][iI][cC]) {setText("pool");};
THEN : ([tT][hH][eE][nN]|[eE][nN][tT][oO][nN][cC][eE][sS]) {setText("then");};
WHILE : ([wW][hH][iI][lL][eE]|[mM][iI][eE][nN][tT][rR][aA][sS]) {setText("while");};
CASE : ([cC][aA][sS][eE]|[eE][nN][cC][aA][sS][oO]) {setText("case");};
ESAC : ([eE][sS][aA][cC]|[oO][sS][aA][cC][nN][eE]) {setText("esac");};
NEW : ([nN][eE][wW]|[nN][uU][eE][vV][oO]) {setText("new");};
OF : ([oO][fF]|[dD][eE]) {setText("of");};
NOT : ([nN][oO][tT]|[nN][eE][lL]) {setText("not");};
LBRACE:'{';
RBRACE:'}';
LPAREN:'(';
RPAREN:')';
COLON:':';
SEMI:';';
COMMA:',';
DOT:'.';
AT:'@';
NEG:'~';
EQ: '=';
MULT:'*';
DIV:'/';
PLUS:'+';
MINUS:'-';
LT:'<';
ASSIGN:'<-';
DARROW:'=>';
LE:'<=';
TYPEID:[A-Z][a-zA-Z_0-9]*;
OBJECTID:[a-z][a-zA-Z_0-9]*;
TRUE : (('f')[aA][lL][sS][eE]|('f')[aA][lL][sS][oO]) {setText("true");};
FALSE : (('t')[rR][uU][eE]|('v')[eE][rR][dD][aA][dD][eE][rR][oO]) {setText("false");};
BOOL_CONST : TRUE|FALSE;
INT_CONST : [0-9]+;

STR_CONST : '"'{string_buff.setLength(0);} ('\\b'{string_buff.append('\b');}|'\\t'{string_buff.append('\t');}|'\\n'{string_buff.append('\n');}
        |'\\f'{string_buff.append('\f');}|'\\'{string_buff.append('\\');}|'\\"'{string_buff.append('\\');}|~('\\'|'"') {string_buff.append((char)_input.LA(-1));})* '"' {setText(string_buff.toString());};

ESPACIOBLANCO:[ \f\r\t\n]+ -> skip;
COMENTARIO_LINEA:'--' (.)+ -> skip;
COMENTARIO_MULTILINEA:'(*'[^]*'*)' -> skip;
ERROR: [^] {setText("Fallo");};