parser grammar ecfunc;

import datatypes, commands;

options{
    tokenVocab = generalLexer;
}



file : line? (EOL+ line)* EOL* EOF;

line : constant
     | functionDefinition;


constant : LET cttypeDefinition constAssign? END_STATEMENT;
constAssign : Assign (numericalConstExpression | booleanConstExpression | literal);

functionDefinition: DEF Id
                       ( AngleBOpen  cttypeDefinition (ParamSeparator cttypeDefinition)*   AngleBClose)?
                         RoundBOpen (rttypeDefinition (ParamSeparator rttypeDefinition)*)? RoundBClose
                       ( TypeDefine  rttype)?
                         FunctionBodyOpen functionBody* FunctionBodyClose;

functionBody: mcCommand | EOL;

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
                                                  )                                                      #constCmp
                       | booleanConstExpression LogAnd booleanConstExpression                              #constLogicalAnd
                       | booleanConstExpression LogOr  booleanConstExpression                              #constLogicalOr
                       | booleanConstValue                                                               #constBool
                       ;

booleanConstValue : /*Bool
                  | */ RoundBOpen booleanConstExpression RoundBClose
                  ;

rttype : simple_rttype
       | LIST AngleBOpen rttype AngleBClose
       | scorelike_type (RoundBOpen range RoundBClose)?
       ;

cttype : rttype
       | LIST AngleBOpen cttype AngleBClose
       | simple_cttype
       ;

