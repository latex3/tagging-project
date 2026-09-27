---
title: "Tagging Examples"
---

<script src="https://texlive.net/cm6-test/cm6.bundle.min.js"></script>
<script src="https://texlive.net/runlatex3-cm6.js"></script>
<script>
function generatepreamble(t,e) {return e.getValue();}
      runlatex.overleafURI=null;
      
      runlatex.texts ={
	  "Open in Overleaf": "",
	  "TeXLive.net":      "Generate Tagged PDF", 
	  "Delete Output":    "Delete Output",
	  "Compiling PDF":    "Compiling Tagged PDF",
          "Added Code":       "",
	  "End Added Code":   "",
	  "Top Caption":      "",
	  "metadata":         ""
      }

runlatex.editorlines=20;

</script>

# Tagging Examples

<div style="float:right; width: 15em; padding:1em;border:solid thin black; background-color:#EFEFEF" markdown=1>

  [Generic example](#1-generic-example)

  [Configuration of headings](#2-configuration-of-headings)

  [Tagging of graphics](#3-tagging-of-graphics)

  [Tagging of tables](#4-tagging-of-tables)

  [Tagging of math](#5-tagging-of-math)

  [Checking the package status](#6-checking-the-package-status)

  [Parent-child warnings](#7-parent-child-warnings-from-faulty-nesting-of-structures)

  [Unbalanced para structures](#8-errors-from-unbalanced-para-structures)

  [Still open structures](#9-warnings-about-still-open-structures)


</div>

<div style="margin:1em;padding:1em;border:solid thin black;" markdown=1>


This page allows selected LaTeX tagging examples to be processed with
LaTeX to produce PDF which may then be viewed or validated to
the [PDF/UA-2](https://pdfa.org/iso-14289-2-pdfua-2/)
accessibility standard.

Validation is provided by the open source
[veraPDF](https://verapdf.org/) validator hosted at
[texlive.net](https://texlive.net) and by the LaTeX project
[show-pdf-tags](https://texlive.net/showtags) validation hosted on the
same server.  A link is provided to open the
generated PDF at [ngPDF](https://ngpdf.com). ngPDF is provided free of
charge by its authors.


The examples are presented in an online editor to allow you to
experiment and change the examples. The resulting TeX files are _not_
stored and all generated PDF are deleted from the server after an
hour. The current public release of `lualatex-dev` from
[TeXLive](https://www.tug.org/texlive/) is used to process all
examples. 

</div>


## 1. Generic example

* lualatex as compiler is recommended
* if there is math, `unicode-math` or `lua-unicode-math` should be used

```latex
{% include_relative tutorial-example-prototype.tex %}
```

## 2. Configuration of headings

* headings have an extend optional argument
* they can be configured by editing an instance 

```latex
{% include_relative tutorial-example-section.tex %}
```

## 3. Tagging of graphics
Graphics can be 
* images with an alternative text
* images representing text given as actual text
* artifacts
* decorated text (todo notes)

```latex
{% include_relative tutorial-example-graphic.tex %}
```

## 4. Tagging of tables

* headers must be marked
* multi rows must be marked 
* the package multirow is not yet compatible

```latex
{% include_relative tutorial-example-table.tex %}
```


## 5. Tagging of math

```latex
{% include_relative tutorial-example-math.tex %}
```

## 6. Checking the package status

```latex
{% include_relative tutorial-tagging-status.tex %}
```

## 7. Parent-child warnings from faulty nesting of structures

The nesting of structures has to comply to parent-child rules declared in
ISO/TS 32005. The code warns if it detects a faulty nesting.

```latex
{% include_relative tutorial-warnings-parent-child.tex %}
```


## 8. Errors from unbalanced para structures

Paragraphs are automatically tagged, but not every `\par` should lead
to a structure so the code suppresses the tagging in a number of places. 
The code errors if this leads to an inconsistent number of begins and ends of
paragraph structures. 
 
```latex
{% include_relative tutorial-error-para.tex %}
```

## 9. Warnings about still open structures


```latex
{% include_relative tutorial-warning-open-structure.tex %}
```
