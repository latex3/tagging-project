---
lang: en
layout: default
extrahead: youtube-head
---

# Accessible STEM documents
## Generating Well-Tagged PDF from LaTeX

STEM publishing requires precision; the content's visual appearance must precisely and reliably reflect the author's intention. Historically, this concern was limited simply to the content's visual appearance. To ensure equal access to users with disabilities, today it's vital to ensure that similar precision is applied to alternative representations and usage of the content. 

As an addtional benefit, well-tagged PDF is optimized for reuse by software capable of directly leveraging the author's intent as expressed via PDF's tag tree.

These pages demonstrate LaTeX to accessible PDF conversion:

 * [A very simple demonstration](small-example)
 * [A more realistic demonstration](larger-example)

## Can automation produce acceptable results? 

Accurate reading is critical; even small mistakes in reading STEM content can result in entirely incorrect understandings.

There are many ways to try to make PDF documents accessible. To highlight the importance of accuracy in representing the author's intent we recorded a screen-reader reading the results from various attempts by software to understand the "realistic" demonstration PDF. In each case we provide an analysis of the results.

You can listen to the [full document](fulldoc) or focus on:

 * [Tables Of Contents](toc)
 * [Mathematics](math)
 * [TeX and PDF files](sources)

All examples were on Windows 11 using the test release of NVDA 2025 (which enables reading of MathML) and the public version (as of March 2025) of the MathCat plugin. Testing included two PDF viewers, Foxit and Adobe.
