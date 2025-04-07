---
lang: en
layout: default
extrahead: youtube-head
---

[Accessible STEM documents](./)

----

# Screen Reading Examples

## Table of Contents.

The first overview of a document is often presented by a table of
contents. However a screen reader may have difficulty inferring a
usable reading. With an untagged document it relies on the screen
reader inferring the structure, to pass to the underlying Accessibility
tools.

On this document foxit produces the following reading (Acrobat is similar).

{% include youtube.html id="HylCvun3q1g" width="medium" comment="T5 untagged toc, foxit" %}



Using the tagged PDF, the structure is made explicit to the screen
reader and typesetting atrtifacts such as leader dots are marked as
artifacts and not read, producing a far more understandable reading.

{% include youtube.html id="IQz3Xouc6Ko" width="medium" comment="T5 tagged toc, foxit" %}


Autotagged document.

{% include youtube.html id="NkDYH9doLI4" width="medium" comment="t5 autotagged toc, foxit" %}

