---
lang: en
layout: default
extrahead: youtube-head
---

[Well Tagged PDF Video Examples](./)

----

# Screen Reading Examples (DRAFT)


## Mathematics

Mathematics is traditionally hard to automatically present.

In the untagged PDF the screen reader is just passed the raw
character data.  The superscript in the first equation is not read, so
losing the meaning, and the matrix equation is completely scrambled
with the entries being read in the wrong order.



{% include youtube.html id="eYO6_ereNhs" width="narrow" comment="t5 untagged math foxit"%}


At the present time different PDF readers support different ways of
tagging mathematics, here we present a version with math tagged with
Associated files containing MathML, which is understood by foxit, and
a version with the same MathML used as PDF Structure Element tagging,
which is understood by Acrobat. Identical readings are generated as in
either case the resulting MathML is passed via NVDA to MathCat to
generate the reading.

We expect that this is a temporary situation and that PDF readers will
soon support both mechanisms to supply MathML to the accessibility
tools. However for now, we need to build two separate PDFs, one using
Associated Files, and one with Structure Elements, to support current
PDF viewers.

Associated Files and foxit

{% include youtube.html id="6qU00UsWh3c" width="narrow" comment="t5 math af foxit%}

Structure Elements and Acrobat

{% include youtube.html id="W6SMNdHwoHw" width="narrow" comment="t5 math se acrobat%}


Autotagged with Acrobat

{% include youtube.html id="5qe18epTNgE" width="narrow" comment="t5 autotagged foxit"%}


