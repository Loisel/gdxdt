## Test environments
* local ubuntu 18.04, R 3.6.1
* win-builder (devel and release)

## R CMD check results
There were no ERRORs or WARNINGs.

There were 2 NOTEs:

* checking CRAN incoming feasibility ... NOTE
  ```
  Maintainer: ‘Alois Dirnaichner <alodi@directbox.com>’

  New submission

  Suggests or Enhances not in mainstream repositories:
	gdxrrw
  ```
  For details on the `gdxrrw` package, see below.

* checking package dependencies ... NOTE
  Package suggested but not available for checking: 'gdxrrw'

  While listed as a suggestion, this package actually *depends* on the gdxrrw package, which is not available on CRAN.

  The package is available from the GAMS wiki:
  https://support.gams.com/doku.php?id=gdxrrw:interfacing_gams_and_r

  This is also the reason for the `dontrun` directives in the examples.

## Downstream dependencies
There are currently no downstream dependencies for this package.
