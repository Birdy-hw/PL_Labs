import Control.Monad.State -- importing the Monad State module

fibAux :: Int -> State (Integer, Integer) Integer -- initialising a fibonacci auxiliary function
fibAux 0 = do -- if n == 0 then we want to return the first entry of state which will be the answer
  (a, _) <- get
  return a
fibAux n = do -- while n>0 
    (a, b) <- get -- we get the current state (x, x+1) where x is a fibonacci number
    put (b, a + b) -- we update the state using put to (x+1,x+x+1)
    fibAux (n - 1) -- we recursively call the function while decrementing n

fib :: Int -> Integer -- fibonacci function that takes an integer n and returns the answer as an integer
fib n = evalState (fibAux n) (0, 1) -- setting initial state to (0,1) for first 2 elements
    
main :: IO ()
main = do
    putStr("The fibonacci of 100 is: ")
    print $ fib 100