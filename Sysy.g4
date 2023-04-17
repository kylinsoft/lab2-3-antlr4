grammar Sysy;

import SysyLex;

compUnit : (decl | funcDef)* EOF;

decl : constDecl | varDecl;

constDecl : 'const' bType constDef (',' constDef)* ';' ;

bType: 'int' | 'float';

constDef : ID ('[' constExp ']')* '=' constInitVal;

constInitVal
    : constExp # scalarConstInitVal
    | '{' (constInitVal (',' constInitVal)* )? '}' # listConstInitVal
    ;

varDecl : bType varDef (',' varDef)* ';';

varDef
    : ID ('[' constExp ']')* # uninitVarDef
    | ID ('[' constExp ']')* '=' initVal # initVarDef
    ;

initVal
    : exp # scalarInitVal
    | '{' (initVal (',' initVal)* )? '}' # listInitval
    ;

funcDef : funcType ID '(' (funcFParams)? ')' block;

funcType : 'void' | 'int' |'float';

funcFParams : funcFParam (',' funcFParam)*;

funcFParam : bType ID ('[' ']' ('[' constExp ']')* )?;

block : '{' (blockItem)* '}';

blockItem : decl | stmt;

stmt
    : lVal '=' exp ';' # assignment
    | (exp)? ';' # expStmt
    | block # blockStmt
    | 'if' '(' cond ')' stmt # ifStmt1
    | 'if' '(' cond ')' stmt 'else' stmt # ifStmt2
    | 'while' '(' cond ')' stmt # whileStmt
    | 'break' ';' # breakStmt
    | 'continue' ';' # continueStmt
    | 'return' (exp)? ';' # returnStmt
    ;

exp : addExp;

cond : lOrExp;

lVal : ID ('[' exp ']')*;

primaryExp
    : '(' exp ')' # primaryExp1
    | lVal # primaryExp2
    | number # primaryExp3
    ;

number : INT_LIT | FLOAT_LIT;

unaryExp
    : primaryExp # unary1
    | ID '(' (funcRParams)? ')' # unary2
    | unaryOp unaryExp # unary3
    ;

unaryOp : '+' | '-' | '!';

funcRParams : funcRParam (',' funcRParam)*;

funcRParam
    : exp # expAsRParam
    | STRING # stringAsRParam
    ;

mulExp
    : unaryExp # mul1
    | mulExp ('*' | '/' | '%') unaryExp # mul2
    ;

addExp
    : mulExp # add1
    | addExp ('+' | '-') mulExp # add2
    ;

relExp
    : addExp # rel1
    | relExp ('<' | '>' | '<=' | '>=') addExp # rel2
    ;
eqExp
    : relExp # eq1
    | eqExp ('==' | '!=') relExp # eq2
    ;

lAndExp
    : eqExp # lAnd1
    | lAndExp '&&' eqExp # lAnd2
    ;

lOrExp
    : lAndExp # lOr1
    | lOrExp '||' lAndExp # lOr2
    ;

constExp
    : addExp
    ;
