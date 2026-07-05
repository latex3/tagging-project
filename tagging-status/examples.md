---
title: "LaTeX tagged PDF Examples"
---

<script src="https://texlive.net/cm6-test/cm6.bundle.min.js"></script>

# Tagging Examples

<div style="margin:1em;padding:1em;border:solid thin black;" markdown=1>

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

The [tagging status page](../) lists many test files showing the the
tagging status of over a thousand LaTeX packages. A small sample are
highlighted here, mostly corresponding to current work items.

The examples are presented in an online editor to allow you to
experiment and change the examples. The resulting TeX files are _not_
stored and all generated PDF are deleted from the server after an
hour. The current public release of `lualatex-dev` from
[TeXLive](https://www.tug.org/texlive/) is used to process all
examples. Development code from the LaTeX git repositories is _not_
used here.

</div>

## hawkdraw

The [hawkdraw](https://ctan.org/pkg/hawkdraw) package is a newly contributed
package, not by the core LaTeX team, which is designed to produce
accessible vector drawings. The test demonstrates various ways in
which the drawing may be tagged using `alt` or `ActualText` to provide
accessible text, or using `artifact` to hide the paths from AT and
allow the text in the nodes of the diagram to be tagged individually.

```latex
{% include_relative testfiles-compatible/hawkdraw/hawkdraw-01.tex %}
```



## titlesec

The [titlesec](https://ctan.org/pkg/titlesec) package is currently
incompatible with the LaTeX tagging code, and this example
demonstrates that no PDF is generated and just the error log is shown.

It is included here as it is expected that an accessible version of
this package functionality will be developed soon as part of a wider
effort to implement LaTeX section headings via a new template
interface producing accessible PDF outputs.


```latex
{% include_relative testfiles-incompatible/titlesec/titlesec-01-BAD.tex %}
```

text here

## mitthesis

A contributed class, producing accessible PDF with LuaLaTeX.
Included here to test multi-file tests.


{%
assign mitfiles = "lmodern.ltx,committee_members.ltx,abstract.ltx,acknowledgments.ltx,chapter1.ltx,appendixb.ltx,biography.ltx,mitthesis-01.bbl" | split: "," 
%}

{% for f in mitfiles %}
{% assign ff = "testfiles-compatible-luatex/mitthesis/" | append: f %}

<pre class="norun" style="height:8em" markdown="1">

{% raw %}
{% include_relative  {{ff}} %}
{% endraw %}

</pre>

{% endfor %}


<div id="mitthesis"><pre></pre></div>

<script>
fetch('https://raw.githubusercontent.com/latex3/tagging-project/refs/heads/main/tagging-status/testfiles-compatible-luatex/mitthesis/mitthesis-01.tex').then(function (response) {
	return response.text();
}).then(function (t) {
document.getElementById("mitthesis").childNodes[0].innerText=t;
});
</script>


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
