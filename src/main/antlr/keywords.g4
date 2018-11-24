grammar keywords;

keyword:
    //ensconcer specific
     'let' | 'var' | 'list' | simple_cttype | scorelike_type | 'return' | 'break'

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

scorelike_type :  'byte'
          | 'short'
          | 'int'
          | 'bool'
          | 'score'
          ;

simple_rttype : 'long'
              | 'float'
              | 'double'
              | 'compound'
              | 'string'
              ;

rangeSelectorOption : 'x' | 'y' | 'z' | 'distance' | 'dx' | 'dy' | 'dz';

unquotedSelectorOption : 'tag' | 'team';

quotedSelectorOption : 'name';

intSelectorOption : 'limit';

sortSelectorOption : 'nearest' | 'furthest' | 'random' | 'arbitrary';

gamemodeSelectorOption : 'survival' | 'creative' | 'adventure' | 'spectator';