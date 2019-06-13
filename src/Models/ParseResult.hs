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

addPlayer :: ParseResult -> PlayerId -> ParseResult
addPlayer parseResult playerId =
  updateCurrentGame parseResult (G.addPlayer (currentGame parseResult)  playerId)

updatePlayerName :: ParseResult -> PlayerInfo -> ParseResult
updatePlayerName parseResult playerInfo =
  updateCurrentGame parseResult (G.updatePlayerName (currentGame parseResult) playerInfo)

removePlayer :: ParseResult -> PlayerId -> ParseResult
removePlayer parseResult playerId =
  updateCurrentGame parseResult (G.removePlayer (currentGame parseResult) playerId)

currentGame :: ParseResult -> G.Game
currentGame (ParseResult games) = last games

updateCurrentGame :: ParseResult -> G.Game -> ParseResult
updateCurrentGame (ParseResult games) game = ParseResult (init games ++ [game])
