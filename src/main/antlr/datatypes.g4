grammar datatypes;

test: literal (('\r'? '\n')+ literal)* ('\r'? '\n')* EOF;

literal : Bool | Byte | Short | Int | Long | Float | Double | String | selector;

selector : SelectorType ('[' selectorOptions ']')?;

selectorOptions: selectorOption (',' selectorOption)*;

selectorOption:
    ('x' | 'y' | 'z' | 'distance' | 'dx' | 'dy' | 'dz' ) '='  numericalRange |
    ('tag' | 'team') '=' unquotedString |
    'limit' '=' Int;


numericalRange: decimal ('..' decimal?)? | '..' decimal?;

SelectorType : '@' [apres];



Bool : T R U E | F A L S E;
Byte : WHOLE_NUMBER B;
Short : WHOLE_NUMBER S;
Long : WHOLE_NUMBER L;
Int : WHOLE_NUMBER;

Float : DECIMAL F;
Double : DECIMAL D;
Decimal : DECIMAL;

String : '"' ((ESCAPE | ~["\r\n])*) '"';

unquotedStringPart: InUnquotedString
                | Bool | Byte | Short | Int | Long | Float | Double;

decimal: Decimal | Int;
unquotedString: unquotedStringPart+ ;


InUnquotedString: [0-9a-zA-Z_-] | '+' | '.';
fragment DIGITS : [0-9]+;
fragment HEX_DIGIT : [0-9a-fA-F];
fragment SIGN : [+-];
fragment INTEGER_PART : SIGN? DIGITS;
fragment FRACTIONAL_PART : '.' DIGITS;
fragment WHOLE_NUMBER : INTEGER_PART;
fragment DECIMAL : SIGN? INTEGER_PART FRACTIONAL_PART?
                 | SIGN? FRACTIONAL_PART;
fragment ESCAPE : '\\' [n\\"]
                | '\\u' HEX_DIGIT HEX_DIGIT HEX_DIGIT HEX_DIGIT;

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


WS: (' ' | '\t')+ -> skip;
