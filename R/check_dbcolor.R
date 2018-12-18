check <- function(db, causative) {
  if (nrow(db) == 0L) {
    global_msg <- "You search does not seem to return any match"
    message <- sprintf("%s: Change the \"%s\" atributte and try again.",
                       global_msg, causative)
    stop(message)
  }
}


