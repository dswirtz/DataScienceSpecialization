## The focus of this assignment is to write R functions that cache
## potentially time-consuming computations. In this case, the inverse of 
## a matrix is being cached, so that it won't have to be computed everytime
## For this assignment, assume the matrix supplied is always invertible.

## The first function, makeCacheMatrix, creates a list containing a 
## function to:
## 1. set the value of the matrix
## 2. get the value of the matrix
## 3. set the value of the inverse
## 4. get the value of the inverse

makeCacheMatrix <- function(x = matrix()) {
        inv <- NULL
        set <- function(y){
                x <<- y
                inv <<- NULL
        }
        get <- function() x
        setinverse <- function(inverse) inv <<- inverse
        getinverse <- function() inv
        list(set = set, get = get,
             setinverse = setinverse,
             getinverse = getinverse)
}


## The second function, cacheSolve, returns the inverse of the matrix. However,
## it first checks to see if the inverse has already been calculated. If so,
## the function gets the result from the cache and skips the computation. If
## not, it computes the inverse, and sets the value in the cache via the 
## setinverse function.

cacheSolve <- function(x, ...) {
        inv <- x$getinverse()
        if(!is.null(inv)){
                message("getting cached data...")
                return(inv)
        }
        data <- x$get()
        inv <- solve(data)
        x$setinverse(inv)
        inv
}
