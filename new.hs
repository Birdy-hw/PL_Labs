import Control.Monad.State

fibAux :: Int -> State (Integer, Integer) Integer
fibAux 0 = do
  (a, _) <- get
  return a
fibAux n = do
    (a, b) <- get
    put (b, a + b)
    fibAux (n - 1)

fib :: Int -> Integer
fib n = evalState (fibAux n) (0, 1)
    
main :: IO ()
main = do
    putStr("The fibonacci of 100 is: ")
    print $ fib 100
