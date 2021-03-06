% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pal_pipe.R
\name{\%>\%}
\alias{\%>\%}
\title{Add components to a pal_search()}
\usage{
lhs \%>\% rhs
}
\arguments{
\item{left}{A pal object.}

\item{rigth}{A pal_search method.}
}
\description{
Based on the semantics that proposes the R packages 'magrittr'
we use \code{\%>\%} for constructing sophisticated searchings. It allows
you to start simple, then get more and more complex search,
checking your work at each step. Visit the website of
\href{https://magrittr.tidyverse.org/}{magrittr} for get more
information about %>%.
}
\examples{

pal_search() \%>\%
 pal_plot(return = 5, plotly = FALSE)
}
