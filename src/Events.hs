module Events
    (
      Event(..)
    ) where

import           Models.Player    (PlayerId, PlayerInfo)
import           Models.TimeStamp (TimeStamp)

data Event = InitGame
  | ClientUserinfoChanged PlayerInfo
  | ClientConnect PlayerId
  | ClientDisconnect PlayerId
  | Ignored
  deriving (Show)
