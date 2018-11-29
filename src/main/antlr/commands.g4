parser grammar commands;

import datatypes;

options{
    tokenVocab = generalLexer;
}

mcCommand: ADVANCEMENT advancementCMD EOL;

advancementCMD: (MCgrant | MCrevoke) player ( ADVonly resource GREEDY_STRING?
                                            | ADVuft  resource
                                            | ADVeverything
                                            );



player: selector | PlayerName;

resource: (NameSpace? NSSeperator)? (NameSpace|Path);