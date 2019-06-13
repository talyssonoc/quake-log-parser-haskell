module Models.Game
    (
      Game(..),
      newGame,
      addPlayer,
      updatePlayerName,
      removePlayer
    ) where

import qualified Models.Player as P

newtype Game = Game [P.Player]
  deriving (Show)

newGame :: Game
newGame = Game []

addPlayer :: Game -> P.PlayerId -> Game
addPlayer (Game players) playerId = Game (players ++ [P.newPlayer playerId])

updatePlayerName :: Game -> P.PlayerInfo -> Game
updatePlayerName (Game players) playerInfo =  Game $ map (P.updatePlayerName playerInfo) players

removePlayer :: Game -> P.PlayerId -> Game
removePlayer (Game players) playerId = Game $ filter (not . P.hasId playerId) players
