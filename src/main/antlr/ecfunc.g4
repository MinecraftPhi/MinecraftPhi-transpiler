parser grammar ecfunc;

import datatypes;

options{
    tokenVocab = generalLexer;
}


file : (line? EOL)* line? EOF;

line : constant;
     //| functionDefinition;

constant : LET cttypeDefinition constAssign? END_STATEMENT;
constAssign : Assign (numericalConstExpression | booleanConstExpression | literal);

//functionDefinition: FUNCTION Id '(' (rttypeDefinition (',' rttypeDefinition)*)? ')' (':' rttype)? '{' '}';

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
                                                  | cmp=Matches /*numericalRange*/
                                                  )                                                      #constCmp
                       | booleanConstExpression LogAnd booleanConstExpression                              #constLogicalAnd
                       | booleanConstExpression LogOr  booleanConstExpression                              #constLogicalOr
                       | booleanConstValue                                                               #constBool
                       ;

booleanConstValue : /*Bool
                  | */ RoundBOpen booleanConstExpression RoundBClose
                  ;

rttype : simple_rttype
       | LIST ListOpen rttype ListClose
       | scorelike_type (RangeOpen range RangeClose)?
       ;

cttype : rttype
       | LIST ListOpen cttype ListClose
       | simple_cttype
       ;

