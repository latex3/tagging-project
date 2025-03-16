---
lang: en
layout: "ngpdf"
extrahead: youtube-head
---

<script>
function generatepreamble(t,e) {return e.getValue();}
runlatex.texts.metadata="";
runlatex.preincludes = {
 "pre1": {"pre0": "t5.tex"},
 "pre2": {"pre0": "t5.tex"}
 }
</script>

[Well Tagged PDF Video Examples](./)

----

# Full Document Sources

## LaTeX document with no tagging

```latex
{% include_relative t5.tex %}
```

###  Foxit/NVDA reading untagged PDF

{% include youtube.html id="PSpth4oyQdo" width="medium" comment="t5 foxit"%}

### Acrobat/NVDA reading untagged PDF

{% include youtube.html id="OpIjDwJqFKc" width="medium" comment="t5 acrobat"%}


### Foxit reading GitHub display of markdown extracted by ChatGPT

{% include youtube.html id="hzVnFZqD9BE" width="medium" comment="t5 chatgpt foxit"%}

###  Foxit/NVDA reading PDF tagged by Acrobat Pro auto-tagging (FMi)

{% include youtube.html id="b4u0OIRuJ0I" width="medium" comment="t4-autotagged FMi foxit"%}

###  Foxit/NVDA reading PDF tagged by Acrobat Pro auto-tagging (UF)

{% include youtube.html id="7OeeU5Qmy1o" width="medium" comment="t4-autotagged UF foxit"%}

## Tagging, using associated files for math

```latex
{% include_relative t5-af.tex %}
```

### Foxit/NVDA reading PDF with MathML AF

{% include youtube.html id="uCwsCv-2hps" width="medium" comment="t4-af foxit"%}

## Tagging, using MathML structure elements
```latex
{% include_relative t5-se.tex %}
```

### Acrobat Reader/NVDA reading PDF with MathML SE

{% include youtube.html id="bgCp7Mk3fOE" width="medium" comment="t4-se acrobat"%}