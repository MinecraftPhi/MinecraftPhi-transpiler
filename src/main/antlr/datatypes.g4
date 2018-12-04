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

selectorOptions: selectorOption (SelectorSeperator selectorOption)*;

selectorOption: rangeSelectorOption Is  range
              | unquotedSelectorOption Is Not? UnquotedString
              | quotedSelectorOption Is Not? (String | UnquotedString)
              | intSelectorOption Is Not? Integer
              | SORT Is sortSelectorOption
              | GAMEMODE Is Not? gamemodeSelectorOption
              | TYPE Is Not? (UnquotedString NS)? UnquotedString
              | SCORES Is scoresSelectorOption
              | NBT Is Not? nbt
              ;

selectorScore: UnquotedString Equals range;
scoresSelectorOption: CurlyOpen (selectorScore (ScoreSeperator selectorScore)*)? CurlyClose;

nbt: NBTOpen (nbtKeyValue (NBT_Seperator nbtKeyValue)*)? NBTClose;
nbtKeyValue: NBT_UnquotedString NBT_DoublePoint nbtValue;

nbtValue: nbt | nbtArray | NBT_UnquotedString ;

nbtArray: NBT_ArrayOpen (nbtValue (NBT_Seperator nbtValue)*)? NBT_ArrayClose;
