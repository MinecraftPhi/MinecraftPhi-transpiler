grammar keywords;

keyword:
    //ensconcer specific
     'let' | 'var' | 'list' | simple_cttype | 'return' | 'break'

    //selector
    | rangeSelectorOption
    | unquotedSelectorOption
    | quotedSelectorOption
    | intSelectorOption
    | 'sort' | sortSelectorOption
    | 'gamemode' | gamemodeSelectorOption
    ;

simple_cttype : 'token'
              | 'path'
              | 'command'
              | 'function'
              | 'selector'
              | 'intrange'
              | 'doublerange'
              | simple_rttype
              ;

simple_rttype : 'byte'
              | 'short'
              | 'int'
              | 'long'
              | 'float'
              | 'double'
              | 'compound'
              | 'bool'
              | 'score'
              | 'string'
              ;

rangeSelectorOption : 'x' | 'y' | 'z' | 'distance' | 'dx' | 'dy' | 'dz';

unquotedSelectorOption : 'tag' | 'team';

quotedSelectorOption : 'name';

intSelectorOption : 'limit';

sortSelectorOption : 'nearest' | 'furthest' | 'random' | 'arbitrary';

gamemodeSelectorOption : 'survival' | 'creative' | 'adventure' | 'spectator';