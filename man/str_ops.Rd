% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/string_tools.R
\name{str_ops}
\alias{str_ops}
\title{Chains basic operations to character vectors}
\usage{
str_ops(x, op, pre_unik = NULL)
}
\arguments{
\item{x}{A character vector. If not a character vector but atomistic (i.e. not a list),
it will be converted to a character vector.}

\item{op}{Character \strong{scalar}. Character scalar containing the comma separated values
of operations to perform to the vector. The 50+ operations are detailed in the help
page of \code{\link[=smagick]{smagick()}}.}

\item{pre_unik}{Logical scalar, default is \code{NULL}. Whether to first unique the vector
before applying the possibly costly string operations, and merging back the result.
For very large vectors with repeated values the time gained can be substantial. By
default, this is \code{TRUE} for vector of length 1M or more.}
}
\value{
In general it returns a character vector. It may be of a length different from the original
one, depending on the operations performed.
}
\description{
Simple tool to perform multiple operations to character vectors.
}
\details{
This function is a simple wrapper around smagick. Formally, \code{str_ops(x, "op1, op2")}
is equivalent to \code{smagick("{op1, op2 ? x}")}.
}
\examples{

# data on car models
cars = row.names(mtcars)

# let's get the brands starting with an "m"
str_ops(cars, "'i/^m'get, x, unik")

# Explainer:
# 'i/^m'get: keeps only the elements starting with an m,
#            i/ is the 'regex-flag' "ignore" to ignore the case
#            ^m means "starts with an m" in regex language
# x: extracts the first pattern. The default pattern is "[[:alnum:]]+"
#    which means an alpha-numeric word
# unik: applies unique() to the vector
# => see help in ?smagick for more details on the operations


# let's get the 3 largest numbers appearing in the car models
str_ops(cars, "'\\\\d+'x, rm, unik, num, dsort, 3 first")

# Explainer:
# '\\d+'x: extracts the first pattern, the pattern meaning "a succession"
#          of digits in regex language
# rm: removes elements equal to the empty string (default behavior)
# unik: applies unique() to the vector
# num: converts to numeric
# dsort: sorts in decreasing order
# 3 first: keeps only the first three elements


}
\seealso{
A few basic operation: \code{\link[=str_is]{str_is()}}, \code{\link[=str_get]{str_get()}}, \code{\link[=str_clean]{str_clean()}}. Chain basic operations with \code{\link[=str_ops]{str_ops()}}.
Use \code{\link[=str_vec]{str_vec()}} to create simple string vectors.
String interpolation combined with operation chaining: \code{\link[=smagick]{smagick()}}.
}
\author{
Laurent R. Berge
}
