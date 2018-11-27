parser grammar datatypes;

import keywords;

options{
    tokenVocab = generalLexer;
}

literal : signedInteger | String | selector;

signedInteger: s=(Sign|Min)? i=Integer;
intRange: signedInteger RangeSeperator signedInteger?| RangeSeperator signedInteger | signedInteger;

signedDecimal: s=(Sign|Min)? i=(Integer|Double);
decimalRange: signedDecimal RangeSeperator signedDecimal?| RangeSeperator signedDecimal | signedDecimal;

range: intRange | decimalRange;

numericalValue: s=(Sign|Min)? (Integer | Byte | Short | Long | Double | Float | Decimal );

selector : SelectorType (SelectorOpen selectorOptions? SelectorClose)?;

selectorOptions: selectorOption (',' selectorOption)*;

selectorOption: rangeSelectorOption Is  range
              | unquotedSelectorOption Is Not? UnquotedString
              | quotedSelectorOption Is Not? (String | UnquotedString)
              | intSelectorOption Is Not? Integer
              | SORT Is sortSelectorOption
              | GAMEMODE Is Not? gamemodeSelectorOption
              | TYPE Is Not? (UnquotedString NS)? UnquotedString
              | SCORES Is scoresSelectorOption
              ;

selectorScore: UnquotedString Equals range;
scoresSelectorOption: CurlyOpen (selectorScore (ScoreSeperator selectorScore)*)? CurlyClose;


