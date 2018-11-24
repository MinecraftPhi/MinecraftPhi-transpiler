grammar ecfunc;

import datatypes;

file : EOL? lines? EOL? EOF;

lines : line (EOL line)*;

line : constant;

constant : 'let' Id ':' cttype assignment? ';';

assignment : '=' expression;

expression : literal;

rttype : simple_rttype
       | 'list' '<' rttype '>'
       | scorelike_type ('(' Range ')')?
       ;

cttype : 'list' '<' cttype '>'
       | simple_cttype
       | rttype
       ;

EOL: ('\r'? '\n')+;
WS: (' ' | '\t')+ -> skip;