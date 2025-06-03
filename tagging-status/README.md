# Tagging Status

The status of LaTeX packages and classes with respect to tagging support.

The rendered HTML view of the data is available at [GitHub Pages](https://latex3.github.io/tagging-project/tagging-status).


To add or edit the entries, please make a pull request to change the YAML file
[tagging-status.yml](https://github.com/latex3/tagging-project/blob/main/_data/tagging-status.yml).

## Test files
The test files in this directory are separated into multiple categories, each containing TeX sources and
XML representation of structure trees in `.struct.xml` files.

 * `testfiles` have been manually inspected and are considered to accurately represent the document.
 * `testfiles-unknown` have not been verified yet.
 * `testfiles-broken` do not compile successfully or are generating invalid and/or misleading structure elements.
 * `testfiles-excluded` cause problems during compilation and have therefore been excluded from automated testing.

When moving files between these directories, please remember to update `tagging-status.yml` appropriately.
