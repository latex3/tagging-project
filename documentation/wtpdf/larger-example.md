---
layout: "ngpdf"
lang: "en"
---

<script>
function generatepreamble(t,e) {return e.getValue();}
runlatex.texts.metadata="";
//runlatex.editorlines=135;
runlatex.preincludes = {
 "pre0": {"pre2": "t6.tex"},
 "pre1": {"pre2": "t6.tex"}
 }
</script>

[Well Tagged PDF Video Examples](./)

# Generating Well-Tagged PDF from LaTeX

## A realistic demonstration file

This page allows you to create a demonstration PDF from a complex
two-column LaTeX document including a table of contents, mathematical
formulae and theorem, graphics, marginal notes, footnotes, a code
display, a bibliography, and generated cross references and citations.
To generate Tagged PDF on your own system you’ll need a recent LaTeX distribution.

To enable standards-conforming Tagged PDF output, simply add at the
very beginning of the document, i.e., before `\documentclass`, a
`\DocumentMetadata` declaration. It takes one argument, a key-value
list.

The first four keys in the document metadata declaration below set
necessary document metadata, including main  document language, PDF version and the
ISO-standardized subset(s) of PDF to which the document should comply with.
The final `testphase`key is temporarily needed while the tagging support is still under development.

## Structure elements or Associated Files

LaTeX leverages two distinct options for including MathML in PDF documents that include math formulae.

 * Each formula can be represented by an embedded and so-called Associated File (AF) that contains its MathML representation, and / or
 * Each formula’s MathML representation is directly embedded into the PDF’s tags tree as structure elements.

Both are valid methods (as defined in ISO 32000-2, PDF’s
specification), but many reader software applications do not yet fully
support these features in PDF 2.0. We hope that more PDF software
producers will soon enable access to MathML in PDF files.

At present, the LuaTeX engine can automatically produce MathML tags
from LaTeX source and can support either method. pdfTeX only supports
the Associated Files method, with the data for the AF files prepared
in a separate step.

## Demonstration

Simply click the “Generate Tagged PDF” button below the following example code, or edit the [example document](#example-doc) before generating a PDF.
Please keep your example relatively small to avoid overburdening the free service we’re providing here.
If you prefer a smaller demonstration file, [that’s available](small-example).


### Generate a PDF that represents MathML via structure elements

```latex
{% include_relative t6-se.tex %}
```

###  Generate a PDF that includes MathML in embedded and associated files

```latex
{% include_relative t6-af.tex %}
```


### Document Text (`t6.tex` as used above) {#example-doc}

You can edit the document in the box below and then use one of the compile buttons above to see the effects of your changes.

<pre class="norun" markdown="1">

{% include_relative t6.tex %}

</pre>



## About the output

Your demonstration PDF will, by default, be generated via a standard TeXLive 2025 `lualatex-dev`.

Two configurations are provided, they input the same document but differently configure
the way MathML is encoded. The first uses
MathML tags in the output PDF’s tag tree. In the second, LaTeX will instead
associate each math expression in the PDF with an embedded and
associated MathML file. One could edit this example to add `,math/tex/AF` to the `\tagpdf`
command, and then in addition a file containing the TeX source would be associated with each formula.

The “Generate tagged PDF” button runs (Lua)LaTeX at
[texlive.net](https://texlive.net) (see [texlive.net help](https://davidcarlisle.github.io/latexcgi/)). Once the
PDF is generated links are provided allowing you to view or download
the resulting PDF, or open it at ngpdf.com (see [ngPDF help](https://ngpdf.com/help)), where the
Tagged PDF may be viewed together with an HTML representation derived
from the PDF using the MathML associated with each math formula.

These examples run using the texlive.net and ngpdf.com services
provided by [DANTE](https://www.dante.de) and
[Duallab](https://duallab.com) respectively. Please do not over use
the services, they are not set up to process heavy loads but are
intended just to run small examples in order to show how to use LaTeX
to generate tagged PDF. The submitted TeX source is deleted after the
PDF is generated. The generated PDF is deleted after one hour.

To generate Tagged PDF on your own system you’ll need a recent LaTeX distribution.


## Full Document Videos

[fulldoc](fulldoc)
