---
layout: "ngpdf"
lang: "en"
---
# Using the LaTeX prototype for accessible PDF (as of 2024/06)

The new code can be used with pdfLaTeX or the Unicode engine
luaLaTeX. The latter is the preferred engine recommended for new
documents.

The interface descriptions below are all temporary and will be replaced
with proper interfaces over time. E.g., the `\DocumentMetadata` will remain, but
the key `testphase` and its value will eventually vanish.

## Basic setup

To enable tagging in supported documents it is enough to add at the
very beginning of the document, i.e., before `\documentclass`, a
`\DocumentMetadata` declaration. It takes one argument, a key-value
list:
```latex
\DocumentMetadata{
  lang        = de,
  pdfversion  = 2.0,
  pdfstandard = ua-2,
  pdfstandard = a-4f, %or a-4
  testphase   = 
   {phase-III,
    title,
    table,
    math,
    firstaid}  
}
\documentclass{article}
\begin{document}
\section{Start}
abc
\end{document}
```
The first four keys in the example set important document metadata,
like the language, the requested PDF version and the standards the
document should comply with.

Tagging is then enabled by loading various modules through the
`testphase` key.

- The `phase-III` module activates tagging and loads support for most
  standard document elements like paragraphs, lists, sectioning, table
  of contents, graphics, floats, links and more. You should always use
  this key first.
- The `title` module redefines the `\title`, `\author`
  and `\maketitle` command to make them tagging aware. It also takes
  care that the title and author are added to the XMP metadata.

- The `table` module adds tagging support to tables like `tabular`,
  `tabularx`, `tabulary` and `longtable`. 
-  The `math` module enables basic tagging of equations.
- Finally, the `firstaid` contains small fixes of
  external packages to make them compatible with the tagging code, e.g.,
  it fixes clashes with the `cleveref` and the `booktabs`
  packages.


## Handling graphics in the document

While most tagging is done automatically by adding the
`\DocumentMetadata` command, there remain a few things the author
has to add manually. At first every graphic must be marked either as
artifact or get an alternative text describing its meaning in the
context of the document. This can be done with additional keys that
have been added to the `\includegraphics` command:

```latex
\includegraphics[alt={this shows a yellow duck}]{duckimage}
\includegraphics[artifact]{dekoration}
```

## Handling tables (`tabular`) in the document

If the document contains data tables, the author has to identify the
header rows of the tables so that they can be tagged as `<TH>`
cells. By default all cells are considered data cells. This can be done
```latex
\tagpdfsetup{table/header-rows={1,2}}
\begin{tabular}{lr}
\multicolumn{2}{c}{Example}\\
Name&Value\\
This& 11 \\
That & 2
\end{tabular}
```
generally (in the preamble) or on a table by table basis before the table.

If a table should not be tagged as table, for example, because it is
merely used to ensure that the content is properly aligned, it should
be turned into a presentation table with
```latex
\tagpdfsetup{table/tagging=presentation}
\begin{tabular}{ccc}
\textbullet & \textbullet & \textbullet \\
--- & --- & ---
\end{tabular}
```

## Extended math support

To improve the accessibility of math equations the code tries to embed
MathML representations of all equations. These MathML representations
are currently not created automatically but must be provided by the
author.

For this the document should be compiled once with the command
```latex
\tagpdfsetup{math/mathml/write-dummy}
```
{: .norun :}

This will write a file `<file>-mathml-dummy.html` which has a
prepared section for every equation found in the document. The section
shows the LaTeX-source and a hash value and an empty
`<math></math>` tag.
```HTML
<div>
<h2>\mml 1</h2>
<p>$x=1$</p>
<p>8FD5BB0EEAA8887F6A312C99359A3B93</p>
<math></math>
</div>
```
{: .noedit :}

The math should be filled with a suitable MathML representation and
the dummy file should then be renamed to `<file>-mathml.html`.

