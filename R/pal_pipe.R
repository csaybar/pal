simple_pipe <- function(left , rigth) {
  left_name <- deparse(substitute(left))
  rigth_name <- deparse(substitute(rigth))
  exp_name <- sprintf('%s %s %s', left_name, '%>%', rigth_name)
  eval(parse(text = exp_name))
}

'+' <- `simple_pipe`


