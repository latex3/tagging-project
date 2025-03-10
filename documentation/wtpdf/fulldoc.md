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

###  Foxit/NVDA reading untagged PDF

{% include youtube.html id="Nh4cIEgHe0U" width="medium" comment="t3 foxit"%}

###  Foxit/NVDA reading PDF tagged by Acrobat Pro auto-tagging

{% include youtube.html id="FXjLUTR6XxA" width="medium" comment="t3-autotagged foxit"%}

## Tagging, using associated files for math

```latex
{% include_relative t3-af.tex %}
```

### Foxit/NVDA reading PDF with MathML AF

{% include youtube.html id="ZH-q4uF9xYw" width="medium" comment="t3-af foxit"%}

## Tagging, using MathML structure elements
```latex
{% include_relative t3-se.tex %}
```

### Acrobat Reader/NVDA reading PDF with MathML SE

{% include youtube.html id="sF-4Y5ISePE" width="medium" comment="t3-se acrobat"%}