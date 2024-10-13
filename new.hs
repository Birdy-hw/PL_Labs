import FibStateful

-- | fib function that uses FibStateful to calculate Fibonacci efficiently
fib :: Int -> FibStateful Integer
fib 0 oldState = (oldState, 0)
fib 1 oldState = (oldState, 1)
fib n oldState = 
    let (newState1, fib1) = getPreviousNumber oldState
        (newState2, fib2) = getPreviousPreviousNumber oldState
        newFib = fib1 + fib2
        (newState3, _) = setPreviousPreviousNumber fib1 newState2
        (finalState, _) = setPreviousNumber newFib newState3
    in (finalState, newFib)

-- | fibHelper is a helper function that starts with the initial state
fibHelper :: Int -> FibState -> (FibState, Integer)
fibHelper n initialState = fib n initialState

-- | The main function that sets up the initial state and prints the result of fib
main :: IO ()
main = do
    let initialState = FibState { previousNumber = 1, previousPreviousNumber = 0, currentNumber = 0 }
    let (finalState, result) = fibHelper 50 initialState
    print result
