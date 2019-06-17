module Parsing.EventParser
    (
      parseEvent
    ) where

import qualified Events                       as E
import           Models.TimeStamp             (TimeStamp)
import           Parsing.DataParsers          (numbers, parseString)
import           Text.ParserCombinators.ReadP

parseEvent :: String -> TimeStamp -> String -> E.Event
parseEvent "InitGame" _ _                 = E.InitGame
parseEvent "ClientConnect" _ line         = parseString clientConnectEvent line
parseEvent "ClientUserinfoChanged" _ line = parseString clientUserinfoChangedEvent line
parseEvent "ClientDisconnect" _ line      = parseString clientDisconnectEvent line
parseEvent "Item" time line               = parseString (itemEvent time)  line
parseEvent _ _ _                          = E.Ignored

clientUserinfoChangedEvent :: ReadP E.Event
clientUserinfoChangedEvent = do
  playerId <- numbers
  skipSpaces
  string "n\\"
  playerName <- manyTill get (string "\\t\\")

  return (E.ClientUserinfoChanged playerName playerId)

clientConnectEvent :: ReadP E.Event
clientConnectEvent = do
  playerId <- numbers

  return (E.ClientConnect playerId)

clientDisconnectEvent :: ReadP E.Event
clientDisconnectEvent = do
  playerId <- numbers

  return (E.ClientDisconnect playerId)

itemEvent :: TimeStamp -> ReadP E.Event
itemEvent time = do
  playerId <- numbers
  skipSpaces
  itemName <- look

  return (E.Item time itemName playerId)
