is_url <- function(path) {
  grepl("^((http|ftp)s?|sftp)://", path)
}
