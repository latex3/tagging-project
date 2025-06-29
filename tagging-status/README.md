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

## Categorising
Currently most testfiles are on `testfiles-unknown` and need to be categorized.
To move a test into another category, follow the following three step process:

1. Look at the `.struct.xml` file and compare it with the `.tex` file's content. If the file looks correct and represents the content of the `.tex` document, then the test can be moved into the `testfiles` directory. Otherwise it should go into `testfiles-broken`.
 If you are unsure, keep the test in `testfiles-unknown` for now.
2. Move both the testfiles ending with `.tex` and the reference file ending with `.struct.xml` into the chosen new testfiles directory. You might have to create a new directory for the package.
3. If you are removing the last test for a package from `testfiles-unknown` (so if the directory of the package is empty afterwards), remove the directory and update the package entry in ../_data/tagging-status.yml:
  See if any tests for the package are classified as `testfiles-broken` and if any are classified as `testfiles`. If both are present, change the line `tests: unknown` to `tests: partially-broken`. If only `testfiles-broken` contains tests for the package, change the line to `tests: broken`. If only `testfiles` contains tests, set it to `tests: okay`.
