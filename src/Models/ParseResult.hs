module Models.ParseResult
    (
      ParseResult(ParseResult),
      initialValue,
      addGame
    ) where

import qualified Models.Game as G

data ParseResult = ParseResult [G.Game] Integer
  deriving (Show)

initialValue :: ParseResult
initialValue = ParseResult [] 0

addGame :: ParseResult -> ParseResult
addGame (ParseResult games currentGameId) = ParseResult (games ++ [G.newGame]) (currentGameId + 1)
