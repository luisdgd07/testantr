grammar Cool;
/*Segun https://github.com/antlr/antlr4/blob/master/doc/grammars.md, @members nos podria ser
para crear el string buffer, como el usado en jflex para la cadena String*/

@members{
    StringBuffer string_buff = new StringBuffer();
}
//sintactico, al poder usar el +,el ?, el * nos evitar hacer producciones extra como en cup
/*Podemos repetir la clase con su punto y coma*/
sintactico: (clase SEMI)+                                                                                               #repeticionClase
        ;
/*Estructura de clase donde puede o no puede heredad una vez de una clase asi mismo puede tener cero
 contenido en su clasecomo tambien varias veces distintos tipos de contenido*/
clase: CLASS TYPEID (INHERITS TYPEID)? LBRACE (contenido_clase SEMI)* RBRACE                                            #definirClase
    ;
/*En el contenido de la clase primeramente puede ser un metodo, donde este puede tener un parametro o muchos,
como tambien puede no tener parametros, y en su segundo que es un tipo de variable, puede tener cero o una asignacion*/
contenido_clase: OBJECTID LPAREN (parametro (COMMA parametro)*)?  RPAREN COLON TYPEID LBRACE expresion RBRACE           #metodoClase
        | OBJECTID COLON TYPEID (ASSIGN expresion)?                                                                     #variableCLase
        ;
/*El parametro solamente es un tipo de variable, ejemplo a:Int*/
parametro: OBJECTID COLON TYPEID                                                                                        #parametroClase
        ;
/*La expresion es el mas importante porque aca podemos tener todas las reducciones de expresion
primero empezando con una asignacion a un dato*/
expresion: OBJECTID ASSIGN expresion                                                                                    #asignacionExpresion
        /*Para esta produccion podemos tener cero o un arroba y tipoid como tambien cero o una expresion, como tambien muchas expresiones*/
        | expresion (AT TYPEID)? DOT OBJECTID LPAREN (expresion (COMMA expresion)*)? RPAREN                             #dispatchStExpresion
        /*Parecido al anterior, aca puede ir sin expresiones, como tambien puede tener una o muchas*/
        | OBJECTID LPAREN (expresion (COMMA expresion)*)? RPAREN                                                        #dispatchDiExpresion
        /*condicional y ciclo*/
        | IF expresion THEN expresion ELSE expresion FI                                                                 #condicionalExpresion
        | WHILE expresion LOOP expresion POOL                                                                           #cicloExpresion
        /*Establecemos un bloque de codigo, donde almenos una expresion y punto y coma debe ir*/
        | LBRACE (expresion SEMI)+ RBRACE                                                                               #bloqueExpresion
        /*Para let puede venir cero o una vez asignar expresion, y también puede venir muchas veces más el objeto con su tipo
        donde puede ser asignado o no una expresion*/
        | LET OBJECTID COLON TYPEID (ASSIGN expresion)? (COMMA OBJECTID COLON TYPEID (ASSIGN expresion)?)* IN expresion #letExpresion
        /*En el case podemos poner al menos un obteto con su tipo y expresion */
        | CASE expresion OF (OBJECTID COLON TYPEID DARROW expresion SEMI)+ ESAC                                         #caseExpresion
        /*nuevo tipo de id y tambien el isvoid*/
        | NEW TYPEID                                                                                                    #nuevoTipoExpresion
        /*El neg va antes de isvoid*/
        | NEG expresion                                                                                                 #negExpresion
        | ISVOID expresion                                                                                              #isvoidExpresion
        /*Operaciones, maneja sin problemas la ambiguedad, sin embargo, ya que es descendente el analisis
        tenemos que colocar en este orden de precedencia, primero los que se deben operar antes*/
        | expresion op=(MULT|DIV) expresion                                                                             #multDivExpresion
        | expresion op=(PLUS|MINUS) expresion                                                                           #plusMinusExpresion
        /*Ahora si podemos colocar los < <= e =*/
        | expresion LT expresion                                                                                        #ltExpresion
        | expresion LE expresion                                                                                        #leExpresion
        | expresion EQ expresion                                                                                        #eqExpresion
        /*Relizamos la negacion de expresion y agrupamiento con parentesis*/
        | NOT expresion                                                                                                 #notExpresion
        | LPAREN expresion RPAREN                                                                                       #parentesisExpresion
        /*Por ultimo el tipo, entero, cadena, boleano*/
        | OBJECTID                                                                                                      #objetoTipoExpresion
        | INT_CONST                                                                                                     #intExpresion
        | STR_CONST                                                                                                     #stringExpresion
        | TRUE                                                                                                          #trueExpresion
        | FALSE                                                                                                         #falseExpresion
        ;
//lexer
//Palabras reservadas, establecemos en ingles y en espaniol chilero gt
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
//Simbolos, se manejan los dados en utilities
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
//operadores
EQ: '=';
MULT:'*';
DIV:'/';
PLUS:'+';
MINUS:'-';
LT:'<';
ASSIGN:'<-';
DARROW:'=>';
LE:'<=';
//identificador, string, entero, booleano, objeto, tipo
TYPEID:[A-Z][a-zA-Z_0-9]*;
OBJECTID:[a-z][a-zA-Z_0-9]*;
TRUE : (('f')[aA][lL][sS][eE]|('f')[aA][lL][sS][oO]) {setText("true");};
FALSE : (('t')[rR][uU][eE]|('v')[eE][rR][dD][aA][dD][eE][rR][oO]) {setText("false");};
BOOL_CONST : TRUE|FALSE;
INT_CONST : [0-9]+;
/*Al no contar con los subestados de jflex se opta por poner todo en opciones
si viene \n \t \b \f el \\, tambien hubo donde teniamos el \", en el manual definitio de antlr4 pagina 185 y 243
vemos el uso que se le puede dar a input.LA para un char,este nos servira, asi mismo para dar una instruccion a
una parte definida dentro de {}, algo tipo precedencias*/
STR_CONST : '"'{string_buff.setLength(0);} ('\\b'{string_buff.append('\b');}|'\\t'{string_buff.append('\t');}|'\\n'{string_buff.append('\n');}
        |'\\f'{string_buff.append('\f');}|'\\'{string_buff.append('\\');}|'\\"'{string_buff.append('\\');}|~('\\'|'"') {string_buff.append((char)_input.LA(-1));})* '"' {setText(string_buff.toString());};
//comentarios y espacio blanco
ESPACIOBLANCO:[ \f\r\t\n]+ -> skip;
COMENTARIO_LINEA:'--' (.)+ -> skip;
COMENTARIO_MULTILINEA:'(*'[^]*'*)' -> skip;
ERROR: [^] {setText("Fallo");};