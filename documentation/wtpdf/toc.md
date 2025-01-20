---
lang: en
layout: default
extrahead: youtube-head
---

[Well Tagged PDF Video Examples](./)

----

# Screen Reading Examples

## Table of Contents.

The first overview of a document is often presented by a table of
contents. However a screen reader may have difficulty inferring a
usable reading. With an untagged document it relies on the screen
reader inferring the structure, to pass to the underlying Accessibility
tools.

On this document foxit produces the following reading (Acrobat is similar).


<!-- toc untagged tagged foxit -->
{% include youtube.html id="vEuz1bIluU0" width="medium"%}




Using the tagged PDF, the structure is made explicit to the screen
reader and typesetting atrtifacts such as leader dots are marked as
artifacts and not read, producing a far more understandable reading.

<!-- toc tagged foxit -->
{% include youtube.html id="R01XRT7PSz4" width="medium"%}



Autotagged document, with Acrobat


<!-- t1 autotag toc acrobat-->
{% include youtube.html id="ZX2oWvT2_N4" width="medium"%}

