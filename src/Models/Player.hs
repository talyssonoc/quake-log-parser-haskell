module Models.Player
    (
      Player(..),
      PlayerId,
      PlayerName,
      newPlayer,
      updatePlayerName,
      addItemToPlayer,
      hasId
    ) where

import qualified Data.Map.Strict  as Map
import           Models.Item      (Item, ItemName)
import           Models.TimeStamp (TimeStamp)

type PlayerId = Int
type PlayerName = String

data Player = NewPlayer PlayerId
            | Player PlayerId PlayerName (Map.Map Item TimeStamp)
  deriving (Show)

newPlayer :: PlayerId -> Player
newPlayer = NewPlayer

updatePlayerName :: PlayerName -> Player -> Player
updatePlayerName newName (NewPlayer i)   = Player i newName Map.empty
updatePlayerName newName (Player i _ is) = Player i newName is

addItemToPlayer :: TimeStamp -> ItemName -> Player -> Player
addItemToPlayer _ _ (NewPlayer i)    = NewPlayer i
addItemToPlayer t it (Player i n is) = Player i n (Map.insert it t is)

hasId :: PlayerId -> Player -> Bool
hasId i' player  = i' == playerId player

playerId :: Player -> PlayerId
playerId (Player i _ _) = i
playerId (NewPlayer i)  = i
