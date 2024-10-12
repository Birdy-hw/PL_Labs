module FibStateful
(
FibState (..),
FibStateful,
getPreviousNumber,
setPreviousNumber,
getPreviousPreviousNumber,
setPreviousPreviousNumber,
getCurrentNumber,
setCurrentNumber,
) where

-- |The data type containing all the state that we need during our calculation
data FibState = FibState {
    previousNumber :: Integer,
    previousPreviousNumber :: Integer,
    currentNumber :: Integer
}

-- |A function that takes state and produces a new, updated state, along with its normal return value
type FibStateful a = FibState -> (FibState, a)

-- Getter and Setter Functions for the FibState:

getPreviousNumber :: FibStateful Integer
getPreviousNumber oldstate =
    (oldstate, previousNumber oldstate)

setPreviousNumber :: Integer -> FibStateful ()
setPreviousNumber newval oldstate =
    (FibState {previousNumber = newval,
               previousPreviousNumber = previousPreviousNumber oldstate,
               currentNumber = currentNumber oldstate}, ())

getPreviousPreviousNumber :: FibStateful Integer
getPreviousPreviousNumber oldstate =
    (oldstate, previousPreviousNumber oldstate)

setPreviousPreviousNumber :: Integer -> FibStateful ()
setPreviousPreviousNumber newval oldstate =
    (FibState {previousPreviousNumber = newval,
               previousNumber = previousNumber oldstate,
               currentNumber = currentNumber oldstate}, ())

getCurrentNumber :: FibStateful Integer
getCurrentNumber oldstate =
    (oldstate, currentNumber oldstate)

setCurrentNumber :: Integer -> FibStateful ()
setCurrentNumber newval oldstate =
    (FibState {currentNumber = newval,
               previousPreviousNumber = previousPreviousNumber oldstate,
               previousNumber = previousNumber oldstate}, ())
