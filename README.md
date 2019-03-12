# gdxtools
Read/Write utilities for GAMS gdx files. Using R's data.table.

Requires GAMS `gdxrrw` library.

## Install
```
require(devtools)
install_github("loisel/gdxtools")
```

## Usage

Read parameter:
```
read_parameter("filename.gdx", "parameter")
```

Read variables (level):
```
read_variable("filename.gdx", "variable")
```

Write parameter:
```
dt <- data.table(col1=c("a", "b", "c"),
				 col2=c("d", "e", "f"))
dt[, value:=runif(1), by="col1"]

dt2gdx("test.gdx", dt,
	name="test",
	valcol = "value",
	uelcols = c("col1", "col2"),
	type="parameter")
```

Write variable:
```
dt <- data.table(col1=c("a", "b", "c"),
				 col2=c("d", "e", "f"))
dt[, value:=runif(1), by="col1"]

dt2gdx("test.gdx", dt,
	name="test",
	valcol = "value",
	uelcols = c("col1", "col2"),
	type="variable",
	field="l")
```
