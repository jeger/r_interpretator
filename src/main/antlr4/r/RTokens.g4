// derived from https://cran.r-project.org/doc/manuals/r-release/R-lang.html#Function-and-Variable-Index

lexer grammar RTokens;

// arithmetic operators
ADD : '+'; // server also as unary operator
SUB : '-'; // server also as unary operator
MUL : '*';
DIV : '/';
INT_DIV: '%/%';
EXP: '^' | '**';
MOD: '%%';

// equality and relation operators
NEQ: '!=';
GTE: '>=';
LTE: '<=';
GT: '>';
LT: '<';
EQ: '==';

// logical operators
NOT: '!';
AND: '&&';
OR: '||';
VECTOR_AND: '&';
VECTOR_OR: '|';


SEQUENCE: ':';

L_PAREN: '(';
R_PAREN: ')';
L_CURLY: '{';
R_CURLY: '}';
L_BRACKET: '[';
R_BRACKET: ']';


// keywords
PRINT : 'print' ;
LEFT_ASSIGN: '<-';
RIGHT_ASSIGN: '->';
IF : 'if' ;
ELSE : 'else' ;
WHILE : 'while' ;



// literals
ID              : [a-zA-Z]+ ;  // match identifiers
NUMBER          : [0-9]+ ('.' [0-9]+)?;   // match integers
STRINGLITERAL   : '"' ~ ["\r\n]* '"' ;
DOLLAR          : '$' ;
NEWLINE         :'\r'? '\n' ;  // return newlines to parser (end-statement signal)
WS              : [ \t]+ -> skip ; // toss out whitespace


STRING
 : '"' (~["\r\n] | '""')* '"'
 ;

COMMENT
 : '#' ~[\r\n]* -> skip
 ;

SPACE
 : [ \t\r\n] -> skip
 ;
