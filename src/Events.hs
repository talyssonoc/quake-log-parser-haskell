module Events
    (
      Event(..)
    ) where

import           Models.Item      (Item, ItemName)
import           Models.Player    (PlayerId, PlayerName)
import           Models.TimeStamp (TimeStamp)

data Event = InitGame
  | ClientUserinfoChanged PlayerName PlayerId
  | ClientConnect PlayerId
  | ClientDisconnect PlayerId
  | Item TimeStamp ItemName PlayerId
  | Ignored
  deriving (Show)
