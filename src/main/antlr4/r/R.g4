grammar R;

// imports the other tokens and the grammar for expressions
import RTokens;

// a programm is a block followed by an end-of-file
prog:   (   statement (';'|NEWLINE)*
        |   NEWLINE
        )*
        EOF
    ;

// a block is a list of statementes where each statement is followed by
// either a newline or the end of file
block
    : statement*
    ;



// the list of accepted statements
statement
    : assignstmt
    | printstmt
    | ifstmt
    | whilestmt
    ;

// variable assignation.
assignstmt
    : ID LEFT_ASSIGN expression
    ;

// PRINT expr
printstmt
    : PRINT L_PAREN expression R_PAREN
    ;


ifstmt
    : IF condition_block (ELSE IF condition_block)* (ELSE stat_block)?
    ;

condition_block
    : L_PAREN expression R_PAREN stat_block
    ;

stat_block
    : L_CURLY block R_CURLY
    ;

whilestmt
    : WHILE L_PAREN expression R_PAREN statement
    ;


expression
    : number                                    # NumberExpr
    | id                                        # IdExpr
    | (L_PAREN expression R_PAREN)                # ParenExpr
    | expression op=(MUL|DIV|MOD) expression    # MulDivExpr
    | expression op=(ADD|SUB) expression        # AddSubExpr
    | expression op=(GTE|GT|LTE|LT|EQ|NEQ) expression   # RelExpr
    | NOT expression                            # NotExpr
    | expression AND expression                 # AndExpr
    | expression OR expression                  # OrExpr
    | <assoc=right> expression EXP expression   # ExpExpr
    | STRING                                    # StringExpr
    ;



number
    : NUMBER
    ;

id
    : ID
    ;
