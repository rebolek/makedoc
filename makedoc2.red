Red [
    Title: "MakeDoc 2 - The REBOL Standard Document Formatter"
    Version: 2.5.7
    Copyright: "REBOL Technologies 1999-2005"
    Author: "Carl Sassenrath"
    File: %makedoc2.r
    Date: 10-Mar-2007 ;10-Jan-2005
    Purpose: {
        This is the official MakeDoc document formatter that is used by
        REBOL Technologies for all documentation. It is the fastest and
        easiest way to create good looking documentation using any text
        editor (even ones that do not auto-wrap text). It creates titles,
        headings, contents, bullets, numbered lists, indented examples,
        note blocks, and more. For documentation, notes, and other info
        visit http://www.rebol.net/docs/makedoc.html
    }
    Usage: {
        Create a text document in any editor. Separate each paragraph
        with a blank line. Run this script and provide your text file.
        The output file will be the same name with .html following it.
        If you use REBOL/View the output file will be displayed in
        your web browser as well.

        You can also call this script from other scripts (e.g. CGI).
        These are supported:

            do %makedoc2.r

            do/args %makedoc2.r %document.txt

            do/args %makedoc2.r 'load-only
            doc: scan-doc read %file.txt
            set [title out] gen-html/options doc [(options)]
            write %out.html out
    }
    Library: [
        level: 'intermediate
        platform: 'all
        type: [tool]
        domain: [html cgi markup]
        tested-under: none
        support: none
        license: 'BSD
        see-also: none
    ]
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
        any [
            thru newline
            remove indent
            to newline
        ]
        remove indent
        to end
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
