module Models.TimeStamp
    (
      TimeStamp(..)
    ) where

newtype TimeStamp = TimeStamp (Int, Int)
  deriving (Show)
