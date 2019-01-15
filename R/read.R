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

#' readVariable
#'
#' Read a variable from a gdx file.
#' @param fname the gdx filename.
#' @param varname name of the variable to load.
#' @param field select a field or use "all".
#' @return a data.table
#' @export
#' @examples
#' readVariable("fulldata.gdx", "v35_shEsPeT", "l")

read_variable <- function(fname, varname, field="l"){
    raw2dt(gdxrrw::rgdx(fname, list(name=varname, field=field)))
}

#' readParameter
#'
#' Read a parameter from a gdx file.
#' @param fname the gdx filename.
#' @param varname name of the variable to load.
#' @return a data.table
#' @export
#' @examples
#' readParameter("gdxname.gdx", "parameter_name")

read_parameter <- function(fname, parname){
    raw2dt(gdxrrw::rgdx(fname, list(name=parname)))
}
