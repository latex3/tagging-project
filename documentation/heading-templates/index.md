---
title: "Tagging of Heading Structures in LaTeX"
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

runlatex.editorlines=45;

</script>

# Tagging Heading Structures

<div style="float:right; width: 8em; padding:1em;border:solid thin black; background-color:#EFEFEF" markdown=1>

  [Generic headings](#generic-heading-template-implementation)

  [Packages](#package-reimplementationsadjustments)

  [KOMA](#koma-script-classes)

  [Memoir](#memoir)

</div>

<div style="margin:1em;padding:1em;border:solid thin black;" markdown=1>

Current work on the LaTeX Tagging project is centered around providing
a framework for declaring accessible section heading structures via
_LaTeX Templates_. This will form the basis for providing updates
to existing document classes, either directly or via emulations of
existing packages such as titlesec.

This page allows selected LaTeX tagging examples to be processed with
LaTeX to produce PDF which may then be viewed or validated to
the [PDF/UA-2](https://pdfa.org/iso-14289-2-pdfua-2/)
accessibility standard.

Validation is provided by the open source
[veraPDF](https://verapdf.org/) validator hosted at
[texlive.net](https://texlive.net) and by the LaTeX project
[show-pdf-tags](https://texlive.net/showtags) validation hosted on the
same server.  As a convenience, a link is provided to open the
generated PDF at [ngPDF](https://ngpdf.com). ngPDF is provided free of
charge by its authors, although is not open source, it is not a
necessary component of the validation services shown on this page.

The [tagging status page](https://latex3.github.io/tagging-project/tagging-status) lists many test files showing the
tagging status of over a thousand LaTeX packages. A small sample are
highlighted here, corresponding to current work items.

The examples are presented in an online editor to allow you to
experiment and change the examples. The resulting TeX files are _not_
stored and all generated PDF are deleted from the server after an
hour. The current public release of `lualatex-dev` from
[TeXLive](https://www.tug.org/texlive/) is used to process all
examples. Development code from the LaTeX git repositories is _not_
used here.

---

We are grateful that a part of this project
is funded through [NGI0 Commons Fund](https://nlnet.nl/commonsfund), a fund established by [NLnet](https://nlnet.nl) with financial support from the European Commission's [Next Generation Internet](https://ngi.eu) program. Learn more at the [NLnet project page](https://nlnet.nl/project/LaTeX-Ecosystem-A11y).

[<img src="https://nlnet.nl/logo/banner.png" alt="NLnet foundation logo" width="20%" />](https://nlnet.nl)
[<img src="https://nlnet.nl/image/logos/NGI0_tag.svg" alt="NGI Zero Logo" width="20%" />](https://nlnet.nl/commonsfund)

</div>


## Generic Heading Template Implementation

The standard `article` class will already use the heading templates as shown in the example below.
This is included here to demonstrate this test infrastructure, before the emulation of the
heading packages has been undertaken.

```latex
{% include_relative article-01.tex %}
```

### Implement generic order key handling

In layouts for headings, captions, etc. the placement of individual
data items (such as fixed strings like "Chapter", a generated number,
the title, an optional sub-title, some punctuation, etc.) needs a
flexible solution in templates. This avoids the need for different
templates just because the order of title and number got swapped or
because of similar minor differences.

To allow for such variations within a single template, the concept of
"order" keys has been developed. The template support code was
augmented to offer a `\template_process_order_clist:nnn` command that
takes an order key defined by the template and processes its comma
list to typeset the items (and generate approriate tagging for them).
You may find the documentation in [latex-lab on
CTAN](https://ctan.org/tex-archive/macros/latex-dev/required/latex-lab)
or on your LaTeX installation with `texdoc latex-lab-template`.

> At the moment only the .dtx file was added to the last dev release
> but not the .pdf documentation. That will happen with the next
> update.

The test file below defines a small template (that is not doing much)
but lets you experiment with the mechanism and its results.


```latex
{% include_relative order-key-01.tex %}
```




## Package Reimplementations/adjustments



### titlesec

The [titlesec](https://ctan.org/pkg/titlesec) package is currently
incompatible with the LaTeX tagging code, and this example
demonstrates that no PDF is generated and just the error log is shown.

It is included here as it is expected that an accessible version of
this package functionality will be developed soon as part of a wider
effort to implement LaTeX section headings via a new template
interface producing accessible PDF outputs.


```latex
{% include_relative titlesec-01.tex %}
```



### fncychap

### quotechap


### tocloft


## KOMA-Script Classes


## memoir      

