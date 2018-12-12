#' years_as_numbers
#'
#' Specific to data provided by the REMIND IAM.
#' Coerces values in "time-like" columns in a data.table to numbers.
#' The provided data.table is modified *in-place*.
#' @param table a data.table.
#' @return a data.table
#' @export
#' @examples
#' years_as_numbers(table)

years_as_numbers <- function(table){
    time_cols <- c("ttot", "tall")
    for(col in time_cols){
        if(col %in% colnames(table)){
            table[, (col) := as.numeric(get(col))]
        }
    }
}

#' dtsample
#'
#' Sample a data.table.
#' @param table a data.table.
#' @param size sample size.
#' @return a data.table of length `size`.
#' @export
#' @examples
#' dtsample(table, 10)

dtsample <- function(table, size=10){
    table[sample(.N, size)]
}

