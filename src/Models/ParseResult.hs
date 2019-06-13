module Models.ParseResult
    (
      ParseResult(..),
      initialValue,
      addGame,
      addPlayer,
      updatePlayerName,
      removePlayer
    ) where

import qualified Models.Game   as G
import           Models.Player (PlayerId, PlayerInfo)

data ParseResult = ParseResult [G.Game]
  deriving (Show)

initialValue :: ParseResult
initialValue = ParseResult []

addGame :: ParseResult -> ParseResult
addGame (ParseResult games) = ParseResult (games ++ [G.newGame])

addPlayer :: PlayerId -> ParseResult -> ParseResult
addPlayer playerId = updateCurrentGame (G.addPlayer playerId)

updatePlayerName :: PlayerInfo -> ParseResult -> ParseResult
updatePlayerName playerInfo = updateCurrentGame (G.updatePlayerName playerInfo)

removePlayer :: PlayerId -> ParseResult -> ParseResult
removePlayer playerId = updateCurrentGame (G.removePlayer playerId)

updateCurrentGame :: (G.Game -> G.Game) -> ParseResult -> ParseResult
updateCurrentGame updateGame (ParseResult games) =
  ParseResult (init games ++ [updateGame $ last games])
