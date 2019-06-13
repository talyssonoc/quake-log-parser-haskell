module Models.Player
    (
      Player(..),
      PlayerId,
      PlayerInfo,
      newPlayer,
      updatePlayerName,
      hasId
    ) where

type PlayerId = Int
type PlayerName = String

type PlayerInfo = (PlayerId, PlayerName)

data Player = NewPlayer PlayerId
            | Player PlayerId PlayerName
  deriving (Show)

newPlayer :: PlayerId -> Player
newPlayer = NewPlayer

updatePlayerName :: PlayerInfo -> Player -> Player
updatePlayerName (i', newName) player
  | hasId i' player = Player i' newName
  | otherwise = player

hasId :: PlayerId -> Player -> Bool
hasId i' (Player i _)  = i' == i
hasId i' (NewPlayer i) = i' == i
