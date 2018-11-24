grammar ecfunc;

import datatypes;

@header {
package ensconcer.transpiler.parser;
}

file : EOL? lines EOL? EOF;

lines: line (EOL line)*;

line: constant;

constant : 'let' Id ':' cttype assignment? ';';

assignment : '=' expression;

expression : literal;

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

EOL: ('\r'? '\n')+;
WS: (' ' | '\t')+ -> skip;