#' raw2gdx
#'
#' Save to a GAMS gdx file. Works on a named list providing
#' domains and data as given by gdxrrw::rgdx.
#' This is a *workaround* to fix bugs in the implementation of gdxrrw::wgdx,
#' namely the problems that domains are lost when writing the output of gdxrrw:rgdx
#' and that for variables, a `_field` domain has always to be given.
#' Using this wrapper, round-tripping data between R and gdx files should be possible.
#' @param gdx the gdx filename.
#' @param var list of properties of a gdx symbol as provided by gdxrrw::rgdx.
#' @export
#' @examples
#' # round-trip
#' raw2gdx("gdxname.gdx", gdxrrw::rgdx("gdxname.gdx", list(name="symbolname"))

raw2gdx <- function(gdx, var){
    uels <- list()
    if (var$type == "variable" && var$field != "all"){
        ## create field dimension
        flds <- c("l", "m", "lo", "s")
        fld_idx <- match(var$field, flds)
        ## add it the matrix
        var$val <- cbind(var$val[, 1:var$dim], rep(fld_idx, nrow(var$val)), var$val[, var$dim + 1])
        ## add it to domains
        var$domains <- c(var$domains, "_field")
        ## add it to uels
        var$uels[[var$dim + 1]] <- flds
        ## field to all (required to write!)
        var$field <- "all"
    }
    for (n in 1:var$dim){
        uels[[n]] <- list(name=var$domains[[n]], type="set", uels=list(var$uels[[n]]))
    }
    gdxrrw::wgdx(gdx, var, uels)
}


#' dt2gdx
#'
#' Save a data.table to a GAMS gdx file.
#' @param gdx the gdx filename.
#' @param dt a data.table.
#' @param name name of the variable.
#' @param valcol name of data column.
#' @param uelcols vector of names with dimensions.
#' @param type type of symbol (variable or parameter)
#' @param field the field if `type == 'variable'`
#' @export
#' @examples
#' # round-trip:
#'

dt2gdx <- function(gdx, dt, name, valcol, uelcols, type="parameter", field="l"){
    data <- list(name=name, type=type, domains=uelcols, dim=length(uelcols))
    if(type == "variable"){
        data[["field"]] <- field
    }

    uels <- list()
    nuel <- 1

    cols <- c(uelcols, valcol)
    dt <- dt[, cols, with=F]

    for(uel in uelcols){
        labels <- unique(dt[[uel]])
        uels[[nuel]] <- labels

        map <- data.table(1:length(labels), labels)
        setnames(map, "labels", uel)

        dt <- dt[map, on=uel]
        dt[, (uel) := NULL]
        setnames(dt, "V1", uel)
        nuel <- nuel + 1
    }

    data[["val"]] <- unname(as.matrix(dt[, cols, with=F]))
    data[["uels"]] <- uels
    ## type code is "free":
    data[["typeCode"]] <- 5

    raw2gdx(gdx, data)
}
