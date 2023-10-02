Red [
    Title: "MakeDoc Red wrapper"
    Version: 0.1.0
    Copyright: "Boleslav Březovský 2023"
    Author: "Boleslav Březovský"
    File: %makedoc2.red
    Date: 02-10-2023
    Purpose: {
        This is wrapper over Rebol version of MakeDoc2 script.
        It's a compatibility layer to make that version work in Red
        so there's no need to have two codebases.
    }
    License: 'BSD
]

found?: func [value] [not not value]
join: func [value rest] [append either series? :value [copy value] [form :value] reduce :rest]
reform: func [value] [form reduce :value]
detab: func [
    string
    /size number
] [
    number: any [number 4]
    size: append/dup make string! number #" " number
    parse string [
        some [
            change tab size
        |   skip
        ]
    ]
    string
]
trim-auto: func [series /local indent mark] [
    parse series [
        mark: copy indent any space :mark
        remove indent thru newline
        any [
            thru newline
            remove indent
            to newline
        ]
        opt [
            remove indent
            to end
        ]
    ]
    series
]
forskip: func ['word size body] [
    while [not tail? get word] [
        do body
        set word skip get word size
    ]
]
read-string: func [file] [read file]
parse-all: func [input rules] [parse input rules]

confirm: func [ ; NOTE: Taken from R3
    "Confirms a user choice."
    question [series!] "Prompt to user"
    /with choices [string! block!]
    /local response
][
    if all [block? choices 2 < length? choices] [
        cause-error 'script 'invalid-arg mold choices
    ]
    response: ask question
    unless with [choices: [["y" "yes"] ["n" "no"]]]
    case [
        empty? choices [true]
        string? choices [if find/match response choices [true]]
        2 > length? choices [if find/match response first choices [true]]
        find first choices response [true]
        find second choices response [false]
    ]
]


if empty? system/script/args [system/script/args: none]

do load %makedoc2.reb
