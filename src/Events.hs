module Events
    (
      Event(InitGame, Invalid),
      nextState
    ) where

import qualified Models.ParseResult as PR

data Event = InitGame | Invalid
  deriving (Show)

nextState :: PR.ParseResult -> Event -> PR.ParseResult
nextState parseResult InitGame = PR.addGame parseResult
nextState parseResult _        = parseResult
