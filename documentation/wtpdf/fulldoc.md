---
lang: en
layout: "ngpdf"
extrahead: youtube-head
---

[Accessible STEM documents](./)

----

# Listening to untagged and tagged PDF


<nav id="toc" markdown=1>

## Table of Contents

* [Untagged PDF](#untagged)
  * [Read with Foxit/NVDA](#foxit-untagged)
  * [Read with Acrobat/NVDA](#acrobat-untagged)
* ["Autotagged" PDF](#autotagged)
  * [Autotagged Acrobat/MacOS](#auto-macos)
  * [Autotagged Acrobat/Windows](#auto-windows)
* [Tagged PDF generated from LaTeX](#latex-tag)
  * [Configuration possibilities](#latex-configs)
  * [MathML AF with Foxit/NVDA](#foxit-af)
  * [MathML SE with Acrobat/NVDA](#acrobat-se)
* [ChatGPT's interpretation](#chatgpt)
  * [ChatGPT3 Markdown](#chatgpt3)
  * [ChatGPT4 HTML](#chatgpt4html)
  * [ChatGPT4 Markdown](#chatgpt4markdown)
* [NVDA's pronunciation settings](#settings)
* **Sections**
  * [TeX sources](larger-example)
  * [Table of Contents](toc)
  * [Mathematics](math)
  * [Code blocks](verbatim)
</nav>

Accurate reading is critical; even small mistakes in reading STEM content can result in entirely incorrect understandings.

There are many ways to try to make PDF documents accessible. To highlight the importance of accuracy in representing the author’s intent we recorded and analyzed a screen-reader reading the results from various attempts by software to understand a “realistic” demonstration PDF.

The recordings were made on Windows 11 using the test release of NVDA 2025 (which enables reading of MathML) and version 0.6.8-rc.9 of the MathCat plugin. Testing included two PDF viewers, Foxit and Adobe Acrobat.

For the recording of a [tagged PDF generated from LaTeX](#latex-tag), we used a PDF 2.0 file, which allows us to include MathML in an accessible manner. These recordings showcase two distinct routes to including MathML in PDF 2.0: PDF's Associated Files feature and MathML structure elements in the tags tree. 

Access the [LaTeX source](larger-example#example-doc) of the test file used to make these recordings.

## Listening to untagged PDF {#untagged}

Everyone might understand that [math is hard](https://latex3.github.io/tagging-project/documentation/wtpdf/math). But surely, commonplace elements such as [tables of contents](https://latex3.github.io/tagging-project/documentation/wtpdf/toc) or [pronouncing symbols in code-blocks](https://latex3.github.io/tagging-project/documentation/wtpdf/verbatim) must produce reasonable results when vocalized, regardless of system? Not necessarily.

###  Foxit/NVDA reading untagged PDF  {#foxit-untagged}
- Foxit Reader 2025.3.0.28197 (Windows 11)
- NVDA 2025.1.2 using Windows OneCore voice "Zira"
- NVDA addon MathCAT 0.6.10

{% include youtube.html id="txELZR_EDTo" width="medium" comment="t8 foxit"%}

#### Observations

It is very difficult to find all issues with this document if you are looking at the text in parallel, so close your eyes and try to understand what is told to you. Here is a (possibly incomplete) list of issues:

 - Link announcements duplicate the link text, e.g., _"Link 1 Introduction 1 Introduction 1"_
 - Until June 2025 the TOC was read with a lot of  _"dot dot dot ..."_ and page number and next heading number without any pause. This has now been improved through configuration settings in NVDA that can ignore multiple dots; but listen to [this recording](https://latex3.github.io/tagging-project/documentation/wtpdf/toc) to hear what was produced in the last years
 - "link" announcement for footnote appears in a random place in the previous line and the footnote number is read as normal text
 - The footnote text is read as part of the column so appears in the middle of the paragraph text that is broken across the columns (here between the hyphenated word  _"docu-ment"_)
 - Hyphenated words such as mathemat-ics are not rejoined correctly, e.g., read as _"mathemat I C S"_ (this is a Foxit/NVDA issue which we expect to be resolved soon)
 - The heading _"2 Document structures"_ is interpreted as a list with one item
 - Subheadings are read as _"Two One Mathematics"_ not as "2.1 Mathematics"
 - Reading of math is garbled as sub- and superscripts are not announced and punctuations and other symbols are not read
 - Equation labels are read as numbers so difficult to understand
 - The second display math equation and the following text "Matrices" are interpreted as a single table and a list with one item producing an incomprehensible reading
 - The matrix equation is read backwards _"3 4 1 2"_ not as "1 2 3 4" and without any indication that these are matrices
 - The nested structure of the lists is not deducible
 - The reference back to item 2 in the sentence after the list makes the list entry come out as _"2 items within such a list may be refer items within such a list may be referenced"_
 - The link area is identified as being on the line before, therefore the word _"Link"_ is added before _"Here we reference item 2"_ (same problem as with the footnote mark, except that there the previous line has text)
 - The float with the Helvetica A is interpreted as a table and its caption is read as normal text
 - The heading "2.3 Figures and Tables" is read as _"LIST WITH ONE ITEM 2 3 figures and tables 3 figures an  d tables OUT OF LIST"_
 - The inline graphic is not announced and simply dropped
 - The small table and the following paragraph with a marginal confuses the reading software totally:
     - everything is announced as a table with 7 rows,
     - the reading order reads lines from the marginal and
     - the paragraph and several bits of text are repeated
     - The heading "2.4 Theorem" is  read as two columns of that table
 - The caption of the reorem is read as _"Theorem 1 Fermat ESS last"_
 - Instead of "such that \$a^n + b^n = c^n\$" it reads _"such than plus b-en equals c-en"_ (the _"than"_ is probably a Microsoft speech generator issue combing in _"that a n"_ to _"than"_)
 - The display of verbatim code is read without the parentheses and curly brackets
 - The readout of the paragraph in section 3 has the word _"database"_ added several times in place of the citations `[1]` and `[2]`
 - In the bibligraphy the page number 312 is read as _"three twelve"_ but 313 is read correctly
 - Important punctuations to correctly identify the bibliography items are dropped

#### Summary

The untagged PDF is basically incomprehensible.


### Acrobat/NVDA reading untagged PDF {#acrobat-untagged}
- Adobe Acrobat Reader 2025.001.20432 (Windows 11)
- NVDA 2025.1.2 using Windows OneCore voice "Zira"
- NVDA addon MathCAT 0.6.10

{% include youtube.html id="HGm-vCuyQdo" width="medium" comment="t8 acrobat"%}

#### Observations

 - The reading of the TOC lines are now (with NVDA 2025) fairly good; until recently at least one dot was read (probably interpreted as a sentence ending), e.g., _"2 POINT 1 LINK Mathematics DOT 1"_
 - The paragraph "Apart from ..." is read strangely: many words are suddenly read letter by letter
 - The footnote text is read as part of the column so appears in the middle of the paragraph text that is broken across the columns (here between the hyphenated word  _"docu-ment"_)
 - Reading of math is garbled as sub- and superscripts are not announced and punctuations and other symbols are not read
 - Mathematics and text are read without a pause even if a new paragraph starts 
 - The matrices are read top down, e.g., _"thirteen twenty four"_ without any indication that these are matrices
 - The lists are not announced as lists and their nesting is not made clear
 - Again, the sentence "Here we reference item 2" is read partially letter by letter (seems to be caused by the fact that the sentence contains a link)
 - On page 2 the running header is read as text _"3 CITATIONS"_
 - The sentence "Small images may ..." is garbled with words read letter by letter
 - The table is not recognized and read as if it is a normal paragraph
 - The paragraph after the table and the marginal are read horizontally across marginal and paragraph; additionally the text is garbled and mostly read letter by letter
 - The formula is read as _"that an b-en c-en"_
 - The display of verbatim code is read without the parentheses and curly brackets
 - The paragraph starting "It is also possible..." is again garbled and read partly letter by letter

#### Summary

The same untagged PDF gets a different reading compared to the previous one, but overall the results are equally incomprehensible or perhaps even worse with the random letter by letter reading.

## Reading PDF Auto Tagged by Acrobat {#autotagged}

###  Foxit/NVDA reading PDF tagged by Acrobat Pro auto-tagging (MacOS version) {#auto-macos}
- Foxit Reader 2025.3.0.28197 (Windows 11)
- NVDA 2025.1.2 using Windows OneCore voice "Zira"
- NVDA addon MathCAT 0.6.10

The untagged PDF was auto-tagged by Acrobat Pro on a Mac. The resulting PDF is then read by Foxit/NVDA. A similar readout is produced when passing it to Acrobat Reader/NVDA.

{% include youtube.html id="L9vph4rLTFk" width="medium" comment="t8 autotagged macOS foxit"%}

#### Observations

 - The LaTeX logo is read as _"L A T E EX"_ (the only pronunciation that Leslie Lamport always said no to :-) )
 - The last line of the TOC is incorrectly identified as a list with 2 items
 - Hyphenated words such as mathemat-ics are not rejoined correctly, e.g., read as _"mathemat I C S"_ (this is a reader issue which we expect to be resolved soon)
 - The footnote text is no longer read in the middle of the paragraph but after the paragraph has finished, so it was correctly identified by the auto-tagging!
 - Formulas are introduced as graphics and the content is incomplete and incorrectly read, i.e. no indication of sub- and superscripts, parentheses etc are seen as punctuation and are not read
 - The separate equations (on a single line) are joined and read without any pause despite the space in the source
 - Equation labels are read as numbers so difficult to understand
 - The inline graphics in section 3.4 is not shown and not read
 - The marginal is correctly separated from the main text and read separately
 - The formula is read as _"a-en  b-en  c-en"_, i.e., the plus and equal are dropped and the exponents arn't announced
 - The display of verbatim code is read without the parentheses and curly brackets

#### Summary

For normal text structures the auto-tagging heuristics make reasonable guesses and seldom fail (in this document the misinterpretation of the TOC row). However, the quality varies with the complexity of the document structure as we saw when using different documents. With respect to mathematics and graphics the reading always fails severely; basically only text characters contained in the formulas or in graphics are read, everything else is ignored. This makes auto-tagging unsuitable for STEM documents.


###  Foxit/NVDA reading PDF tagged by Acrobat Pro auto-tagging (Windows version) {#auto-windows}
- Foxit Reader 2025.3.0.28197 (Windows 11)
- NVDA 2025.1 (test-release) using Windows OneCore voice "Zira"
- NVDA addon MathCAT 0.6.8-rc.9

The untagged PDF was auto-tagged by Adobe Acrobat Pro on Windows. The resulting PDF is then read by Foxit/NVDA. A similar readout is produced when passing it to Acrobat Reader/NVDA.

{% include youtube.html id="dHvhTxZWd7E" width="medium" comment="t8 -autotagged Windows foxit"%}

#### Observations

 - The LaTeX logo is read as _"L A T E EX"_
 - The last line of the TOC is misinterpreted as a heading level 5 (different heuristic result compared to the MacOS version)
 - Hyphenated words such as mathemat-ics are not rejoined correctly, e.g., read as _"mathemat I C S"_ (this is a reader issue which we expect to be resolved soon)
 - The footnote text is not correctly identified and read as part of the main paragraph in the middle of the hyphenated word _"docu- ment"_ (does not happen with the MacOS auto-tagged version)
 - Reading of math is garbled as sub- and superscripts are not announced and punctuations and other symbols are not read
 - Mathematics and text are read without a pause even if a new paragraph starts 
 - The separate equations (on a single line) are joined and read without any pause despite the space in the source
 - Equation labels are read as numbers so difficult to understand
 - The matrices have a very strange reading order starting with _"Twenty-one three one four one one ..."_ and none of the matrices are announced
 - The heuristic invented a third (nested) list
 - The page number _"1"_ and the running header _"3 CITATIONS"_ are both read as text (despite auto-tagging)
 - The float graphic is ignored and only the caption is read as normal text
 - The inline graphics in section 3.4 is not read
 - The table is read as normal paragraph text
 - The marginal and the paragraph next to it are identified as a single paragraph and the reading alters between both line by line
 - The formula is read as _"an + b-en = c-en"_
 - The display of verbatim code is read without the parentheses and curly brackets

#### Summary

Auto-tagging using the Windows software gives worse results than the corresponding version on MacOS. This is a bit surprising, but it shows the general problem that auto-tagging is faced with: it has to interpret visual clues that by themselves allow for several interpretation and it is often not clear to the software if alignments (e.g., same baseline) indicate a reading order or if other aspects (e.g., size of spaces) should take precedence---on the marginal the software failed spectacularly in this document.
 With respect to mathematics and graphics the reading always fails severely; basically only text characters contained in the formulas or graphics are read, everything else is ignored. This alone makes auto-tagging unsuitable for STEM documents.



## Listening to Tagged PDF generated directly from LaTeX {#latex-tag}

When LaTeX source content includes math formulas there are two ways to generate tagged PDF directly from LaTeX:

- The AF method, in which a MathML representation of each formula is contained within a so-called Associated File (AF) embedded within the PDF.
- The SE method, in which the MathML representation is embedded into PDF structure elements (the "tags tree").

Both are valid approaches in PDF 2.0, but unfortunately, as of today, PDF consumer applications differ in their support. We hope that the majority of the PDF readers soon fully support PDF 2.0, including both of the above methods.

LaTeX can automatically produce the necessary MathML for either method if the LuaTeX engine is used. If pdfTeX is used only the AF method is supported and the data for the AF files have to be prepared in a separate step, as is explained elsewhere.

### Configuration possibilities {#latex-configs}

As shown in [the example page](larger-example) LaTeX may be configured to use
Associated files or Structure Elements to provide MathML tagging for mathematics.

### Foxit/NVDA reading PDF with MathML AF {#foxit-af}
- Foxit Reader 2025.3.0.28197 (Windows 11)
- NVDA 2025.1 (test-release) using Windows OneCore voice "Zira"
- NVDA addon MathCAT 0.6.8-rc.9

The sample document shown in the video was compiled with the above configuration lines using the LuaTeX engine. The resulting PDF was then displayed in Foxit with NVDA as a speech generator.

{% include youtube.html id="KznoGTQmWeM" width="medium" comment="t8 af foxit"%}

#### Observations

 - The normal text structures are all handled correctly
 - The footnote is correctly identified and the footnote text is read in a suitable place 
 - All mathematics are read correctly and can be understood
 - Graphics are not dropped; instead their Alt text is read
 - Punctuations, symbols, and newlines are announced in verbatim text

#### Remaining issues

 - Handling of verbatim is still under development with improvements possible
 - Foxit passes on softhyphens which are not ignored by NVDA (resulting in distorted reading). Workaround applied which improves the situation but a general fix would be better

#### Summary

The example shows that the accessibility of STEM documents produced by LaTeX is very high and there are no problems with complex material.


### Adobe Acrobat Reader/NVDA reading PDF with MathML SE {#acrobat-se}
- Adobe Acrobat Reader 2025.001.20432 (Windows 11)
- NVDA 2025.1.2 using Windows OneCore voice "Zira"
- NVDA addon MathCAT 0.6.10


{% include youtube.html id="gDCz_zkIq2k" width="medium" comment="t8 se acrobat"%}

#### Observations

 - The normal text structures are all handled correctly
 - The footnote is correctly identified and the footnote text is read in a suitable place
 - In general, this reader announces the kind of link it encounters, e.g., footnote, enumitem, or figure (and its internal label, the latter is probably not so helpful)
 - All mathematics are read correctly and can be understood
 - Graphics are not dropped; instead their Alt text is read and the information is introduced with the word _"GRAPHIC"_

#### Remaining issues

 - Repeats links in TOC lines several times, e.g., _"LINK LINK LINK LINK 1 Introduction"_  (bug in Acrobat?)
 - A similar problem in other places, e.g., reference to bib entries


#### Summary

The example shows that the accessibility of STEM documents produced by LaTeX is very high and there are no problems with complex material.

The use of structure elements instead of AF files give identical results for math. The reading of the rest of the document is similar, with slight differences due to the use of different PDF consumer applications. Some are due to bugs, others are due to different decisions on what is or should be passed on to the speech generator (e.g., handling of tables, announcing links or graphics), some of this is configurable in the consumer application.


## Listening to ChatGPT's interpretation {#chatgpt}

### Foxit reading GitHub display of markdown extracted by ChatGPT 3 {#chatgpt3}
- Foxit Reader 2025.3.0.28197 (Windows 11)
- NVDA 2025.1 (test-release) using Windows OneCore voice "Zira"
- NVDA addon MathCAT 0.6.8-rc.9

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

ChatGPT 3 produces a fairly reasonable result for a larger portion of the document, but fails it in several critical areas by
 - not handling graphics and tables correctly,
 - dropping relevant footnotes and marginal notes,
 - losing equation labels, and
 - possibly misrepresenting the authors intentions by rewriting portions of the text.

The sample document is too short to assess how severe these limitations are in longer and more complex documents. It is likely, though, that this approach to accessibility, while appearing  on the surface as a good representation, is in fact producing a distorted and incorrect variant of the information that the author tries to convey.

### Foxit Reading ChatGPT 4 display {#chatgpt4html}
- Foxit Reader 2025.3.0.28197 (Windows 11)
- NVDA 2025.1 (test-release) using Windows OneCore voice "Zira"
- NVDA addon MathCAT 0.6.8-rc.9

Using ChatGPT4 a similar query produced a markdown document immediately displayed rather than shown as source.

{% include youtube.html id="oByx8Q1ypM4" width="medium" comment="t5-chatgpt4-chatgpt foxit"%}

#### Observations

 - ChatGPT 4 is not only trying to produce an accessible document but also rewriting the text
 - Headings lose their numbers (would be a problem if cross-referenced)
 - The footnote is turned into an inline note (which works well)
 - Overall math a reading is understandable, but not all components are recognized, e.g., no reading of "mod" but _"M O D"_
 - The equation numbers are dropped (would be a problem if cross-referenced)
 - The inline graphics in section 3.4 is not shown and not read
 - The original table had 2 header rows and two data rows, The first header row spanning both columns was converted to normal text. While this works reasonably well for this table it alters the table data and would break more complex table structures
 - The graphic of the float is dropped and the caption is read as normal text
 - Minor rewrite of the Theorem caption
 - The display of verbatim code is read without the parentheses and curly brackets

#### Summary

ChatGPT 4 does some things better than the trials we did with ChatGPT 3 and on the surface this appears to be a workable path to make an untagged PDF accessible. However, the tendency to rewrite the document content (which is in the nature of LLMs), the dropping of important information (such as graphics and labels) means that this approach is questionable---the fact that it "reads well" while at the same time presents corrupted information is a dangerous combination. 

### Foxit Reading GitHub display of ChatGPT 4 markdown {#chatgpt4markdown}
- Foxit Reader 2025.3.0.28197 (Windows 11)
- NVDA 2025.1 (test-release) using Windows OneCore voice "Zira"
- NVDA addon MathCAT 0.6.8-rc.9

ChatGPT was then queried to show the markdown source, which (as for ChatGPT3) is then rendered in GitHub.
Note here the document text has been extensively re-worded by ChatGPT.

{% include youtube.html id="G7g8AqQdlSQ" width="medium" comment="t5-chatgpt4-github foxit"%}

#### Observations

 - The markdown returned from ChatGPT 4 is heavy reworded and shortened
 - The equation numbers are dropped (would be a problem if cross-referenced)
 - The introductory text to the set of equations has been altered
 - A comma on the first line of equations has been invented (but not on the second line)
 - The last item of the inner list as been rewritten incorrectly (new meaning is incorrect)
 - The text following the lists has been completely dropped
 - The sentence on small figures and tables has been dropped; the sentence on floats as been altered (no longer mentioning floats) and marginal has been dropped
 - The graphic of the float has been dropped and the caption is read as normal text
 - The theorem caption and text have been rewritten
 - The text explaining the requirement for verbatim code blocks has been dropped
 - The display of verbatim code is read without the parentheses and curly brackets
 - The last two sections have been merged and shortened to just a bibliography list
 - The bibliography list items have been reordered and are not labeled (i.e., can't be referenced from  within the document)

#### Summary

 In many places important information in the original document is completely lost (e.g., the note stating that the table syntax is temporary, etc.).  None of the supporting cross-references to other places in the document are preserved (text containing them was thrown away) and all footnotes, marginals, and graphics in the document have been eliminated. The result clearly shows the unpredictability of the approach: there is no way for the consumers to understand that what is read to them is not what was written in the original.

----

## NVDA pronunciation settings {#settings}

Pronunciation of some technical words was improved by using the following
settings in the NVDA speech dictionary:

| Comment            | Pattern   | Replacement | case | Type       |
|----                |----       |----         |----  |----        | 
|                    | LaTeX     | lay-tech    | on   | whole word |
|                    | alignat   | align-at    | on   | whole word |
|                    | flalign   | f-l-align   | on   | whole word |
|                    | notag     | no-tag      | on   | whole word | 
|                    | bibTEX    | bib-tech    | off  | whole word | 
|                    | unordered | un-ordered  | off  | whole word | 
|                    | TeX       | tech        | on   | whole word |
|                    | tugboat   |  tug-boat   | off  | Anywhere   |
| Ignore softhyphens | ­         |             | off  | Anywhere   | 
| Hyphenation help   | cluding   | clueding    | off  | whole word |

The _Ignore softhyphens_ row contains an invisible softhyphen character in the second column replaced by "nothing", which improved the reading of hyphenated words in the Foxit/NVDA workflow.
