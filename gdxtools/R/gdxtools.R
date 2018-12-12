require(gdx)
require(data.table)

readVariable <- function(fname, varname, field="l"){
    raw2dt(rgdx(fname, list(name=varname, field=field)))
}

readParameter <- function(fname, parname){
    raw2dt(rgdx(fname, list(name=parname)))
}

raw2dt <- function(full_data){
    domains <- full_data$domains
    data <- as.data.table(full_data$val)

    for(n in 1:length(domains)){
        name = domains[n]
        valname = paste0("V", n)
        data[, (name) := full_data$uels[[n]][get(valname)]]
        data[, (valname) := NULL]
    }
    setnames(data, paste0("V", length(domains) + 1), "value")
    return(data)
}

years_as_numbers <- function(table){
    time_cols <- c("ttot", "tall")
    for(col in time_cols){
        if(col %in% colnames(table)){
            table[, (col) := as.numeric(get(col))]
        }
    }
}

dtsample <- function(table){
    table[sample(.N, 10)]
}

save2gdx <- function(gdx, var){
    uels <- list()
    ndim <- length(var$uels)
    # variables have a field dimension
    if(var$type == "variable")
        ndim <- ndim - 1
    for(n in 1:ndim){
        uels[[n]] <- list(name=var$domains[[n]], type="set", uels=list(var$uels[[n]]))
    }
    wgdx(gdx, var, uels)
}
