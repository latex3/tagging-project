---
lang: en
layout: "ngpdf"
extrahead: youtube-head
---

<script>
function generatepreamble(t,e) {return e.getValue();}
runlatex.texts.metadata="";
runlatex.preincludes = {
 "pre1": {"pre0": "t3.tex"},
 "pre2": {"pre0": "t3.tex"}
 }
</script>

[Well Tagged PDF Video Examples](./)

----

# Full Document Sources

## LaTeX document with no tagging

```latex
{% include_relative t3.tex %}
```

## Tagging, using associated files for math

```latex
{% include_relative t3-af.tex %}
```


## Tagging, using MathML structure elements
```latex
{% include_relative t3-se.tex %}
```
