lexer grammar generalLexer;


channels {
        WS_CHANNEL,
        COMMENT_CHANNEL
    }

// MAIN MODE:

EOL: '\n' '\r'?;

LET     : 'let'      -> mode(CONSTANT_DEFINITION_MODE);
DEF     : 'function' -> mode(FUNCTION_DEFINITION_MODE);
COMMENT : '#'        -> mode(COMMENT_MODE), channel(COMMENT_CHANNEL);

END_STATEMENT: ';';

WS: (' ' | '\t')+ -> channel(WS_CHANNEL);

mode COMMENT_MODE;
CM_EOL: EOL    -> type(EOL), mode(DEFAULT_MODE);
COMMENT_TEXT: ~[\r\n]+ -> channel(COMMENT_CHANNEL);

mode FUNCTION_DEFINITION_MODE;
FDM_EOL: EOL -> type(EOL);
FDM_RoundBOpen : RoundBOpen  -> type(RoundBOpen) ;
FDM_RoundBClose: RoundBClose -> type(RoundBClose);
AngleBOpen    : '<';
AngleBClose   : '>';

FDM_Id: Id -> type(Id);
FDM_TypeDefine : TypeDefine  -> type(TypeDefine), pushMode(TYPE_MATCH_MODE);
ParamSeparator : ',';

FunctionBodyOpen : '{' -> mode(DEFAULT_MODE), pushMode(FUNCTION_BODY_MODE);

WS_FDM: (' ' | '\t')+ -> channel(WS_CHANNEL);


mode TYPE_MATCH_MODE;

TOKEN       : 'token';
PATH        : 'path';
COMMAND     : 'command';
TypeFUCNTION: 'function' -> type(FUNCTION);
SELECTOR    : 'selector';
INTRANGE    : 'intrange';
DOUBLERANGE : 'doublerange';
BYTE        : 'byte';
SHORT       : 'short';
INT         : 'int';
BOOL        : 'bool';
SCORE       : 'score';
LONG        : 'long';
FLOAT       : 'float';
DOUBLE      : 'double';
COMPOUND    : 'compound';
STRING      : 'string';

TypeLIST    : 'list' -> type(LIST);
ListOpen    : AngleBOpen  -> type(AngleBOpen) ;
ListClose   : AngleBClose -> type(AngleBClose);
RangeOpen   : RoundBOpen  -> type(RoundBOpen) , pushMode(MATCH_RANGE_MODE), pushMode(VOID_SPACE_MODE);
RangeClose  : RoundBClose -> type(RoundBClose);

END: {} -> skip, popMode;

WS_TMM: WS -> channel(WS_CHANNEL);


mode MATCH_RANGE_MODE;
MRM_Integer: Integer -> type(Integer);
MRM_Decimal: Decimal -> type(Decimal);
Sign: '-';
RangeSeperator: '..';
MRM_END: END -> skip, popMode;


mode CONSTANT_DEFINITION_MODE;

CDM_END_STATEMENT: END_STATEMENT -> type(END_STATEMENT), mode(DEFAULT_MODE);
CDM_EOL: EOL -> type(EOL);

Id : [a-zA-Z_] [0-9a-zA-Z_-]*;
TypeDefine : ':' -> pushMode(TYPE_MATCH_MODE);
CDM_Assign : Assign -> type(Assign), pushMode(EXPRESION_MODE);

WS_CDM: WS -> channel(WS_CHANNEL);

mode EXPRESION_MODE;


// BracketPairs
RoundBOpen  : '(';
RoundBClose : ')';
SquareBOpen : '[';
SquareBClose: ']';

// Opperators
Pow: '**';
Mul: '*';
Div: '/';
Mod: '%';
Add: '+';
Min: '-';

LogNot: '!';
LogAnd: '&&';
LogOr : '||';

BitNot: '~';
BitAnd: '&';
BitXor: '^';
BitOr : '|';
LeftShift: '<<';
ArithmicRightShift: '>>';
LogicalRightShift : '>>>';

Assign   : '=';
Equals   : '==';
NotEquals: '!==';
LessThan : '<';
LessEqual: '<=';
MoreThan : '>';
MoreEqual: '>=';

PowAssign: '**=';
MulAssign: '*=';
DivAssign: '/=';
ModAssign: '%=';
AddAssign: '+=';
MinAssign: '-=';

Matches: 'matches' -> pushMode(MATCH_RANGE_MODE), pushMode(VOID_SPACE_MODE);

LogNotAssign: '!=';
LogAndAssign: '&&=';
LogOrAssign : '||=';

BitNotAssign: '~=';
BitAndAssign: '&=';
BitXorAssign: '^=';
BitOrAssign : '|=';
LeftShiftAssign: '<<=';
ArithmicRightShiftAssign: '>>';
LogicalRightShiftAssign : '>>>';

