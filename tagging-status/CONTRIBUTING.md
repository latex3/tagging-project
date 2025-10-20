# Adding the tagging status of your LaTeX class or package to this repository

If you want to contribute to this repository by adding the tagging status of your LaTeX class or package, please follow the below steps.

## Test your document class or package locally

To check the tagging support of your document class or package, write a test file 
that contains as many typical uses of your class or package that are relevant for tagging as you deem necessary. 
A test file for a document class can be a short example document. 
As packages have quite diverse functions, it is difficult to come up with a general idea of what a test file for a package should contain. 
If unsure, browse the test files that already exist in this repository to get an idea. 

A test file should contain at least the following lines:
```tex
  \DocumentMetadata
  {
    lang=en-US,
    pdfversion=2.0,
    pdfstandard=ua-2,
    tagging=on,
  }
\documentclass{article}
\usepackage{rpgicons}
\title{<class or package> tagging test}
\begin{document}
...
\end{document}
```

Store this test file in a subdirectory of your working directory 
where you store the document class or package file (the `.cls` or `.sty` file) 
with the path `testfiles/<class or package name>/<class or package name>-01.tex`. 
You can create more than one test files with appropriate numbering of the names.

Compile the test file and check the output using software such as PAC or VeraPDF to ensure that the tagging structure is correct. 
Use a screen reader such as NVDA to ensure that the alternative representation of the contents is as intended and semantically correct.

Run `l3build save <class or package name>-01` and `l3build save -e pdftex <class or package name>-01` 
(for multiple test files, just concatenate the names) in your working directory 
to create an XML file named `<class or package name>-01.struct.xml` in the `testfiles/<class or package name>/` subdirectory. 
Check the contents of this file as well. 
This file shows a combination of tagging, structure and alternative representations 
which can also help you to check the tagging support of your class or package. 
This file will also serve as test file against which the tagging status of your class or package is later checked against.  

If you spot XML comments such as `<!-- UTF16 to UTF8 conversion failure -->` in the generated XML file, 
it is likely that `cm-super` is not installed. 
These comments appear as there are not Unicode mappings for bitmap fonts which are maybe used because `cm-super` is not installed. 

## Add your test files to this repository

If you are confident that the tagging structure of your document class or package is fine, 
you can create a Pull Request to this repository to upload your testfiles together with the relevant `.struct.xml` files 
to the relevant `tagging-status/testfiles-...` directory of this repository (see the following paragraph). 
To this end, you can fork this repository.

Testfiles for packages that are compatible should be moved into the directory `testfiles-compatible`, 
those for partially compatible packages into the directory `testfiles-partial`. 
If your package only works with LuaTeX and testfiles for PDFTeX are hence not relevant, 
the testfiles should be placed into the directory `testfiles-compatible-luatex`.

Also add a relevant entry to the YAML file at `_data/tagging-status.yml` by following the instructions given in the header of this file.
 An entry should more or less adhere to the following template:
```yaml
- name: name
  type: package
  status: compatible
  tests: true
  updated: 2024-07-06
```

In this YAML template, change `name` to the name of the class or package 
and `type` to `class` or `package`. Change `tests` to the class or package name if you uploaded relevant test files. 
Change `status` to `compatible` or `partially-compatible` if your package is completely or at least partially compatible with tagging. 
Change `updated` to the current date.

If your package is only to be used wirh LuaTeX, set `tests: luatex`, 
otherwise, set `tests: true`. 
If your package is compatible and does not require testfiles, set `tests: false`.

Finally, push your changes and wait for the Team to inspect your test file and the accompanied XML file. 
You may be asked about specific implementation details and may need to explain your implementation decisions. 
You may also be asked to revise code to make your document class or package suitable for tagging support. 
You can change the code in the forked repository and push these changes to the existing Pull Request. 
The aim is to have one active Pull Request per class or package only. 
If all issues have been resolved (if any), your upload will eventually be accepted by merging and closing the Pull Request. 

## Keep track of changes

Please ensure that updates of your class or package that affect the output of the test files are reflected in the uploaded test files and the relevant XML files. 
You can do this by yourself by calling ` l3build check --show-saves <class or package name>-01` in your working directory to check the testfiles against the relevant XML files.
