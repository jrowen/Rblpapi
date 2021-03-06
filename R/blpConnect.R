##' This function connects to the Bloomberg API
##'
##' @title Establish connection to Bloomberg service
##' @param port An integer variable with the connection port. Default
##' to \code{8194L}.
##' @param default A logical indicating whether this connection should
##' be saved as the default, as opposed to returned to the
##' user. Default to \code{TRUE}.
##' @param host A character option with either a machine name that is
##' resolvable by DNS, or an IP address. Defaults to
##' \sQuote{localhost}.
##' @return In the \code{default=TRUE} case nothing is returned, and
##' this connection is automatically used for all future calls which
##' omit the \code{con} argument. Otherwise a connection object is
##' returned which is required by all the accessor functions in the
##' package.
##' @details For both \code{host} and \code{port} argument, default
##' values can also be specified via \code{\link{options}} using,
##' respectively, the named entries \code{blpHost} and
##' \code{blpConnect}.
##'
##' If an additional option \code{blpAutoConnect} is set to
##' \sQuote{TRUE}, a connection is established in the
##' \code{.onAttach()} function and stored in the package
##' environment. This effectively frees users from having to
##' explicitly create such an object.
##' @author Whit Armstrong and Dirk Eddelbuettel
##' @examples
##' \dontrun{
##'   con <- blpConnect()   # adjust as needed
##' }
blpConnect <- function(host=getOption("blpHost", "localhost"),
                       port=getOption("blpPort", 8194L),
                       default=TRUE) {
    if (storage.mode(port) != "integer") port <- as.integer(port)
    if (storage.mode(host) != "character") stop("Host argument must be character.", call.=FALSE)
    con <- blpConnect_Impl(host, port)

    if (default) .pkgenv$con <- con else return(con)
}
