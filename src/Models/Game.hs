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

addPlayer :: P.PlayerId -> Game -> Game
addPlayer playerId (Game players) = Game (players ++ [P.newPlayer playerId])

updatePlayerName :: P.PlayerInfo -> Game -> Game
updatePlayerName playerInfo (Game players) =  Game $ map (P.updatePlayerName playerInfo) players

removePlayer :: P.PlayerId -> Game -> Game
removePlayer playerId (Game players) = Game $ filter (not . P.hasId playerId) players
