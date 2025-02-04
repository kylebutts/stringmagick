% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/smagick_main.R
\name{setSmagick}
\alias{setSmagick}
\title{Set defaults for smagick}
\usage{
setSmagick(
  .smagick.class = FALSE,
  .delim = c("{", "}"),
  .sep = "",
  .data.table = TRUE,
  reset = FALSE
)
}
\arguments{
\item{.delim}{Character vector of length 1 or 2. Default is \code{c("{", "}")}. Defines
the opening and the closing delimiters for interpolation.

If of length 1, it must be of the form: 1) the opening delimiter,
2) a single space, 3) the closing delimiter. Ex: \code{".[ ]"} is equivalent to \code{c(".[", "]")}.
The default value is equivalent to \code{"{ }"}.

[ ]: R:\%20
[", "]: R:\%22,\%20\%22}

\item{.sep}{Character scalar, default is the empty string \code{""}. It is used to collapse all
the elements in \code{...} before applying any operation.}

\item{.data.table}{Logical, default is \code{TRUE}. If you use \code{smagick} in a \code{data.table} call
and interpolate variables within the \code{data.table}, you want this argument to be \code{TRUE}.
It only incurs a small overhead.}

\item{reset}{Logical scalar, default is \code{FALSE}. Whether to reset all values.}
}
\description{
Se the default values for a few arguments of the function \code{\link[=smagick]{smagick()}}.
}
\details{
By default, each call to \code{setSmagick} adds modifications to the default values.
To set a few default values and resetting the others, you need to use \code{reset = TRUE}.
}
\examples{

# we change the default display of the results of smagick
setSmagick(.smagick.class = TRUE)
smagick("{S!x, y}{2 each?1:2}")

# back to a regular character vector
setSmagick(reset = TRUE)
smagick("{S!x, y}{2 each?1:2}")

}
\author{
Laurent Berge
}
