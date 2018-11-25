grammar ecfunc;

import datatypes;

file : EOL? lines? EOL? EOF;

lines : line (EOL line)*;

line : constant;

constant : 'let' Id ':' cttype constAssign? ';';

constAssign : '=' (numericalConstExpression | booleanConstExpression | literal);

numericalConstExpression :<assoc=right> numericalConstExpression '**' numericalConstExpression     #constExponent
                         | constUnaryOp                                                            #constUnary
                         | numericalConstExpression op=('*' | '/' | '%') numericalConstExpression  #constBinOp
                         | numericalConstExpression op=('+' | '-') numericalConstExpression        #constBinOp
                         | numericalConstExpression shiftOp numericalConstExpression               #constShift
                         | numericalConstExpression op='&' numericalConstExpression                #constBinOp
                         | numericalConstExpression op='^' numericalConstExpression                #constBinOp
                         | numericalConstExpression op='|' numericalConstExpression                #constBinOp
                         | numericConstValue                                                       #constValue
                         ;

constUnaryOp : op+='-' (op+='~')? numericConstValue
             | op+='~' (op+='-')? numericConstValue
             ;

shiftOp : // these are split into multiple tokens so that the parts can still be matched by the lexer for templates
          // TODO: check for whitespace
          '<' '<'     #leftShift
        | '>' '>'     #arithRightShift
        | '>' '>' '>' #logicalRightShift
        ;

numericConstValue : unsignedNumericalValue
            | '(' numericalConstExpression ')'
            ;

booleanConstExpression : '!' booleanConstExpression                                                      #constNot
                       | numericalConstExpression cmp=('<' | '<=' | '>' | '>=') numericalConstExpression #constCmp
                       | numericalConstExpression ( cmp=('==' | '!==') numericalConstExpression
                                                  | cmp='matches' numericalRange
                                                  )                                                      #constCmp
                       | booleanConstExpression '&&' booleanConstExpression                              #constLogicalAnd
                       | booleanConstExpression '||' booleanConstExpression                              #constLogicalOr
                       | booleanConstValue                                                               #constBool
                       ;

booleanConstValue : Bool
                  | '(' booleanConstExpression ')'
                  ;

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