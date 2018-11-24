grammar keywords;

keyword:
    //ensconcer specific
     'let' | 'var'
    | 'byte' | 'short' | 'int' | 'long' | 'float' | 'double' | 'compound' | 'list' | 'bool' | 'score' | 'string'
    | 'token' | 'path' | 'command' | 'function' | 'selector' | 'intrange' | 'doublerange' | 'list'

    //selector
    | 'x' | 'y' | 'z' | 'distance' | 'dx' | 'dy' | 'dz'
    | 'tag' | 'team'
    | 'limit'
    ;