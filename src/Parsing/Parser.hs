module Parsing.Parser
    ( parse
    ) where

import           Data.Char                    (isLetter)
import qualified Events
import           Models.TimeStamp             (TimeStamp (TimeStamp))
import           Parsing.DataParsers          (numbers, parseString)
import           Parsing.EventParser          (parseEvent)
import           Text.ParserCombinators.ReadP

parse :: String -> [Events.Event]
parse rawLog = map parseLine (lines rawLog)

parseLine :: String -> Events.Event
parseLine = parseString getEvent

getEvent :: ReadP Events.Event
getEvent = do
  time <- getTime
  eventType <- option "Ignored" getEventType
  restOfLine <- look

  return $ parseEvent eventType time restOfLine

getTime :: ReadP TimeStamp
getTime = do
  skipSpaces
  minutes <- numbers
  skipColon
  seconds <- numbers
  skipSpaces
  return (TimeStamp (minutes, seconds))

getEventType :: ReadP String
getEventType = do
  eventType <- munch1 isLetter
  skipColon
  skipSpaces
  return eventType

skipColon :: ReadP ()
skipColon = do
  satisfy (== ':')
  return ()
