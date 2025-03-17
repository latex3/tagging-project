---
lang: en
layout: "ngpdf"
extrahead: youtube-head
---

<script>
function generatepreamble(t,e) {return e.getValue();}
runlatex.texts.metadata="";
runlatex.texts["TeXLive.net"]="Generate PDF";
runlatex.texts["Compiling PDF"]="Compiling PDF";
runlatex.preincludes = {
 "pre1": {"pre0": "t5.tex"},
 "pre2": {"pre0": "t5.tex"}
 }
</script>

[Well Tagged PDF Video Examples](./)

----

# Full Document Sources

## LaTeX document with no tagging

This is the source of the document whose output is used in the sample videos below.

```latex
{% include_relative t5.tex %}
```

###  Foxit/NVDA reading untagged PDF

{% include youtube.html id="PSpth4oyQdo" width="medium" comment="t5 foxit"%}

#### Observations

It is very difficult to find all issues if you are looking at the text in parallel, so close your eyes and try to understand what is told to you. Here is  a (possibly incomplete) list of issues:

 - Link announcements duplicate the link text, e.g., _"Link 1 Introduction 1 Introduction"_
 - TOC is read with a lot of  _"dot dot dot ..."_ and page number and next heading number without any pause
 - "link" announcement for footnote appears in a random place in the previous line and the footnote number is read as normal text
 - The footnote text is read as part of the column so appears in the middle of the paragraph text that is broken across the columns (here between the hyphenated word  _"docu-ment"_)
 - Hyphenated words such as mathemat-ics are not rejoined correctly, e.g., read as _"mathemat I C S"_ (this is a reader issue which we expect to be resolved soon)
 - The heading _"2 Document structures"_ is interpreted as a list with one item
 - Subheadings are read as _"Two One Mathematics"_ not as "2.1 Mathematics"
 - Reading of math is garbled as sub- and superscripts are not announced and punctuations and other symbols are not read
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

#### Summary

The untagged PDF is basically incomprehensible.


### Acrobat/NVDA reading untagged PDF

{% include youtube.html id="OpIjDwJqFKc" width="medium" comment="t5 acrobat"%}

#### Observations

 - From each TOC line with dots one dot is read, e.g., _"2 POINT 1 LINK Mathematics DOT 1"_
 - The paragraph "Apart from ..." is read strangly: many words are read letter by letter
 - "link" announcement for footnote appears in a random place in the same line (two words earlier) and the footnote number is read as normal text
 - The footnote text is read as part of the column so appears in the middle of the paragraph text that is broken across the columns (here between the hyphenated word  _"docu-ment"_)
 - Reading of math is garbled as sub- and superscripts are not announced and punctuations and other symbols are not read
 - Mathematics and text are read without a pause even if a new paragraph starts 
 - The matrices are read top down, e.g., _"thirteen twentyfour"_ without any indication that these are matrices
 - Again, the sentence "Here we reference item 2" is read partially letter by letter (seems to be caused by the fatc that the sentence contains a link)
 - On page 2 the running header is read as text _"3 CITATIONS"_
 - The sentence "Small images may ..." is garbled with words read letter by letter
 - The table is not recognized and read as if it is a normal paragraph
 - The paragraph after the table and the marginal are read horizonatally across marginal and paragraph; additionally the text is garbled and mostly read letter by letter
 - The 2 from 2.4 is appended to the end of the marginal and the heading is read as _"4 Theorems"_
 - The formula is read as _"an + b-en = c-en"_
 - The display of verbatim code is read without the parentheses and curly brackets
 - The paragraph starting "It is also possible..." is again garbled and read partly letter by letter

#### Summary

The same untagged PDF gets a different reading compared to the previous one, but overall the results are equally incomprehensible.

### Foxit reading GitHub display of markdown extracted by ChatGPT

#### Notes

This document is shown as one possible alternative. ChatGPT 3 was used. The untagged PDF was uploaded and the following question posed:

> Please show full markdown source for an accessible document suitable for a blind reader extracted from this PDF

The supplied markdown was not edited other than changing `\(` and `\[` to `$` and `$$` to match the default MathJax configuration at GitHub. The markdown was then viewed in GitHub markdown preview, Foxit was used to read the rendered web page.

{% include youtube.html id="hzVnFZqD9BE" width="medium" comment="t5 chatgpt foxit"%}

#### Observations

 - Text and visual presentation do no longer match (this is now a one column document but the text talks about it being a 2-column document), but for AT usage that is ok
 - The footnote with important information was dropped
 - The equation labels are lost
 - The matrices are shown with brackets not parentheses
 - The sentence after the list "Here we reference ..." is incorrectly shown as a third-level list item
 - The inline graphics in section 3.4 is not shown and not read
 - The table is misinterpreted, changing it to a 3-column table with the headers not matching their columns (i.e., not possible to navigate or understand the table content)
 - The marginal note with (important) information was dropped
 - The graphic of the float is lost and only a caption is placed in the document
 - ChatGPT invented a word and changed "Fermat's last" to _"Fermat's last theorem"_
 - The display of verbatim code is read without the parentheses and curly brackets
 - The last two sections have been rewritten and shortened by ChatGPT, i.e., the Reference section was dropped and the references put inline

#### Summary

ChatGPT produces a fairly reasonable result for a larger portion of the document, but fails it in several critical areas by
 - not handling graphics and tables correctly,
 - dropping relevant footnotes and marginal notes,
 - losing equation labels, and
 - possibly misrepresenting the authors intentions by rewriting portions of the text.

The sample document is too short to assess how severe these limitations are in longer and more complex documents. It is likely, though, that this approach to accessibility, while appearing  on the surface as a good representation, is in fact producing a crippled and incorrect variant of the information that the author tries to convay.


