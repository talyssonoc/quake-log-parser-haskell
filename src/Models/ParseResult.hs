module Models.ParseResult
    (
      ParseResult(..),
      initialValue,
      addGame,
      addPlayer,
      updatePlayerName,
      removePlayer,
      addItemToPlayer
    ) where

import qualified Models.Game      as G
import qualified Models.Item      as I
import           Models.Player    (PlayerId, PlayerName)
import qualified Models.TimeStamp as TS

data ParseResult = ParseResult [G.Game]
  deriving (Show)

initialValue :: ParseResult
initialValue = ParseResult []

addGame :: ParseResult -> ParseResult
addGame (ParseResult games) = ParseResult (games ++ [G.newGame])

addPlayer :: PlayerId -> ParseResult -> ParseResult
addPlayer playerId = updateCurrentGame (G.addPlayer playerId)

updatePlayerName :: PlayerName -> PlayerId -> ParseResult -> ParseResult
updatePlayerName playerName playerId = updateCurrentGame (G.updatePlayerName playerName playerId)

removePlayer :: PlayerId -> ParseResult -> ParseResult
removePlayer playerId = updateCurrentGame (G.removePlayer playerId)

addItemToPlayer :: TS.TimeStamp -> I.ItemName -> PlayerId -> ParseResult -> ParseResult
addItemToPlayer time itemName playerId
  = updateCurrentGame (G.addItemToPlayer time itemName playerId)

updateCurrentGame :: (G.Game -> G.Game) -> ParseResult -> ParseResult
updateCurrentGame updateGame (ParseResult games) =
  ParseResult (init games ++ [updateGame $ last games])
