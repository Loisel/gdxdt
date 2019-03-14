#' raw2dt
#'
#' Provided the raw output from gdxrrw::rgdx, create a data.table
#' with the correct UEL dimensions.
#' @param full_data a list as given by gdxrrw::rgdx.
#' @return a data.table
#' @export
#' @examples
#' data <- rgdx("gdxname.gdx", (name="symname"))
#' table <- raw2dt(data)

raw2dt <- function(full_data){
    domains <- full_data$domains
    data <- data.table::data.table(full_data$val)

    for(n in 1:length(domains)){
        valname <- paste0("V", n)
        data[, (n) := full_data$uels[[n]][get(valname)]]
    }
    data.table::setnames(data, paste0("V", 1:length(domains)), domains)
    data.table::setnames(data, paste0("V", length(domains) + 1), "value")
    return(data)
}

#' readgdx
#'
#' Read a variable or parameter from a gdx file.
#' @param fname the gdx filename.
#' @param varname name of the variable or parameter to load.
#' @param type string: "variable" or "parameter".
#' @param field if type == variable, select a field (default="l") or use "all".
#' @return a data.table
#' @export
#' @examples
#' dt <- as.data.table(mtcars, keep.rownames = T)
#' writegdx(test_gdx, dt, test_var, valcol="wt", uelcols="rn", type="parameter")
#' new_dt <- readgdx(test_gdx, test_var, type="parameter")

readgdx <- function(fname, varname, type="variable", field="l"){
    if(type == "variable"){
        raw2dt(gdxrrw::rgdx(fname, list(name=varname, field=field)))
    }else if(type == "parameter"){
        raw2dt(gdxrrw::rgdx(fname, list(name=varname)))
    }else{
        stop("Please provide the object type, 'variable' or 'parameter'.")
    }
}

#' readgdx.variable
#'
#' Read a variable from a gdx file.
#' @param fname the gdx filename.
#' @param varname name of the variable to load.
#' @param field select a field or use "all".
#' @return a data.table
#' @export
#' @examples
#' dt <- as.data.table(mtcars, keep.rownames = T)
#' writegdx.variable(test_gdx, dt, test_var, valcol="wt", uelcols="rn")
#' new_dt <- readgdx.variable(test_gdx, test_var)

readgdx.variable <- function(fname, varname, field="l"){
    raw2dt(gdxrrw::rgdx(fname, list(name=varname, field=field)))
}

#' readgdx.parameter
#'
#' Read a parameter from a gdx file.
#' @param fname the gdx filename.
#' @param varname name of the variable to load.
#' @return a data.table
#' @export
#' @examples
#' dt <- as.data.table(mtcars, keep.rownames = T)
#' writegdx.parameter(test_gdx, dt, test_var, valcol="wt", uelcols="rn")
#' new_dt <- readgdx.parameter(test_gdx, test_var)

readgdx.parameter <- function(fname, parname){
    raw2dt(gdxrrw::rgdx(fname, list(name=parname)))
}
