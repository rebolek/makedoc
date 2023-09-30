MakeDoc Example

    Boilerplate goes here.
    Follows directly after title.

===Heading 1

This is a paragraph. You can have any text here.

This is the next paragraph. Notice that everything is separated
by a blank line. That's the main thing you need to remember.

If you want bold words use the <b>bold markers</b> like that.
You can also use <i>italic</i> and <u>underline</u>.

---Heading 1.1

+++Heading 1.1.1

...Heading 1.1.1.1 (with space check)

---Heading 1.2

===Code Sections

Code follows:

    Code example

    Can be more than one line.

    Always indented and marked.

        And indentation is preserved.

Code output:

==  Code output

Both:

    Code
==  Output

===Bullets

*Bullet 1

*Bullet 2 - Has sub-bullets

*>Bullet 2.1

*>Bullet 2.2

*>>Bullet 2.2.1

*Bullet 3 - Has enums

#Enum 1 in bullet

#Enum 2 in bullet

#>Enum 2.1 in bullet

#>Enum 2.2 in bullet

*Bullet 4

===Enums

#Enum 1

#Enum 2

#>Enum 2.1

#>Enum 2.2

#>>Enum 2.2.1

#Enum 3

*Bullet 1 in enum

*Bullet 2 in enum

*>Bullet 2.1 in enum

*>Bullet 2.2 in enum

#Enum 4


===Definitions

:word1 - word 1 defined

:word2 - word 2 defined

:word3 - word 3 defined

===Hidden Comments

There should not be another text line below this one.

;this line should be hidden, you should not see it.

===Image

=image graphics/reb-logo.gif

===Special

\note This is a note

Note here

/note

This next line is indented:

\in

Indented line

/in

\center

This is centered text.

/center

===Table

\table

Column 1

Column 2

Column 3

=row

Row 1, col 1

Row 1, col 2

Row 1, col 3

=row

Row 2, col 1

Row 2, col 2

Row 2, col 3

/table


\center

Centered Table

\table

Column 1

Column 2

=row

Paragraphs in table

\group

<b>This is the first paragraph.</b>

This is the second.

Here is the third.

/group

=row

Bullets in table

\group

*Bullet 1

*Bullet 2

*Bullet 3

/group

=row

Code in table

\group

    Line of code

    Another line of code

/group

/table

/center

===Document End Marker

Everything that follows this marker is hidden.
Good for keeping notes, change logs, etc.

###

Hidden text and notes can follow the ### end marker.

###

REBOL []
md: load %makedoc2.r
system/script/args: join system/options/path system/options/script
browse do/args md system/script/args
halt


