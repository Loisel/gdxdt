context("test-read")

gdx <- "fulldata.gdx"

test_that("reading a parameter works", {
    dt <- read_parameter(gdx, "pm_welf")
    expect_is(dt, "data.table")
    expect_gt(length(dt), 0)
})

test_that("reading a variable works", {
    dt <- read_variable(gdx, "v_welfare", "l")
    expect_is(dt, "data.table")
    expect_gt(length(dt), 0)
})

test_that("round-trip of a variable works", {
    test_gdx <- "test.gdx"
    test_var <- "v_welfare"
    raw2gdx(test_gdx, rgdx(gdx, list(name=test_var, field="all")))
    dt <- read_variable(test_gdx, test_var, "l")
    expect_is(dt, "data.table")
    expect_gt(length(dt), 0)
    file.remove(test_gdx)
})
