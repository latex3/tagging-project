# The LaTeX Tagged PDF Project



This [tagging-project repository](https://github.com/latex3/tagging-project/) is meant to track issues and suggestions related to the "LaTeX Tagged PDF" 
project. The code for this project is split over several other repositories 
([latex2e](https://github.com/latex3/latex2e), [latex3](https://github.com/latex3/latex3), [tagpdf](https://github.com/latex3/tagpdf), ... to name a few) and so this here is a convenient place to  keep any more general topics or issues that cut across the different repositories in a single place. 

## Issues

If an [issue](https://github.com/latex3/tagging-project/issues) that is recorded here requires changes in the other repositories 
sub-issues can then be opened (by us) in those repositories and linked back, 
or, if such changes are confined to a single repository, the issue could be 
transferred there – whatever is more appropriate. 

## Discussions

Under "[Discussions](https://github.com/latex3/tagging-project/discussions)" there is a pages that allow contributed comments and discussions that can be more general or long-term than the issues,

Some notable pages include

 * [WTPDF / PDF/UA-2 example documents](https://github.com/latex3/tagging-project/discussions/72) that were originally produced in March 2024 using the then current prototype code, and have been updated periodically as the code has developed.

 * [PDF/UA-1 Examples by the LaTeX Project](https://github.com/latex3/tagging-project/discussions/82) PDF 1.7 versions of the documents (also generated automatically by altering the `\DocumentMetadata` declaration).

* [Interpreting a PDF Structure Tree as XML](https://github.com/latex3/tagging-project/discussions/789) A page describing the interaction between PDF Structure element tagging and PDF. This is sadly missing from the PDF specifications but is needed to define the use of MathML for tagging mathematics, and is also used extensively in the project test suite which uses XML RelaxNG schema to validate the resulting tagging in each document.

## Documentation for the LaTeX Tagged PDF project

The [documentation](documentation) page has links to extensive documentation about producing tagged PDF with LaTeX.
