parser grammar ecfunc;

import datatypes;

options{
    tokenVocab = generalLexer;
}


file : line? (EOL+ line)* EOL* EOF;

line : constant
     | functionDefinition;


constant : LET cttypeDefinition constAssign? END_STATEMENT;
constAssign : Assign constExpression;

constExpression: numericalConstExpression | booleanConstExpression | literal;
runtimeExpression: constExpression | numericalRuntimeExpression | booleanRuntimeExpression;

functionDefinition: DEF Id
                       ( AngleBOpen  cttypeDefinition (ParamSeparator cttypeDefinition)*   AngleBClose)?
                         RoundBOpen (rttypeDefinition (ParamSeparator rttypeDefinition)*)? RoundBClose
                       ( TypeDefine  rttype)?
                         FunctionBodyOpen (functionBody? EOL)* FunctionBodyClose;


functionBody: mcCommand;

mcCommand: MCCommand ( SPACE argument)*;

argument : (Parameter
           | selector
           | nbt
           | interpolation
           | EscapeInterpolation
           | NoEscape
           | InterpolationClose
           | NBTOpen
           | At)*;


interpolation: InterpolationOpen runtimeExpression InterpolationClose;



rttypeDefinition : Id (TypeDefine rttype)?;
cttypeDefinition : Id TypeDefine cttype;

numericalConstExpression :<assoc=right> numericalConstExpression Pow numericalConstExpression        #constExponent
                         | constUnaryOp                                                              #constUnary
                         | numericalConstExpression op=( Mul | Div | Mod ) numericalConstExpression  #constBinOp
                         | numericalConstExpression op=( Add | Min ) numericalConstExpression        #constBinOp
                         | numericalConstExpression op=( LeftShift
                                                       | ArithmicRightShift
                                                       | LogicalRightShift) numericalConstExpression #constBinOp
                         | numericalConstExpression op=BitAnd numericalConstExpression               #constBinOp
                         | numericalConstExpression op=BitXor numericalConstExpression               #constBinOp
                         | numericalConstExpression op=BitOr  numericalConstExpression               #constBinOp
                         ;

constUnaryOp : numericConstValue
             | Id
             | op=Min    numericConstValue
             | op=BitNot numericConstValue
             ;


numericConstValue : numericalValue
                  | RoundBOpen numericalConstExpression RoundBClose
                  ;

booleanConstExpression : LogNot booleanConstExpression                                                      #constNot
                       | numericalConstExpression cmp=(LessThan | LessEqual | MoreThan | MoreEqual) numericalConstExpression #constCmp
                       | numericalConstExpression ( cmp=(Equals | NotEquals) numericalConstExpression
                                                  | cmp=Matches range
                                                  )                                                       #constCmp
                       | booleanConstExpression LogAnd booleanConstExpression                             #constLogicalAnd
                       | booleanConstExpression LogOr  booleanConstExpression                             #constLogicalOr
                       | booleanConstValue                                                                #constBool
                       ;

booleanConstValue : Bool
                  | RoundBOpen booleanConstExpression RoundBClose
                  ;

numericalRuntimeExpression : numericalConstExpression                                                      #constNumericValue
                           | <assoc=right> numericalRuntimeExpression Pow numericalRuntimeExpression       #runtimeExponent
                           | runtimeUnaryOp                                                                #runtimeUnary
                           | numericalRuntimeExpression op=( Mul | Div | Mod ) numericalRuntimeExpression  #runtimeBinOp
                           | numericalRuntimeExpression op=( Add | Min ) numericalRuntimeExpression        #runtimeBinOp
                           | numericalRuntimeExpression op=( LeftShift
                                                         | ArithmicRightShift
                                                         | LogicalRightShift) numericalRuntimeExpression   #runtimeBinOp
                           | numericalRuntimeExpression op=BitAnd numericalRuntimeExpression               #runtimeBinOp
                           | numericalRuntimeExpression op=BitXor numericalRuntimeExpression               #runtimeBinOp
                           | numericalRuntimeExpression op=BitOr  numericalRuntimeExpression               #runtimeBinOp
                           ;

runtimeUnaryOp : constUnaryOp
               | numericRuntimeValue
               | Id
               | op=Min    numericRuntimeValue
               | op=BitNot numericRuntimeValue
               ;


numericRuntimeValue : Shell mcCommand ShellEnd
                    | RoundBOpen numericalRuntimeExpression RoundBClose
                    ;

booleanRuntimeExpression : booleanConstExpression                                                               #constBoolValue
                         | LogNot booleanRuntimeExpression                                                      #runtimeNot
                         | numericalRuntimeExpression cmp=(LessThan | LessEqual | MoreThan | MoreEqual) numericalRuntimeExpression #runtimeCmp
                         | numericalRuntimeExpression ( cmp=(Equals | NotEquals) numericalRuntimeExpression
                                                    | cmp=Matches range
                                                    )                                                      #runtimeCmp
                         | booleanRuntimeExpression LogAnd booleanRuntimeExpression                              #runtimeLogicalAnd
                         | booleanRuntimeExpression LogOr  booleanRuntimeExpression                              #runtimeLogicalOr
                         | booleanConstValue                                                               #runtimeBool
                         ;

booleanRuntimeValue : booleanConstValue
                    | Shell mcCommand ShellEnd
                    | RoundBOpen booleanRuntimeExpression RoundBClose
                    ;

rttype : simple_rttype
       | LIST AngleBOpen rttype AngleBClose
       | scorelike_type (RoundBOpen range RoundBClose)?
       ;

cttype : rttype
       | LIST AngleBOpen cttype AngleBClose
       | simple_cttype
       ;
