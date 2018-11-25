grammar ecfunc;

import datatypes;

file : (line? EOL)* line? EOF;

line : constant
     | functionDefinition;

constant : 'let' cttypeDefinition assignment? ';';

functionDefinition: 'function' Id '(' (rttypeDefinition (',' rttypeDefinition)*)? ')' (':' rttype)? '{' '}';

rttypeDefinition : Id (':' rttype)?;
cttypeDefinition : Id ':' cttype;

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

EOL: '\r'? '\n';
WS: (' ' | '\t')+ -> skip;

COMMENT: '#' .*? '\r'? '\n' -> channel(HIDDEN);

