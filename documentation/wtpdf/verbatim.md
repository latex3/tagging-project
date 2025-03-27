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

### Reading with symbol pronunciation set to "All"

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

* The Braile for the first line in the original source code (using default nvda Braille settings)
   
   ```
   main( ) {
   ⠍ ⠁ ⠊ ⠝ ⠐ ⠣   ⠐ ⠜   ⠸ ⠣
   ```
   
   Becomes the two lines
   
   <pre>
   new line  main open paren   close p
   &#x00A0; &#x281D; &#x2811; &#x283A; &#x00A0; &#x2807; &#x280A; &#x281D; &#x2811; &#x00A0; &#x00A0; &#x280D; &#x2801; &#x280A; &#x281D; &#x00A0; &#x2815; &#x280F; &#x2811; &#x281D; &#x00A0; &#x280F; &#x2801; &#x2817; &#x2811; &#x281D; &#x00A0; &#x00A0; &#x00A0; &#x2809; &#x2807; &#x2815; &#x280E; &#x2811; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0;
   
   paren   open brace  
   &#x280F; &#x2801; &#x2817; &#x2811; &#x281D; &#x00A0; &#x00A0; &#x00A0; &#x2815; &#x280F; &#x2811; &#x281D; &#x00A0; &#x2803; &#x2817; &#x2801; &#x2809; &#x2811; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0; &#x00A0;
   </pre>

{% include youtube.html id="UkIT2je-sj8" width="medium" comment="vebatim alt by character"%}


### Using MathML for each symbol

It is possible to use MathML, for example tag `{` as `<math><mo>{</mo></math>`
(This would not require any explicit tagging in the document, it could be added in the same
way as the current `/Alt tagging.

{% include youtube.html id="rUwvv6qWI7A" width="medium" comment="verbatim mo"%}

* Symbols read (using math settings)
* Verbosity and words used customisable by the reader.
* In verbose modes the entering and leaving of mathematics will be announced
* line breaks are not announced.


### Using a MathML table

An alternative way of using MathML would be to use an `mtable` with a
`:lines` intent so that it isn't announced as a matrix, but simply "3
lines; line 1 ..., line 2 ..."

Each line of the display is then encoded as, for example:

```
<mtr><mtd intent=":literal"><mtext> main</mtext><mo>(</mo><mtext> </mtext><mo>)</mo><mtext> </mtext><mo>{</mo></mtd></mtr>
```

{% include youtube.html id="lhBjP2ZqUIY" width="medium" comment="verbatim mtable"%}

* Each line is announced.
* Only one "spurious" math is announced in verbose modes.












