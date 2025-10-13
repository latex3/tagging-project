# Adding the tagging status of your LaTeX class or package to this repository

If you want to contribute to this repository by adding the tagging status of your LaTeX class or package, please follow the below steps.

## Test your document class or package locally

To check the tagging support of your document class or package, write a test file that contains as many typical uses of your class or package that are relevant for tagging. A test file for a document class can be a short example document. As packages have quite diverse functions, it is difficult to come up with a general idea of what a test file for a package should contain. If unsure, browse the test files that already exist in this repository to get an idea. 

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

Store this test file in a subdirectory of your working directory where you store the document class or package file (the `.cls` or `.sty` file) with the path `testfiles/<class or package name>/<class or package name>-01.tex`. You can create more than one test files with appropriate numbering of the names.

Compile the test file and check the output using software such as PAC or VeraPDF to ensure that the tagging structure is correct. Use a screen reader such as NVDA to ensure that the alternative representation of the contents is as intended and semantically correct.

Run `l3build save <class or package name>-01.tex` in your working directory to create an XML file named `<class or package name>-01.struct.xml` in the `testfiles/<class or package name>/` subdirectory. Check the contents of this file as well. This file shows a combination of tagging, structure and alternative representations which can also help you to check the tagging support of your class or package. This file will also serve as test file against which the tagging status of your class or package is later checked against.  

## Add your test files to this repository

If you are confident that the tagging structure of your document class or package is fine, you can create a Pull Request to this repository to upload your testfiles and the relevant `.struct.xml` files to the `tagging-status/testfiles` directory of this repository. To this end, you can fork this repository.

Also add a relevant entry to the YAML file at `_data/tagging-status.yml` by following the instructions given in the header of this file. An entry should adhere to the following template:

```yaml
- name: name
  type: package
  status: unknown
  tests: false
  updated: 2024-07-06
```
In this template, change `name` to the name of the class or package and `type` to `class` or `package`. Change `tests` to the class or package name if you uploaded relevant test files. Change `status` to `compatible` or `partially-compatible` if your package is completely or at least partially compatible with tagging. Change `updated` to the current date.

Finally, push your changes and wait for the Team to inspect your test file and the accompanied XML file. You may be asked about specific implementation details and may need to explain your implementation decisions. You may also be asked to revise code to make your document class or package suitable for tagging support. You can change the code in the forked repository and push these changes to the existing Pull Request. The aim is to have one active Pull Request per class or package only. If all issues have been resolved (if any), your upload will eventually be accepted by merging and closing the Pull Request. 

## Keep track of changes

Please ensure that updates of your class or package that affect the output of the test files are reflected in the uploaded test files and the relevant XML files.
