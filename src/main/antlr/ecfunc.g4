grammar ecfunc;

@header {
package ensconcer.transpiler.parser;
}

file : constant*;

constant : 'let' KEYWORD ':' cttype assignment? ';';

assignment : '=' expression;

expression : literal;

literal : BOOL | BYTE | SHORT | INT | LONG | FLOAT | DOUBLE | STRING;

rttype : 'byte'
     | 'short'
     | 'int'
     | 'long'
     | 'float'
     | 'double'
     | 'compound'
     | 'list' '<' rttype '>'
     | 'bool'
     | 'score'
     | 'string';

cttype : 'token'
       | 'path'
       | 'command'
       | 'function'
       | 'selector'
       | 'intrange'
       | 'doublerange'
       | 'list' '<' cttype '>'
       | rttype;

BOOL : T R U E
     | F A L S E;

BYTE : WHOLE_NUMBER B;

SHORT : WHOLE_NUMBER S;

INT : WHOLE_NUMBER;

LONG : SIGN? INTEGER_PART L;

FLOAT : DECIMAL F;

DOUBLE : DECIMAL D;

STRING : '"' (ESCAPE | ~["\r\n])* '"';

KEYWORD : [a-zA-Z_] [0-9a-zA-Z_-]*;

// Fragments used for case insensitive matching
fragment A : [aA];
fragment B : [bB];
fragment D : [dD];
fragment E : [eE];
fragment F : [fF];
fragment L : [lL];
fragment R : [rR];
fragment S : [sS];
fragment T : [tT];
fragment U : [uU];

fragment DIGITS : [0-9]+;
fragment HEX_DIGIT : [0-9a-fA-F];
fragment SIGN : [+-];
fragment INTEGER_PART : SIGN? DIGITS;
fragment FRACTIONAL_PART : '.' DIGITS;
fragment WHOLE_NUMBER : SIGN? INTEGER_PART;
fragment DECIMAL : SIGN? INTEGER_PART FRACTIONAL_PART?
                 | SIGN? FRACTIONAL_PART;
fragment ESCAPE : '\\' [n\\"]
                | '\\u' HEX_DIGIT HEX_DIGIT HEX_DIGIT HEX_DIGIT;