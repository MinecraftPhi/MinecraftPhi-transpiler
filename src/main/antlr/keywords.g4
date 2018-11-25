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
    | 'type' | shortEntityTypes
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

rangeSelectorOption : 'distance' | 'level' | 'x_rotation' | 'y_rotation';

unquotedSelectorOption : 'tag' | 'team';

quotedSelectorOption : 'name';

intSelectorOption : 'x' | 'y' | 'z' | 'dx' | 'dy' | 'dz' | 'limit';

sortSelectorOption : 'nearest' | 'furthest' | 'random' | 'arbitrary';

gamemodeSelectorOption : 'survival' | 'creative' | 'adventure' | 'spectator';

entityTypes : ('minecraft' ':')? shortEntityTypes;

shortEntityTypes :
              'blaze'
            | 'cave_spider'
            | 'creeper'
            | 'drowned'
            | 'elder_guardian'
            | 'ender_dragon'
            | 'enderman'
            | 'endermite'
            | 'evoker'
            | 'ghast'
            | 'giant'
            | 'guardian'
            | 'husk'
            | 'illusioner'
            | 'magma_cube'
            | 'phantom'
            | 'pufferfish'
            | 'shulker'
            | 'silverfish'
            | 'skeleton'
            | 'slime'
            | 'spider'
            | 'stray'
            | 'vex'
            | 'vindicator'
            | 'witch'
            | 'wither'
            | 'wither_skeleton'
            | 'zombie'
            | 'zombie_pigman'
            | 'zombie_villager'
            | 'bat'
            | 'chicken'
            | 'cod'
            | 'cow'
            | 'dolphin'
            | 'donkey'
            | 'horse'
            | 'iron_golem'
            | 'llama'
            | 'mooshroom'
            | 'mule'
            | 'ocelot'
            | 'parrot'
            | 'pig'
            | 'polar_bear'
            | 'rabbit'
            | 'salmon'
            | 'sheep'
            | 'skeleton_horse'
            | 'snow_golem'
            | 'squid'
            | 'tropical_fish'
            | 'turtle'
            | 'villager'
            | 'wolf'
            | 'zombie_horse'
            | 'area_effect_cloud'
            | 'leash_knot'
            | 'painting'
            | 'item_frame'
            | 'armor_stand'
            | 'evoker_fangs'
            | 'end_crystal'
            | 'egg'
            | 'arrow'
            | 'spectral_arrow'
            | 'trident'
            | 'snowball'
            | 'fireball'
            | 'small_fireball'
            | 'ender_pearl'
            | 'eye_of_ender'
            | 'potion'
            | 'experience_bottle'
            | 'wither_skull'
            | 'firework_rocket'
            | 'shulker_bullet'
            | 'dragon_fireball'
            | 'llama_spit'
            | 'command_block_minecart'
            | 'boat'
            | 'minecart'
            | 'chest_minecart'
            | 'furnace_minecart'
            | 'tnt_minecart'
            | 'hopper_minecart'
            | 'spawner_minecart'
            | 'tnt'
            | 'falling_block'
            | 'item'
            | 'experience_orb';