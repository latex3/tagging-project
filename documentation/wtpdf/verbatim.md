---
lang: en
layout: default
extrahead: youtube-head
---

[Well Tagged PDF Video Examples](./)

----

# Screen Reading Examples (DRAFT)


## Verbatim

Verbatim has similar requirements to mathematics, in that symbols
should ideally be read and not ignored or just read as pause, as is
used for natural language text.


### Default Reading

{% include youtube.html id="gnr8bZxxSGQ" width="medium" comment="verbatim some"%}

* Here all the symbols are not read at all.

### Reading with symbol pronunciation set to "All" {#symbols-all}

Screen readers have customisable settings for punctuation symbols,
With NVDA, `<nvda>p` cycles between `none`, `some` (the default), `many` and `all`.

With `all` the reading is

{% include youtube.html id="HEswkxdRJw8" width="medium" comment="verbatim all"%}

* Symbols read (using text settings)
* Verbosity and words used customisable by the reader.
* Linebreaks are not announced.
* Requires interaction by the user to enable/disable this. Note the
  end of sentence full stop (period) is announced `dot` with this
  setting. Reading the entire document with every comma and punctuation symbol announced is not usually desirable.

It would be good if screen readers had a setting to automatically
switch to this mode in `<pre>` (html) or `/Code` (pdf) contexts, but
they do not currently.


### Alt attribute

PDF has two main attributes to control the text used by AT, `/Alt` and `/ActualText`.
The latter would affect other uses, such as cut and paste, preventing the common
requirement to  copy code out of the document. The mechansim used in the
[Example document](larger-example) on this site is for LaTeX to annotate each symbol
with an `Alt` attribute, and to add an empty `/Span` with an `/Alt` to announce each new line.

{% include youtube.html id="imQzEHpdtT4" width="medium" comment="verbatim alt"%}

* Good Reading and cut and paste.
* Character names localised to the document language (not to that of the listener).
* Braille is severely impacted, the braille for the character names rather than the characters is generated.
* Navigating with a screen reader by character is similarly impacted.
* The Braille for the first line in the original source code (using default NVDA Braille settings)
   
   <pre>
   main( ) {
   &#x280D; &#x2801; &#x280A; &#x281D; &#x2810; &#x2823; &#x00A0; &#x2810; &#x281C; &#x00A0; &#x2838; &#x2823; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0;
   </pre>
   
   Becomes the two lines
   
   <pre>
   new line  main open paren   close p
   &#x00A0; &#x281D; &#x2811; &#x283A; &#x00A0; &#x2807; &#x280A; &#x281D; &#x2811; &#x00A0; &#x00A0; &#x280D; &#x2801; &#x280A; &#x281D; &#x00A0; &#x2815; &#x280F; &#x2811; &#x281D; &#x00A0; &#x280F; &#x2801; &#x2817; &#x2811; &#x281D; &#x00A0; &#x00A0; &#x00A0; &#x2809; &#x2807; &#x2815; &#x280E; &#x2811; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0;
   
   paren   open brace  
   &#x280F; &#x2801; &#x2817; &#x2811; &#x281D; &#x00A0; &#x00A0; &#x00A0; &#x2815; &#x280F; &#x2811; &#x281D; &#x00A0; &#x2803; &#x2817; &#x2801; &#x2809; &#x2811; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0;
   </pre>


### Default Reading by character

Screen readers allow navigation by various units including movement by
character, which is commonly used for code sections and other
technical material.

The navigation of just the first line of the verbatim example is shown here.

{% include youtube.html id="yv9rbMb6Urw" width="medium" comment="verbatim by character"%}



In comparison to the previous section navigation by character with the code using `/Alt.

### Reading the verbatim-alt code by character

* Here AT is only passed the Alt text and so for example the single
  character `{` is reported as the ten characters `open brace` and
  each requires a separate right arrow and is announced
  separately. The Braille is similar: each character is spelled out
  (which is more or less unusable in a one or two line Braille display.


{% include youtube.html id="UkIT2je-sj8" width="medium" comment="vebatim alt by character"%}


### Using MathML for each symbol

It is possible to use MathML, for example tag `{` as `<math><mo>{</mo></math>`
(This would not require any explicit tagging in the document, it could be added in the same
way as the current `/Alt tagging.

{% include youtube.html id="rUwvv6qWI7A" width="medium" comment="verbatim mo"%}

* This example is showing HTML display not PDF, to allow experiementation with the tagging. Equivalent PDF Tagging could be constructed.
* Symbols read (using math settings)
* Verbosity and words used customisable by the reader.
* In verbose modes the entering and leaving of mathematics will be announced
* line breaks are not announced.
* Braille is compact but using math (nemeth) not text style for symbols.

  <pre>
  main ( ) {
  &#x00A0; &#x280D; &#x2801; &#x280A; &#x281D; &#x00A0; &#x2837; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x283E; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x2828; &#x2837; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0;
  </pre>


### Using a MathML table

An alternative way of using MathML would be to use an `mtable` with a
`:lines` intent so that it isn't announced as a matrix, but simply "3
lines; line 1 ..., line 2 ..."

Each line of the display is then encoded as, for example:

```
<mtr><mtd intent=":literal"><mtext> main</mtext><mo>(</mo><mtext> </mtext><mo>)</mo><mtext> </mtext><mo>{</mo></mtd></mtr>
```

{% include youtube.html id="lhBjP2ZqUIY" width="medium" comment="verbatim mtable"%}

* This example is showing HTML display not PDF, to allow experiementation with the tagging. Equivalent PDF Tagging could be constructed.
* Each line is announced.
* Only one "spurious" math is announced in verbose modes.



## Inline Code (LaTeX `\verb`) {#inline}

The above examples all show an example of a displayed code block (LaTeX `verbatim` environment).
It is usually clear to a reader from the context that such a region is being added, and for example
as the symbol pronunciation setting could be toggled manually to get the reading shown [above](#symbols-all)
just for the code block.

In addition, the original code file could be offered as an Embedded Associated file and made available by
the PDF readers's "Attached Files" menu., allowing the user to extract the code and process it in a code editor
or other environemnt more directly suited to handling code in an accessible way.

Some experiences coders may reasonably argue that for such code blocks
it is not too important if the document based reading misses details,
as it is only used to skim over the code and all real use would be
achieved by moving the code to a code editor.
However, not all readers of documents that have such block use code editors, or are familiar enough
with the programming language that not announcing syntax characters would be acceptable.


In addition, documents often have many small inline code fragments such as
`\LaTeX` or `this_variable_name` or `class.method`. In most cases it
would not be appropriate to offer such fragments as files that may be
extracted, and the user may have far less contextual information to
tell then to switch reading style. In the absence of a mechanism to have the
reader automatically increase the verbosity of symbol pronunciation in such
code blocks, one of the methods discussed above to individually tag each symbol
would seem prefereable.