EM_Id : Id -> type(Id);
Bool : T R U E | F A L S E;
Byte : INTEGER_PART B;
Short : INTEGER_PART S;
Long : INTEGER_PART L;
Integer: INTEGER_PART;
Double: DECIMAL 'd';
Float: DECIMAL 'f';
Decimal: DECIMAL;
String : '"' ((ESCAPE | ~["\r\n])*) '"';
SelectorType: '@' [apres] -> pushMode(SELECTOR_MODE);

fragment DIGITS : [0-9]+;
fragment HEX_DIGIT : [0-9a-fA-F];
fragment INTEGER_PART : DIGITS;
fragment FRACTIONAL_PART : '.' DIGITS;
fragment WHOLE_NUMBER : INTEGER_PART;
fragment DECIMAL : INTEGER_PART FRACTIONAL_PART?
                 | FRACTIONAL_PART;
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

WS_EM: WS -> channel(WS_CHANNEL);
EM_END: END -> skip, popMode;


mode SELECTOR_MODE;

SelectorOpen      : '[';
SelectorClose     : ']' -> popMode;
SelectorSeperator : ',';
SelectorNameSpace : ':' -> pushMode(MATCH_UNQUOTED_STRING);

SM_Is : Is -> type(Is);
Not       : LogNot;


DISTANCE   : 'distance'   -> pushMode(MATCH_RANGE_MODE),      pushMode(VOID_SPACE_MODE);
LEVEL      : 'level'      -> pushMode(MATCH_RANGE_MODE),      pushMode(VOID_SPACE_MODE);
X_ROTATION : 'x_rotation' -> pushMode(MATCH_RANGE_MODE),      pushMode(VOID_SPACE_MODE);
Y_ROTATION : 'y_rotation' -> pushMode(MATCH_RANGE_MODE),      pushMode(VOID_SPACE_MODE);

SelTAG     : 'tag'        -> type(TAG),
                             pushMode(MATCH_UNQUOTED_STRING), pushMode(VOID_SPACE_MODE);
SelTEAM    : 'team'       -> type(TEAM),
                             pushMode(MATCH_UNQUOTED_STRING), pushMode(VOID_SPACE_MODE);

TYPE       : 'type'       -> pushMode(MATCH_ENTITY),          pushMode(VOID_SPACE_MODE);

NAME       : 'name'       -> pushMode(MATCH_GENERAL_STRING),  pushMode(VOID_SPACE_MODE);

SCORES     : 'scores'     -> pushMode(MATCH_SCORES),          pushMode(VOID_SPACE_MODE);

SORT       : 'sort'      ;
NEAREST    : 'nearest'   ;
FURTHEST   : 'furthest'  ;
RANDOM     : 'random'    ;
ARBITRARY  : 'arbitrary' ;

SelGAMEMODE: 'gamemode'   -> type(GAMEMODE);
SURVIVAL   : 'survival'  ;
CREATIVE   : 'creative'  ;
ADVENTURE  : 'adventure' ;
SPECTATOR  : 'spectator' ;

X          : 'x'         ;
Y          : 'y'         ;
Z          : 'z'         ;
DX         : 'dx'        ;
DY         : 'dy'        ;
DZ         : 'dz'        ;
LIMIT      : 'limit'     ;

SM_Integer: Integer -> type(Integer);
SM_Decimal: Decimal -> type(Decimal);

WS_SM: WS -> channel(WS_CHANNEL);
SM_END: END -> skip, popMode;

mode MATCH_SCORES;
// Void space mode handles '=' so i was lazy. has the ability to match " ustring = range"
CurlyOpen      : '{' -> pushMode(MATCH_RANGE_MODE),      pushMode(VOID_SPACE_MODE),
                        pushMode(MATCH_UNQUOTED_STRING), pushMode(VOID_SPACE_MODE);
ScoreSeperator : ',' -> pushMode(MATCH_RANGE_MODE),      pushMode(VOID_SPACE_MODE),
                        pushMode(MATCH_UNQUOTED_STRING), pushMode(VOID_SPACE_MODE);
CurlyClose     : '}' -> popMode;



mode FUNCTION_BODY_MODE;
ADVANCEMENT     : 'advancement'     -> pushMode(ADVANCEMENT_COMMAND_MODE), pushMode(MATCH_SPACE),
                                       pushMode(MATCH_PLAYER_KEYWORD)    , pushMode(MATCH_SPACE),
                                       pushMode(MATCH_COMMAND_KEYWORD)   , pushMode(MATCH_SPACE);
BAN             : 'ban'             ;
BOSSBAR         : 'bossbar'         ;
CLEAR           : 'clear'           ;
CLONE           : 'clone'           ;
DATA            : 'data'            ;
DATAPACK        : 'datapack'        ;
DEBUG           : 'debug'           ;
DEFAULTGAMEMODE : 'defaultgamemode' ;
DEOP            : 'deop'            ;
DIFFICULTY      : 'difficulty'      ;
EFFECT          : 'effect'          ;
ENCHANT         : 'enchant'         ;
EXPERIENCE      : 'experience'      ;
EXECUTE         : 'execute'         ;
FILL            : 'fill'            ;
FORCELOAD       : 'forceload'       ;
FUNCTION        : 'function'        ;
GAMEMODE        : 'gamemode'        ;
GAMERULE        : 'gamerule'        ;
GIVE            : 'give'            ;
HELP            : 'help'            ;
KICK            : 'kick'            ;
KILL            : 'kill'            ;
LIST            : 'list'            ;
LOCATE          : 'locate'          ;
ME              : 'me'              ;
OP              : 'op'              ;
PARDON          : 'pardon'          ;
PARTICLE        : 'particle'        ;
PLAYSOUND       : 'playsound'       ;
PUBLISH         : 'publish'         ;
RECIPE          : 'recipe'          ;
RELOAD          : 'reload'          ;
REPLACEITEM     : 'replaceitem'     ;
SAVE            : 'save'            ;
SAY             : 'say'             ;
SCOREBOARD      : 'scoreboard'      ;
SEED            : 'seed'            ;
SETBLOCK        : 'setblock'        ;
SETIDLETIMEOUT  : 'setidletimeout'  ;
SETWORLDSPAWN   : 'setworldspawn'   ;
SPAWNPOINT      : 'spawnpoint'      ;
SPREADPLAYERS   : 'spreadplayers'   ;
STOP            : 'stop'            ;
STOPSOUND       : 'stopsound'       ;
SUMMON          : 'summon'          ;
TAG             : 'tag'             ;
TEAM            : 'team'            ;
TELEPORT        : 'teleport'        ;
TELL            : 'tell'            ;
TELLRAW         : 'tellraw'         ;
TIME            : 'time'            ;
TITLE           : 'title'           ;
TP              : 'tp'              ;
TRIGGER         : 'trigger'         ;
WEATHER         : 'weather'         ;
WHITELIST       : 'whitelist'       ;
WORLDBORDER     : 'worldborder'     ;

FunctionBodyClose: '}' -> popMode;

FBM_SM : WS  -> channel(WS_CHANNEL);
FBM_EOL: EOL -> type(EOL);

mode MATCH_COMMAND_KEYWORD;
MCgrant  : 'grant'  -> popMode;
MCrevoke : 'revoke' -> popMode;

mode ADVANCEMENT_COMMAND_MODE;
ADVonly : 'only' -> mode(MATCH_GREEDY_STRING), pushMode(MATCH_SPACE_END),
                    pushMode(MATCH_RESOURCE) , pushMode(MATCH_SPACE);
ADVuft: ('until' | 'from' | 'through') -> mode(MATCH_RESOURCE), pushMode(MATCH_SPACE);
ADVeverything: 'everything' -> popMode;

mode MATCH_PLAYER_KEYWORD;
Selector   : SelectorType -> type(SelectorType), mode(SELECTOR_MODE);
PlayerName : PN PN PN (PN PN PN PN PN PN)? (PN PN PN PN)? (PN PN)? PN?;

fragment PN: [a-zA-Z0-9];

mode MATCH_ENTITY;
ME_US: UnquotedString -> type(UnquotedString), popMode;
NS: ':';
ME_END: END -> skip, popMode;


mode MATCH_UNQUOTED_STRING;
UnquotedString: [a-zA-Z0-9_\-+.]+ -> popMode;


mode MATCH_GENERAL_STRING;
MGS_US: UnquotedString -> type(UnquotedString), popMode;
MGS_QS: String -> type(String), popMode;

mode MATCH_GREEDY_STRING;
GREEDY_STRING: ~[\n\r]+ -> popMode;
MGS_END: END -> skip, popMode;

mode MATCH_RESOURCE;
NSSeperator: ':';
NameSpace  : [0-9a-z_.-]+ ;
Path       : [0-9a-z_/.-]+;

MR_END: END -> skip, popMode;

mode VOID_SPACE_MODE;
Is: '=';
WS_Not: Not -> type(Not);
WS_VSM: WS -> channel(WS_CHANNEL);
VSM_END: END -> skip, popMode;


mode MATCH_SPACE;
SPACE        : ' '+ -> channel(WS_CHANNEL), popMode;

mode MATCH_SPACE_END;
MSE_SPACE    : ' '+ -> channel(WS_CHANNEL), popMode;
MSE_END      : END  -> skip, mode(FUNCTION_BODY_MODE);
