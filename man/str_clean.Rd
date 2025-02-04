% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/string_tools.R
\name{str_clean}
\alias{str_clean}
\title{Cleans a character vector from multiple patterns}
\usage{
str_clean(
  x,
  ...,
  replacement = "",
  pipe = " => ",
  sep = ",[ \\n\\t]+",
  ignore.case = FALSE,
  fixed = FALSE,
  word = FALSE,
  total = FALSE,
  single = FALSE,
  envir = parent.frame()
)
}
\arguments{
\item{x}{A character vector.}

\item{...}{Character scalars representing patterns. A pattern is of the form
"flags/pat1, pat2 => replacement". This means that patterns 'pat1' and 'pat2' will be replaced
with the string 'replacement'. By default patterns are comma separated and the replacement comes
after a ' => ' (see args \code{sep} and \code{pipe} to change this). By default the replacement is the empty string
(so "pat1, pat2" \emph{removes} the patterns).

Available flags are: 'word' (add word boundaries), 'ignore' (the case), 'fixed' (no regex),
'total', 'single' and 'magic'.
The flag \code{total} leads to a \emph{total replacement} of the string if the pattern is found.
The flag 'magic' allows to interpolate variables within the pattern.  Use flags
with comma separation ("word, total/pat") or use only their initials ("wt/pat").

Starting with an '@' leads to operations in \code{\link[=str_ops]{str_ops()}}. Ex: "@ascii, lower, ws" turns
the string into ASCII, lowers the case and normalizes white spaces (see help of \code{\link[=str_ops]{str_ops()}}).}

\item{replacement}{Character scalar, default is the empty string. It represents the default
value by which the patterns found in the character strings will be replaced. For example
\code{str_clean(x, "e", replacement = "a")} turn all letters "e" in \code{x} into "a".}

\item{pipe}{Character scalar, default is \code{" => "}. If thevalue of \code{pipe} is found in a pattern,
then the string is split w.r.t. the pipe and anything after the pipe becomes the replacement.

For example in \code{str_clean(x, "e => a")} the default pipe is found in "e => a", so the pattern
"e" will be replaced with "a". In other terms, this is equivalent to \code{str_clean(x, "e", replacement = "a")}.
Example changing the pipe: you can obtain the previous result with \code{str_clean(x, "e|>a", pipe = "|>")}.}

\item{sep}{Character scalar, default is \code{",[ \\t\\n]+"} (which means a comma followed with spaces
and/or new lines). By default the patterns to be replaced are comma separated, that is
the pattern is split w.r.t. the argument \code{sep} and a replacement is done for each sub-pattern.

Use \code{NULL} or the empty string to disable pattern separation.

For example: let's look at \code{str_clean(x, "w/one, two => three")}. First the flag "word" is extracted from
the pattern (see arg. \code{...}) as well as the replacement (see arg. \code{pipe}), leading to "one, two" the
pattern to be replaced. Then the pattern is split w.r.t. \code{sep}, leading
to two patterns "one" and "two". Hence the words (thanks to the flag "w") "one" and "two" from
the string \code{x} will be replaced with "three".}

\item{ignore.case}{Logical scalar, default is \code{FALSE}. If \code{TRUE}, then case insensitive search is triggered.}

\item{fixed}{Logical scalar, default is \code{FALSE}. Whether to trigger a fixed search instead of a
regular expression search (default).}

\item{word}{Logical scalar, default is \code{FALSE}. If \code{TRUE} then a) word boundaries are added to the pattern,
and b) patterns can be chained by separating them with a comma, they are combined with an OR logical operation.
Example: if \code{word = TRUE}, then pattern = "The, mountain" will select strings containing either the word
'The' or the word 'mountain'.}

\item{total}{Logical scalar, default is \code{FALSE}. If \code{TRUE}, then when a pattern is found
in a string, the full string is replaced (instead of just the pattern). Note, \emph{importantly},
that when \code{total = TRUE} you can use logical operators in the patterns.}

