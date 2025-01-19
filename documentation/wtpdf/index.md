---
lang: en
layout: default
extrahead: youtube-head
---

# Screen Reading Examples (DRAFT)


The "Larger Example" on the [WTPDF from LaTeX page](https://latex3.github.io/tagging-project/documentation/wtpdf-from-latex#a-larger-example)
shows a small typical LaTeX article set in two columns with tables and figures.

Here we show the effect of tagging on generated speech. All examples
use the test release of NVDA 2025 (enabling interfacing to MathML
readings), along with public versions of MathCat,  Foxit and 
Acrobat Reader on Windows 11.

To present something of the experience to users not familiar with screen
readers, we have provided video clips of readings of the full document
and of specific sections. Although a video format is used they are all
recordings of the screen reader, with a fixed video frame showing the
part the document in each case.


## Table of Contents.

The first overview of a document is often presented by a table of
contents. However a screen reader may have difficulty inferring a
usable reading. With an untagged document it relies on the screen
reader inferring teh structure to pass to the underlying Accessibility
tools.

On this document foxit produces the following reading (Acrobat is similar).


{% include youtube.html id="vEuz1bIluU0" width="medium"%}


Using the tagged PDF, the structure is made explicit to the screen
reader and typesetting atrtifacts such as leader dots are marked as
artifacts and not read, producing a far more understandable reading.

{% include youtube.html id="R01XRT7PSz4" width="medium"%}

## Mathematics

Mathematics is traditionally hard to automatically present.

In the untagged PDF the screen reader is just passed the raw
character data.  The superscript in the first equation is not read, so
losing the meaning, and the matrix equation is completely scrambled
with the entries being read in the wrong order.

{% include youtube.html id="9a1oFMe_Rxk" width="narrow"%}


At the present time different PDF readers support different ways of
tagging mathematics, here we present a version with math tagged with
Associated files containing MathML, which is understood by foxit, and
a version with the same MathML used as PDF Structure Element tagging,
which is understood by Acrobat. Identical readings are generated as in
either case the resulting MathML is passed via NVDA to MathCat to
generate the reading.

Associated Files and foxit  
{% include youtube.html id="Csu2Npbi7Tg" width="narrow"%}

Structure Elements and Acrobat  
{% include youtube.html id="Dj6ZQldpdqo" width="narrow"%}



-----


## Complete Videos

### Untagged PDF, with Foxit:


{% include youtube.html id="lHMQOh8aYKo" width="wide"%}


### Tagged PDF using Associated MathML Files, with Foxit:

{% include youtube.html id="lanL1s8fJPI" width="wide"%}


### Tagged PDF using MathML Structure Elements,with Acrobat:

{% include youtube.html id="v1Ydk8XhBv4" width="wide"%}


## The TeX source and LaTeX generated PDF

Available in three forms

`t1`, Classic LaTeX, typeset with pdftex and no tagging enabled.
[TeX](https://drive.google.com/file/d/1e-RD0C94hhoC9MyaXACqfwHJPqfhGLy7/view?usp=sharing)
[PDF](https://drive.google.com/file/d/1xSQc9mI41Vfblw2dJH_E1KTaSBdoPw6S/view?usp=drive_link)

`t1-af` Lualatex with Unicode Math and tagging enabled. Auto-generated MathML included as Associated files.
[TeX](https://drive.google.com/file/d/1VOcJdZuuLE0D6PqbtDd6gfIsTh5kyjqS/view?usp=drive_link)
[PDF](https://drive.google.com/file/d/16dUVtSZ2ToIsxyrQQ0D2-HCmGCgL3G41/view?usp=drive_link)

`t1-se`  Lualatex with Unicode Math and tagging enabled. Auto-generated MathML included as PDF Structure Elements.
[TeX](https://drive.google.com/file/d/1G2F3ObXlLfX6wQZqLJ7P2smbs--Q65kc/view?usp=drive_link)
[PDF](https://drive.google.com/file/d/17uJ7cIHkiTqr5HkPS3l0kmyvA4iW5HGA/view?usp=drive_link)






