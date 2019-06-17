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
nextState parseResult (ClientUserinfoChanged playerName playerId) = PS.updatePlayerName playerName playerId parseResult
nextState parseResult (ClientDisconnect playerId) = PS.removePlayer playerId parseResult
nextState parseResult (Item time itemName playerId) = PS.addItemToPlayer time itemName playerId parseResult
nextState parseResult _        = parseResult
