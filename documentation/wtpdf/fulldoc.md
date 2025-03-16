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

[Well Tagged PDF Video Examples T5](./)

----

# Full Document Sources

## LaTeX document with no tagging

```latex
{% include_relative t5.tex %}
```

###  Foxit/NVDA reading untagged PDF

{% include youtube.html id="PSpth4oyQdo" width="medium" comment="t5 foxit"%}

Observations

It is very difficult to find all issues if you are looking at the text in parallel, so close your eyes and try to understand what is told to you. Here is  a (possibly incomplete) list of issues:

 - Link announcements duplicate the link text, e.g., _"Link 1 Introduction 1 Introduction"_
 - TOC is read with a lot of  _"dot dot dot ..."_ and page number and next heading number without any pause
 - "link" announcement for footnote appears in a random place in the previous line and the footnote number is read as normal text
 - The footnote text is read as part of the column so appears in the middle of the paragraph text that is broken across the columns (here between the hyphenated word  _"docu-ment"_) 
 - The heading _"2 Document structures"_ is interpreted as a list with one item
 - Subheadings are read as _"Two One Mathematics"_ not as "2.1 Mathematics"
 - Reading of math is garbled as sub- and superscripts are announced and punctuations and other symbols are not read
 - Equation labels are read as numbers so difficult to understand
 - The second display math equation and the following text "Matrices" are interpreted as a single table and a list with one item producing an incomprehensible reading
 - The matrix equation is read backwards _"3 4 1 2"_ not as "1 2 3 4" and without any indication what the matrices are
 - The nested structure of the lists is not deducible
 - The reference back to item 2 in the sentence after the list makes the list entry come out as _"2 items within such a list may be refer items within such a list may be referenced"_
 - The link area is identified as being on the line before, therefore the word _"Link"_ is added before _"Here we reference item 2"_ (same problem as with the footnote mark, except that there the previous line has text)
 - The float with the Helvetica A is interpreted as a table and its caption is read as normal text
 - The heading "2.3 Figures and Tables" is read as _"LIST WITH ONE ITEM 2 3 figures and tables 3 figures an  d tables OUT OF LIST"_
 - The inline graphic is not announced
 - The small table and the following paragraph with a marginal confuses the reading software totally:
     - everything is announced as a table with 11 rows,
     - the reading order reads lines from the marginal and
     - the paragraph and several bits of text are repeated
 - It reads _"Theorem 1 Fermat ESS last"_
 - Instead of "such that \$a^n + b^n = c^n\$" it reads _"such then plus b-en equals c-en"_ (the _"then"_ is probably a Microsoft speech generator issue)
 - The display of verbatim code is read without the parentheses and curly brackets

### Acrobat/NVDA reading untagged PDF

{% include youtube.html id="OpIjDwJqFKc" width="medium" comment="t5 acrobat"%}

Observations

 - 
 - 
 - 



### Foxit reading GitHub display of markdown extracted by ChatGPT

{% include youtube.html id="hzVnFZqD9BE" width="medium" comment="t5 chatgpt foxit"%}

Observations

 - 
 - 
 - 



###  Foxit/NVDA reading PDF tagged by Acrobat Pro auto-tagging (MacOS version)

{% include youtube.html id="v46SNqqBNJ8" width="medium" comment="t5-autotagged MacOS foxit"%}

Observations

 - 
 - 
 - 



###  Foxit/NVDA reading PDF tagged by Acrobat Pro auto-tagging (Windows version)

{% include youtube.html id="7OeeU5Qmy1o" width="medium" comment="t4-autotagged UF foxit"%}

Observations

 - 
 - 
 - 



## Tagging, using associated files for math

```latex
{% include_relative t5-af.tex %}
```

Observations

 - 
 - 
 - 



### Foxit/NVDA reading PDF with MathML AF

{% include youtube.html id="kyZMO1N96tw" width="medium" comment="t5-af foxit"%}

## Tagging, using MathML structure elements
```latex
{% include_relative t5-se.tex %}
```

Observations

 - 
 - 
 - 



### Acrobat Reader/NVDA reading PDF with MathML SE

{% include youtube.html id="AwxQ0zYYKqw" width="medium" comment="t5-se acrobat"%}

Observations

 - 
 - 
 - 


