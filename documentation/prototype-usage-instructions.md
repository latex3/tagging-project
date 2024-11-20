---
layout: "ngpdf"
lang: "en"
---


<script>
runlatex.preincludes = {
 "pre9": {
    "pre10": "document-mathml.html",
   }
}
runlatex.packageregex = [
    [ /\\includegraphics/,                    "\\usepackage{graphicx}\n"],
    [ /\\begin{equation|align|gather|flalign|\\DeclareMathOperator/,"\\usepackage{unicode-math}\n"       ],
    [ /tikz|pgf/,                             "\\usepackage{tikz}\n"          ],
    [ /fancy/,                                "\\usepackage{fancyhdr}\n"      ],
    [ /addplot|axis/,                         "\\usepackage{pgfplots}\n"      ],
    [ /hyper|href|bookmark|\\url/,            "\\usepackage{hyperref}\n"      ],
    [ /\\newcolumntype/,                      "\\usepackage{array}\n"         ],
    [ /listing/,                              "\\usepackage{listings}\n"      ],
    [ /\\blind/,                              "\\usepackage{blindtext}\n"     ],
    [ /\\lipsum/,                             "\\usepackage{lipsum}\n"        ],
    [ /color/,                                "\\usepackage{xcolor}\n"        ],
    [ /pspicture/,                            "\\usepackage{pstricks}\n"      ]
];

</script>



# Using the LaTeX prototype for accessible PDF (as of 2024/11)

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
\includegraphics[alt={Portrait of Shakespeare}]{william-shakespeare.jpg}
\includegraphics[width=2cm,artifact]{crinklepaper}\makebox[0pt][r]{Some text }
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

## Handling lists and other block structures

Something about lists having extended options similar to `enumitem`
but implemented by default in the new code.

```
\section{lists}

A list starting at 5

\begin{enumerate}[start=5] 
\item Level A1
  \begin{enumerate}
  \item Level B1
  \item Level B2
  \end{enumerate}
\item Level A2
\end{enumerate}

Some text outside the list, then resume the list:

\begin{enumerate}[resume=true]
\item Level A1
  \begin{enumerate}
  \item Level B1
  \item Level B2
  \end{enumerate}
\item Level A2
\end{enumerate}
```


## Extended math support

To improve the accessibility of math equations the code tries to embed
MathML representations of all equations. As described below, these
MathML representations may be created automatically if you are using
LuaLaTeX, but may also be provided by the author.

Technically there are two methods of associating MathML with each
formula:

 * As an _associated file_ This is an embedded stream of XML within
   the PDF that exactly matches the MathML that you would use in other
   contexts such as a web page.
 * Using MathML Namespace _Structure Element_ tagging. This is a
   feature of PDF 2.0 that extends the PDF tags, as used for sections
   and lists and other document structure, by a set of tags
   corresponding to the elements defined by MathML.

LuaLaTeX (via the `luamml` package which is loaded automatically when
needed) includes a basic TeX to MathML convertor so can generate both
these forms. If using other engines then only the Associated File
mechanism may be used.


### Supplying MathML to be used for Associated File tagging,


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


LaTeX will write out a an initial dummy version of this file
If you initially compile the document  with the following key setting

```none
\tagpdfsetup{math/mathml/write-dummy}
```
{: .norun :}

This initial version will have a `<div>` for each formula but with an
empth `<math>` element in each case.
The math should be filled with a suitable MathML representation and
the dummy file should then be renamed to `<file>-mathml.html`.

Even if using pdfLaTeX for the final document, you may prefer to use
LuaLaTeX for an intital run as LuaLaTeX will write out a version of
the file with MathML already generated. If needed this MathML may
still be edited and the file renamed to `<file>-mathml.html` .

### Associated MathML Files
```
\DocumentMetadata{uncompress,lang=en,
 testphase={phase-III,math,table,title},
 pdfversion=2.0,pdfstandard=ua-2,pdfstandard=a-4f}

\documentclass{article}
\usepackage{unicode-math}

\title{Math tagged with Associated Files (luamml)}
\author{LaTeX Team}
\begin{document}

\maketitle

\section{Basic mathematical expressions}

If $x$ is real, then $x^{2} \geq 0$.

A matrix equation.
\[
\begin{pmatrix}0&1\\1&0\end{pmatrix}
\begin{pmatrix}a&b\\c&d\end{pmatrix}
=
\begin{pmatrix}c&d\\a&b\end{pmatrix}
\]

\end{document}
```

### MathML Structure Element Tagging

```
\DocumentMetadata{uncompress,lang=en,
 testphase={phase-III,math,table,title},
 pdfversion=2.0,pdfstandard=ua-2,pdfstandard=a-4f}

\tagpdfsetup{
 math/mathml/structelem,
 math/tex/AF=false
 }

\documentclass{article}
\usepackage{unicode-math}

\title{Math tagged with MathML Structure Elements}
\author{LaTeX Team}
\begin{document}

\maketitle

\section{Basic mathematical expressions}

If $x$ is real, then $x^{2} \geq 0$.

A matrix equation.
\[
\begin{pmatrix}0&1\\1&0\end{pmatrix}
\begin{pmatrix}a&b\\c&d\end{pmatrix}
=
\begin{pmatrix}c&d\\a&b\end{pmatrix}
\]

\end{document}
```

### Associated MathML Files (pdflatex)

```
% !TeX pdflatex
\DocumentMetadata{uncompress,lang=en,
 testphase={phase-III,math,table,title},
 pdfversion=2.0,pdfstandard=ua-2,pdfstandard=a-4f}

\documentclass{article}
\usepackage{amsmath}

\title{Math tagged with Associated Files (PdfTeX)}
\author{LaTeX Team}
\begin{document}

\maketitle

\section{Basic mathematical expressions}

If $x$ is real, then $x^{2} \geq 0$.

A matrix equation.
\[
\begin{pmatrix}0&1\\1&0\end{pmatrix}
\begin{pmatrix}a&b\\c&d\end{pmatrix}
=
\begin{pmatrix}c&d\\a&b\end{pmatrix}
\]

\end{document}
```

Here we supply an additional file with MathML versions of each formula.  
[pdfexample-mathml.html](pdfexample-mathml.html)  
_View Source_ to see the MathML markup used.


```none
<!DOCTYPE html>
<html>

 <div>
  <h2>\mml 1</h2>
  <p>$x$</p>
  <p>332CC365A4987AACCE0EAD01B8BDCC0B</p>
  <math>
   <mi>x</mi>
  </math>
 </div>

 <div>
  <h2>\mml 2</h2>
  <p>$x^{2} \geq 0$</p>
  <p>1D298051244A67121717C47AA4459658</p>
  <math>
   <msup><mi>x</mi><mn>2</mn></msup>
   <mo>≥</mo>
   <mn>0</mn>
  </math>
 </div>

 <div>
  <h2>\mml 3</h2>
  <p>\begin {equation*}\begin {pmatrix}0&amp;1\\1&amp;0\end {pmatrix} \begin {pmatrix}a&amp;b\\c&amp;d\end {pmatrix} = \begin {pmatrix}c&amp;d\\a&amp;b\end {pmatrix}\end {equation*}</p>
  <p>D42165DF2B9CFE792932E789E4E0F7BD</p>
  <math display="block">
   <mrow>
    <mo>(</mo>
    <mtable>
     <mtr><mtd><mn>0</mn></mtd><mtd><mn>1</mn></mtd></mtr>
     <mtr><mtd><mn>1</mn></mtd><mtd><mn>0</mn></mtd></mtr>
    </mtable>
    <mo>)</mo>
   </mrow>
   <mo>&#x2062;</mo>
   <mrow>
    <mo>(</mo>
    <mtable>
     <mtr><mtd><mi>a</mi></mtd><mtd><mi>b</mi></mtd></mtr>
     <mtr><mtd><mi>c</mi></mtd><mtd><mi>d</mi></mtd></mtr>
    </mtable>
    <mo>)</mo>
   </mrow>
   <mo>=</mo>
   <mrow>
    <mo>(</mo>
    <mtable>
     <mtr><mtd><mi>c</mi></mtd><mtd><mi>d</mi></mtd></mtr>
     <mtr><mtd><mi>a</mi></mtd><mtd><mi>b</mi></mtd></mtr>
    </mtable>
    <mo>)</mo>
   </mrow>
  </math>
 </div>

</html>
```
{: .norun :}
{: .hide :}