###  Foxit/NVDA reading PDF tagged by Acrobat Pro auto-tagging (MacOS version)

This is the untagged PDF given to Acrobat Pro on a Mac and asked the software to auto-tag it. The resulting PDF is then read by Foxit/NVDA. A similar readout is produced when passing it to Acrobat Reader/NVDA.

{% include youtube.html id="v46SNqqBNJ8" width="medium" comment="t5-autotagged MacOS foxit"%}

#### Observations

 - The LaTeX logo is read as _"L A T E EX"_ (the only pronounciation that Leslie Lamport always said no to :-) )
 - The last line of the TOC is incorrectly identified as a list with 2 items
 - Hyphenated words such as mathemat-ics are not rejoined correctly, e.g., read as _"mathemat I C S"_ (this is a reader issue which we expect to be resolved soon)
 - Formulas are introduced as graphics and the content is incomplete and incorrectly read, i.e. no indication of sub- and superscripts, parentheses etc are seen as punctuation and are not read
 - The separate equations (on a single line) are joined and read without any pause despite the space in the source
 - Equation labels are read as numbers so difficult to understand
 - The inline graphics in section 3.4 is not shown and not read
 - The marginal is correctly separated from the main text and read separately
 - The formula is read as _"an + b-en = c-en"_
 - The display of verbatim code is read without the parentheses and curly brackets


#### Summary

For normal text structures the auto-tagging heuristics makes reasonable guesses and seldom fails (in this document the misinterpretation of the TOC row). However, the quality varies with the complexity of the document structure as we saw when using different documents. With respect to mathematics and graphics the reading always fails severily; basically only text characters contained in the formulas or graphics are read, everything else is ignored. This makes auto-tagging unsuitable for STEM documents.


###  Foxit/NVDA reading PDF tagged by Acrobat Pro auto-tagging (Windows version)

This is the untagged PDF this time given to Acrobat Pro on Windows (i.e., same software but on a different platform) to auto-tag it. The resulting PDF is then read by Foxit/NVDA. A similar readout is produced when passing it to Acrobat Reader/NVDA.

{% include youtube.html id="OZPOekam3y8" width="medium" comment="t5-autotagged UF foxit"%}

#### Observations

 - The LaTeX logo is read as _"L A T E EX"_
 - The last line of the TOC is misinterpreted as a heading level 5 (different heuristic result compared to the MacOS version)
 - Hyphenated words such as mathemat-ics are not rejoined correctly, e.g., read as _"mathemat I C S"_ (this is a reader issue which we expect to be resolved soon)
 - "link" announcement for footnote appears in a random place in the same line (two words earlier) and the footnote number is read as normal text (does not happen with the MacOS version)
 - The footnote text is not correctly identified and read as part of the main paragraph in the middle of the hyphenated word _"docu- ment"_
 - Reading of math is garbled as sub- and superscripts are not announced and punctuations and other symbols are not read
 - Mathematics and text are read without a pause even if a new paragraph starts 
 - The separate equations (on a single line) are joined and read without any pause despite the space in the source
 - Equation labels are read as numbers so difficult to understand
 - The matrices have a very strange reading order starting with _"Twentyone three one four one one equals..."_ and none of the matices are announced
 - The heuristic invented a third (nested) list
 - The page number _"1"_ and the running header _"3 CITATIONS"_ are both read as text
 - The float graphic is ignored and only the caption is read as normal text
 - The inline graphics in section 3.4 is not shown and not read
 - The table is read as normal paragraph text
 - The marginal and the paragraph next to it are identified as a single paragraph and the reading alters between both line by line
 - The formula is read as _"an + b-en = c-en"_
 - The display of verbatim code is read without the parentheses and curly brackets

#### Summary

Auto-tagging using the Windows software gives worse results than the corresponding version on MacOS, which is a bit surprising, but should the general problem that auto-tagging is faced with: it has to interpret visual clues that by themselves allow for several interpretation and it is often not clear to the software if alignments (e.g., same baseline) indicate a reading order or if other  aspects (e.g., size of spaces) should take precidence---on themarginal the software fail spectacular in this document.
 With respect to mathematics and graphics the reading always fails severily; basically only text characters contained in the formulas or graphics are read, everything else is ignored. This alone makes auto-tagging unsuitable for STEM documents.


## Tagging, using associated files for math

```latex
{% include_relative t5-af.tex %}
```

### Foxit/NVDA reading PDF with MathML AF

{% include youtube.html id="kyZMO1N96tw" width="medium" comment="t5-af foxit"%}

## Tagging, using MathML structure elements
```latex
{% include_relative t5-se.tex %}
```

#### Observations

 - 
 - 
 - 

#### Summary



### Acrobat Reader/NVDA reading PDF with MathML SE

{% include youtube.html id="AwxQ0zYYKqw" width="medium" comment="t5-se acrobat"%}

#### Observations

 - 
 - 
 - 

#### Summary



----

## Software and Settings

All the readings were generated on Microsoft Windows, using
a test release of NVDA 2025.1 with Windows OneCore voice "Zira".
The NVDA addon MathCAT 0.67-rc.9 is responsible for reading MathML.

Pronunciation of some technical words was improved by using the following
settings in the NVDA speech dictionary 

| Pattern   | Replacement | case | Type       |
|----       |----         |----  |----        | 
| LaTeX	    | lay-tech	  | on   | whole word |
| alignat   | align-at    | on   | whole word |
| flalign   | f-l-align   | on   | whole word |
| notag	    | no-tag      | on   | whole word | 
| bibTEX    | bib-tech    | off  | whole word | 
| unordered | un-ordered  | off	 | whole word | 
| TeX       | tech        | on   | whole word |

Foxit Reader used was version 2025.3.0.28197

Acrobat Reader used was version 2025.001.20432


