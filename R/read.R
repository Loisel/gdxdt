#' raw2dt
#'
#' Provided the raw output from gdxrrw::rgdx, create a data.table
#' with the correct UEL dimensions.
#' @param full_data a list as given by gdxrrw::rgdx.
#' @return a data.table
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
    if(full_data$type %in% c("parameter", "variable")){
        data.table::setnames(data, paste0("V", length(domains) + 1), "value")
    }
    return(data)
}

#' readgdx
#'
#' Read a variable, parameter or set from a gdx file to a data.table.
#' @param fname the gdx filename.
#' @param varname name of the object to load.
#' @param field (for variable), select a field (default="l").
#' @return a data.table
#' @export
#' @examples
#' dt <- as.data.table(mtcars, keep.rownames = T)
#' writegdx(test_gdx, dt, test_var, valcol="wt", uelcols="rn", type="parameter")
#' new_dt <- readgdx(test_gdx, test_var, type="parameter")

readgdx <- function(fname, varname, field=NULL){
    raw2dt(gdxrrw::rgdx(fname, list(name=varname, field=field)))
}
