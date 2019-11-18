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

  License components with restrictions and base license permitting such:
	MIT + file LICENCE
  File 'LICENCE':
	MIT License

	Copyright (c) 2019 Alois Dirnaichner

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.

  Suggests or Enhances not in mainstream repositories:
	gdxrrw

  The Title field should be in title case. Current version is:
  ‘IO for GAMS GDX Files using data.table’
  In title case that is:
  ‘IO for GAMS GDX Files using Data.table’
  ```
  The last part of the note refers to the `data.table` package mentioned in the package title which is not consistent with title case. For details on the `gdxrrw` package, see below.

* checking package dependencies ... NOTE
  Package suggested but not available for checking: 'gdxrrw'

  While listed as a suggestion, this package actually *depends* on the gdxrrw package, which is not available on CRAN.

  The package is available from the GAMS wiki:
  https://support.gams.com/doku.php?id=gdxrrw:interfacing_gams_and_r

  This is also the reason for the `dontrun` directives in the examples.

## Downstream dependencies
There are currently no downstream dependencies for this package.
