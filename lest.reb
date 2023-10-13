Rebol[]

lest: context [

    output: make string! 10000

    tag-stack: make block! 500

    templates: make map! 50
    templ-tags: make block! 50

    class: make block! 10

    tag: content: id: value: mark:
        none

    ot: #"<"
    ct: #">"
    qt: #"^""

    verbose: on

    debug: func [value] [if verbose [print value]]

;-- emitters

    emit-tag: quote (
        repend output [
            ot tag
            either id [rejoin [ { id="} id qt ]] [""]
            either empty? class [""] [rejoin [ { class="} form class qt ]]
            ct
        ]
    )

    emit-close-tag: quote (
        repend output [ot slash tag ct]
    )

;-- stach handling

    push-tag: quote (
        append tag-stack tag
        debug ["tag-stack/PSH:" tag-stack]
    )

    pop-tag: quote (
        debug ["tag-stack/POP:" tag-stack]
        tag: take/last tag-stack
    )

;-- matching rules

    expand-template: [
        mark:
        change set tag templ-tags (
            select templates tag
        )
        :mark
    ]

    match-atts: [
        (
            id: none
            clear class
        )
        opt expand-template
        any [
            set value issue!
            (id: value)
        |   set value refinement!
            (append class value)
        ]
    ]

    match-string: [
        set content string!
        (append output content)
    ]

    match-content: [
        match-string
    |   ahead block! into [some match-cmds]
    ]

    match-cmds: [
        expand-template
    |   match-list
    ; -- matching tag must be at last position
    |   match-tag
    ]

    tags: ['div | 'span]

    match-tag: [
        ; TODO: either add list of foridden tags
        ;       or list of allowed tags
        set tag tags
        match-atts
        emit-tag
        push-tag
        match-content
        pop-tag
        emit-close-tag
    ]

    match-list: [
        'list (tag: 'ul)
        match-atts
        emit-tag
        push-tag
        into [any list-item]
        pop-tag
        emit-close-tag
    ]

    item-content: [
        [expand-template | match-string | match-tag]
        opt match-list
    ]

    list-item: [
        'item (tag: 'li)
        match-atts
        emit-tag
        push-tag
        any item-content
        pop-tag
        emit-close-tag
    ]

;-- defs

    define-template: [
        set tag set-word!
        set value block!
        (put templates tag value)
        (repend templ-tags ['| to lit-word! tag])
    ]

;-- main rule

    rules: [
        mark: (probe mark)
        define-template
    |   match-cmds
    ]

;-- main func

    generate: func [data] [
        clear output
        clear tag-stack
        clear templates
        clear templ-tags
        append templ-tags quote '-- ; NOTE: Fake rule to simplify rule adding

        parse data [some rules]

        copy output
    ]
]
