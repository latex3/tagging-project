# The LaTeX Tagged PDF repository
## General remarks
This [tagging-project repository](https://github.com/latex3/tagging-project/) does not contain any code.

It is meant to track issues and suggestions related to the "LaTeX Tagged PDF" project. The code for this project is split over several other repositories ( [latex2e](https://github.com/latex3/latex2e), [latex3](https://github.com/latex3/latex3), [tagpdf](https://github.com/latex3/tagpdf), ... to name a few) and so this here is a convenient place to keep any more general topics or issues that cut across the different repositories in a single place.

If an [issue](https://github.com/latex3/tagging-project/issues) that is recorded here requires changes in the other repositories
sub-issues can then be opened (by us) in those repositories and linked back,
or, if such changes are confined to a single repository, the issue could be
transferred there – whatever is more appropriate.

## Basic example for accessible PDFs
This basic example compiles a tagged PDF 2.0 without any errors. To fully comply with the PDF/UA-2 standard, ensure you explicitly set the document's title and language.

    \DocumentMetadata{
		lang          = en-us,
		pdfstandard   = ua-2,
		pdfversion    = 2.0,
		tagging       = on,
		tagging-setup = {math/setup=mathml-SE} 
    }
    \documentclass{article}
    \begin{document}
      This is a tagged PDF with some accessible content.
    \end{document}

For more detailed examples and various topics, please see the sections below.
## Using LaTeX for accessible PDF
Check out our documentation on [using the prototype to generate accessible PDFs](https://latex3.github.io/tagging-project/documentation/prototype-usage-instructions). The documentation will be updated whenever we alter the still temporary interfaces.
## Documentation
At the moment documentation about tagging is sprinkled across different places. Here is [an overview on where to find these places](https://latex3.github.io/tagging-project/documentation/documentation-pointers).

Help is welcomed to combine them into a single document.

Beyond the documentation, you can also find answers to various issues in " [Discussions](https://github.com/latex3/tagging-project/discussions)" or [Tex.stackexchange.com ](https://tex.stackexchange.com/questions/tagged/tagged-pdf)(searching with `[tagged-pdf])`
## Status of LaTeX classes
Here's a list of core and contributed LaTeX packages, showing [their compatibility with the tagging code](https://latex3.github.io/tagging-project/tagging-status/).
## History and archive
Example documents conforming to both Well-Tagged PDF (WTPDF) and PDF/UA-2 standard produced by the LaTeX Project by March 2024 are available at [WTPDF / PDF/UA-2 example documents](https://github.com/latex3/tagging-project/discussions/72)

Documentation for PDF 1.7 versions are available on page [PDF/UA-1 Examples by the LaTeX Project](https://github.com/latex3/tagging-project/discussions/82).

See <https://www.latex-project.org/publications/indexbytopic/pdf/> for articles and other material about the "LaTeX Tagged PDF" project.

## License
LaTeX Project Public License, version 1.3c or later.

You can always find the most current version of this page at: https://latex3.github.io/tagging-project/
