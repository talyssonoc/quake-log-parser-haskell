module Models.Game
    (
      Game(..),
      newGame,
      addPlayer,
      updatePlayerName,
      removePlayer,
      addItemToPlayer
    ) where

import qualified Models.Item      as I
import qualified Models.Player    as P
import qualified Models.TimeStamp as TS

newtype Game = Game [P.Player]
  deriving (Show)

newGame :: Game
newGame = Game []

addPlayer :: P.PlayerId -> Game -> Game
addPlayer playerId (Game players) = Game (players ++ [P.newPlayer playerId])

updatePlayerName :: P.PlayerName -> P.PlayerId -> Game -> Game
updatePlayerName playerName = updatePlayer (P.updatePlayerName playerName)

removePlayer :: P.PlayerId -> Game -> Game
removePlayer playerId (Game players) = Game $ filter (not . P.hasId playerId) players

addItemToPlayer :: TS.TimeStamp -> I.ItemName -> P.PlayerId -> Game -> Game
addItemToPlayer time itemName = updatePlayer (P.addItemToPlayer time itemName)

updatePlayer :: (P.Player -> P.Player) -> P.PlayerId -> Game -> Game
updatePlayer updater playerToUpdateId (Game players)
  =  Game (map (updatePlayerIfSameId playerToUpdateId updater) players)

updatePlayerIfSameId :: P.PlayerId -> (P.Player -> P.Player) -> P.Player -> P.Player
updatePlayerIfSameId playerToUpdateId updater player
  | P.hasId playerToUpdateId player = updater player
  | otherwise = player
