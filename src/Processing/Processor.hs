module Processing.Processor
    (
      process
    ) where

import           Events
import           Models.ParseResult as PS

process :: [Events.Event] -> PS.ParseResult
process = foldl nextState initialValue

nextState :: PS.ParseResult -> Event -> PS.ParseResult
nextState parseResult InitGame = PS.addGame parseResult
nextState parseResult (ClientConnect playerId) = PS.addPlayer playerId parseResult
nextState parseResult (ClientUserinfoChanged playerInfo) = PS.updatePlayerName playerInfo parseResult
nextState parseResult (ClientDisconnect playerId) = PS.removePlayer playerId parseResult
nextState parseResult _        = parseResult
