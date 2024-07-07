.onLoad <- function(libname, pkgname) {
  read_symbol_map <<- memoise::memoise(read_symbol_map)
  read_symbol_to_id_map <<- memoise::memoise(read_symbol_to_id_map)
}
