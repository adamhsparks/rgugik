# skip test on GitHub
if (!"GITHUB_ACTION" %in% names(Sys.getenv())) {

  library(sf)

  polygon_path = system.file("datasets/search_area.gpkg", package = "rgugik")
  polygon = read_sf(polygon_path)
  req_df = orto_request(polygon)

  # if output is "connection error", check class and return NULL
  if (class(req_df) == "character") {
    return(NULL)
  }


  test_that("check if ouput is data frame", {
    expect_s3_class(req_df, "data.frame")
  })

  test_that("check number of rows", {
    expect_true(nrow(req_df) > 0)
  })

  test_that("check number of columns", {
    expect_true(ncol(req_df) == 12)
  })

}
