---
layout: "ngpdf"
lang: "en"
---


# Generating Well Tagged PDF from LaTeX

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

----


<details>
<summary><h3 style="display:inline">Notes on the Example Server</h3></summary>
<p></p>

<p>Each of the examples is shown in an online editor embedded in the
page.</p>

<p>The <button>Generate tagged PDF</button> will run (Lua)LaTeX
at texlive.net. Links will be generated to directly view the PDF or
to open the PDF at ngpdf.com which will allow the tagged structure to be
navigated and the derived HTML to be viewed.</p>

<p><a href="https://davidcarlisle.github.io/latexcgi/">texlive.net help</a></p>

<p><a href="https://ngpdf.com/help">ngPDF help</a></p>

<p>These examples run using the texlive.net and ngpdf.com services
provided by DANTE and Duallab respectively.
Please do not over use the services, they aren't set up to process heavy loads
but are intended just to run small examples in order to show how to use it on your local machine.</p>

</details>