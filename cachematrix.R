## This function computes the inverse of a matrix and caches the result

## Cache the matrix for use later

makeCacheMatrix <- function(x = matrix()) {
        i <- NULL
        set <- function(y){
                x <<- y
                m <<- NULL
        }
        get <- function() x
        setinv <- function(inv) i <<- inverse
        getinv <- function() i
        list(set = set, get = get, setinv = setinv, getinv = getinv)
}


## calculate the inverse of a matrix and cache result

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
        i <- x$getinv()
        if(!is.null(i)){
                message("getting cached data")
                return(i)
        }
        data <- x$get()
        i <- solve(data, ...)
        x$setinv(i)
        i
}
