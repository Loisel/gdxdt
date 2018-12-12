#' raw2gdx
#'
#' Save to a GAMS gdx file. Works on a named list providing
#' domains and data as given by gdxrrw::rgdx.
#' @param gdx the gdx filename.
#' @param var list of properties of a gdx symbol as provided by gdxrrw::rgdx.
#' @export
#' @examples
#' # round-trip:
#' raw2gdx("gdxname.gdx", gdxrrw::rgdx("gdxname.gdx", list(name="symbolname"))

raw2gdx <- function(gdx, var){
    uels <- list()
    ndim <- length(var$uels)
    # variables have a field dimension
    if(var$type == "variable")
        ndim <- ndim - 1
    for(n in 1:ndim){
        uels[[n]] <- list(name=var$domains[[n]], type="set", uels=list(var$uels[[n]]))
    }
    gdxrrw::wgdx(gdx, var, uels)
}
