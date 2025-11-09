# The LaTeX Tagged PDF Project



This [tagging-project repository](https://github.com/latex3/tagging-project/) is meant to track issues and suggestions related to the "LaTeX Tagged PDF" 
project. The code for this project is split over several other repositories 
([latex2e](https://github.com/latex3/latex2e), [latex3](https://github.com/latex3/latex3), [tagpdf](https://github.com/latex3/tagpdf), ... to name a few) and so this here is a convenient place to  keep any more general topics or issues that cut across the different repositories in a single place. 

### Documentation for the LaTeX Tagged PDF project

The [documentation](documentation) page has links to extensive documentation about producing tagged PDF with LaTeX.


### Guidelines for using LaTeX to generate accessible PDF

We have written [guidelines explaining how to use LaTeX to
generate accessible PDFs](usage-instructions). The documentation will
be updated as new features become available.

### Status of Contributed LaTeX Classes and Packages

The [Tagging Status](../tagging-status/) pages document the current
status of over 1000 Contributed packages. This status with respect to
tagging is maintained with the help of a test suite run automatically
in the CI system associated to this site.



### Reporting Issues

In the [Issues area](https://github.com/latex3/tagging-project/issues)
users can open issues for any part of the tagging project without worrying
about which code repository holds the code which needs to be fixed.
Wwe can move issues to opther repositories when appropiate.
Issues are also used to document package incompatibilites with examples .



### Discussing Ideas and Concepts

In the  "[Discussions area](https://github.com/latex3/tagging-project/discussions)" there are pages that allow contributed comments and discussions that can be more general or long-term than the issues.

Some notable discussion pages include

 * [WTPDF / PDF/UA-2 example documents](https://github.com/latex3/tagging-project/discussions/72) that were originally produced in March 2024 using the then current prototype code, and have been updated periodically as the code has developed.

 * [PDF/UA-1 Examples by the LaTeX Project](https://github.com/latex3/tagging-project/discussions/82) PDF 1.7 versions of the documents (also generated automatically by altering the `\DocumentMetadata` declaration).

* [Interpreting a PDF Structure Tree as XML](https://github.com/latex3/tagging-project/discussions/789) A page describing the interaction between PDF Structure element tagging and XML. This is sadly missing from the PDF specifications but is needed to define the use of MathML for tagging mathematics, and is also used extensively in the project test suite which uses XML RelaxNG schema to validate the resulting tagging in each document.

