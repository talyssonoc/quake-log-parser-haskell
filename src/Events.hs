module Events
    (
      Event(InitGame, Invalid),
      nextState
    ) where

import qualified Models.ParseResult as PR

data Event = InitGame | Invalid

nextState :: Event -> PR.ParseResult -> PR.ParseResult
nextState InitGame parseResult = PR.addGame(parseResult)
nextState _ parseResult        = parseResult