\item{single}{Logical scalar, default is \code{FALSE}. Whether, in substitutions, to stop at
the first match found. Ex: \code{str_clean("abc", "[[:alpha:]] => _", single = TRUE)} leads
to \code{"_bc"}, while \code{str_clean("abc", "[[:alpha:]] => _")} leads to \code{"___"}.

Example: \code{str_clean(x, "wi/ & two, three & !four => ", total = TRUE)}}
}
\value{
The main usage returns a character vector of the same length as the vector in input.
Note, however, that since you can apply arbitrary \code{\link[=str_ops]{str_ops()}} operations, the length and type
of the final vector may depend on those (if they are used).
}
\description{
Recursively cleans a character vector from several patterns. Quickly handle the
tedious task of data cleaning by taking advantage of the syntax.
You can also apply all sorts of cleaning operations by summoning \code{\link[=str_ops]{str_ops()}} operations.
}
\section{Regular expression flags specific to replacement}{


This function benefits from two specific regex flags: "total" and "single".
\itemize{
\item "total" replaces the \emph{complete string} if the pattern is found (remember that the
default behavior is to replace just the pattern).
\item "single" performs a single substitution for each string element and stops there.
Only the first match of each string is replaced. Technically we use \code{\link[base:grep]{base::sub()}}
internally instead of \code{\link[base:grep]{base::gsub()}}.
}
}

\section{Generic regular expression flags}{


All \code{stringmagick} functions support generic flags in regular-expression patterns.
The flags are useful to quickly give extra instructions, similarly to \emph{usual}
\href{https://javascript.info/regexp-introduction}{regular expression flags}.

Here the syntax is "flag1, flag2/pattern". That is: flags are a comma separated list of flag-names
separated from the pattern with a slash (\code{/}). Example: \code{str_which(c("hello...", "world"), "fixed/.")} returns \code{1}.
Here the flag "fixed" removes the regular expression meaning of "." which would have otherwise meant \emph{"any character"}.
The no-flag verion \code{str_which(c("hello...", "world"), ".")} returns \code{1:2}.

Alternatively, and this is recommended, you can collate the initials of the flags instead of using a
comma separated list. For example: "if/dt[" will apply the flags "ignore" and "fixed" to the pattern "dt[".

The four flags always available are: "ignore", "fixed", "word" and "magic".
\itemize{
\item "ignore" instructs to ignore the case. Technically, it adds the perl-flag "(?i)"
at the beginning of the pattern.
\item "fixed" removes the regular expression interpretation, so that the characters ".", "$", "^", "["
(among others) lose their special meaning and are treated for what they are: simple characters.
\item "word" adds word boundaries (\code{"\\\\b"} in regex language) to the pattern. Further, the comma (\code{","})
becomes a word separator. Technically, "word/one, two" is treated as "\\b(one|two)\\b". Example:
\code{str_clean("Am I ambushed?", "wi/am")} leads to " I ambushed?" thanks to the flags "ignore" and "word".
\item "magic" allows to interpolate variables inside the pattern before regex interpretation.
For example if \code{letters = "aiou"} then \code{str_clean("My great goose!", "magic/[{letters}] => e")}
leads to \code{"My greet geese!"}
}
}

\examples{

x = c("hello world  ", "it's 5 am....")

# we clean the o's and the points (we use 'fixed' to trigger fixed-search)
str_clean(x, "o", "f/.")
# equivalently
str_clean(x, "fixed/o, .")
# equivalently
str_clean(x, "o, .", fixed = TRUE)
# equivalently
str_clean(x, "o", ".", fixed = TRUE)

#
# chaining operations: example using cars
#

cars = row.names(mtcars)
new = str_clean(cars, 
           # replace strings containing "Maz" with Mazda
           "total/Maz => Mazda", 
           # replace the word 'Merc' with Mercedes
           "wi/merc => Mercedes",
           # replace strings containing "Merc" and a digit followed with an 'S'
           "t/Merc & \\\\dS => Mercedes S!",
           # put to lower case, remove isolated characters and normalize white spaces
           "@lower, ws.isolated")

cbind(cars, new)


}
\seealso{
A few basic operation: \code{\link[=str_is]{str_is()}}, \code{\link[=str_get]{str_get()}}, \code{\link[=str_clean]{str_clean()}}. Chain basic operations with \code{\link[=str_ops]{str_ops()}}.
Use \code{\link[=str_vec]{str_vec()}} to create simple string vectors.
String interpolation combined with operation chaining: \code{\link[=smagick]{smagick()}}.
}
\author{
Laurent R. Berge
}
