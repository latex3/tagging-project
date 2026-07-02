---
---


{% assign examples = site.static_files | where_exp:"item","item.path contains '/examples/'" | where_exp:"item","item.path contains '.tex'" %}

<script src="https://texlive.net/cm6-test/cm6.bundle.min.js"></script>
<script src="https://texlive.net/runlatex2-cm6.js"></script>
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

# Tagging Examples

## hawkdraw

```latex
{% include_relative testfiles-compatible/hawkdraw/hawkdraw-01.tex %}
```



## titlesec

```latex
{% include_relative testfiles-incompatible/titlesec/titlesec-01-BAD.tex %}
```






