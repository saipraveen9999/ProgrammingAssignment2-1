## These two functions allow the caching of the inverse of a matrix, which can then be used (if
## it exists), instead of calling the solve function again (which is what gives you the inverse)

## This function creates a list that will hold the 4 functions (set, get, setinverse and 
## getinverse) and then returns this list

makeCacheMatrix <- function(x = matrix()) {
    ## Set the cached value to Null, so that the scope of i remains in the function (and doesn't)
    ## go to the global environment).
    cachedI <- NULL
    ## This function sets x (the matrix) and i (the cached inverse), but so that they exist
    ## in the parent environment
    set <- function(y) {
        x <<- y
        cachedI <<- NULL
    }
    ## This function returns the matrix
    get <- function() x
    ## This function stores the inputted value of inverse into the cached version.
    setCachedInverse <- function(inverse) cachedI <<- inverse
    ## This function returns the cached value for the inverse, in the context of the current
    ## environment.
    getCachedInverse <- function() cachedI
    list(set = set, get = get,
         setCachedInverse = setCachedInverse,
         getCachedInverse = getCachedInverse)
}


## This function returns the inverse of x, either by returning the cached version (if it exists)
## or by cacluating it (using solve) and returning it (and caching it in the process). This 
## assumes that the given matrix is invertible.

cacheSolve <- function(x, ...) {
    ## Get the cached inverse
    i <- x$getCachedInverse()
    ## If there was a value in the cached, tell the user and return it.
    if(!is.null(i)) {
        message("getting cached data")
        return(i)
    }
    ## Otherwise, get the matrix and run solve on it. Then, set the cached inverse to that value, 
    ## and return it.
    data <- x$get()
    i <- solve(data, ...)
    x$setCachedInverse(i)
    i
}
