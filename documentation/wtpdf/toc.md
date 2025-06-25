---
lang: en
layout: default
extrahead: youtube-head
---

[Accessible STEM documents](./) > [Full Document](fulldoc)

----

# Reading Tables of Contents

## Untagged PDF

The first overview of a document is often presented by a table of
contents. However a screen reader may have difficulty inferring a
usable reading. With an untagged document it relies on the screen
reader inferring the structure, to pass to the underlying Accessibility
tools.

On this document foxit produced the following reading (Acrobat is similar)
when using a 2024 NVDA screen reader release.

{% include youtube.html id="HylCvun3q1g" width="medium" comment="T5 untagged toc, foxit" %}


Recent NVDA Releases have improved heuristics to control the reading
of multiple dots and the reading with NVDA 2025.1 is much better
however this does illustrate the difficulty in reading documents when no
explicit structure is provided.

{% include youtube.html id="YTQez-MQ7ZM" width="medium" comment="t8 toc, foxit" %}

This still results in each link text being announced twice.


## Tagged PDF

Using the tagged PDF, the structure is made explicit to the screen
reader and typesetting artifacts such as leader dots are marked as
artifacts and not read. Also link texts are only announced and read once.
This produces a far more reliably understandable reading.

{% include youtube.html id="_6KiEhAMa4o" width="medium" comment="T8 tagged toc, foxit" %}


## Autotagged document.

Here the recognition of the table of contents is unreliable, in some
cases "Link" is announced before the section number, and sometimes
after. The final link to the Citations section is not recognized as
part of the table of contents at all, and is announced as a new list.

{% include youtube.html id="KprMkcefKCA" width="medium" comment="t8 autotagged toc, foxit" %}

