module Models.Game
    (
      Game(Game),
      newGame
    ) where

import           Models.Player

data Game = Game [Player]
  deriving (Show)

newGame :: Game
newGame = Game []
