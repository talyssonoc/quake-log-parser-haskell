module Parser
    ( parse
    ) where

import           Control.Applicative
import           Data.Char                    (isDigit, isLetter)
import qualified Events                       as E
import qualified Models.ParseResult           as PR
import qualified Models.TimeStamp             as TS
import           Text.ParserCombinators.ReadP

parse :: String -> PR.ParseResult
parse rawLog = foldl parseLine PR.initialValue (lines rawLog)

parseLine :: PR.ParseResult -> String -> PR.ParseResult
parseLine pr line = E.nextState pr (event (readP_to_S getEvent line))

event :: [(E.Event, t)] -> E.Event
event = fst . last

getEvent :: ReadP E.Event
getEvent = do
  time <- getTime
  eventType <- option "Invalid" getEventType
  restOfLine <- look

  return (case eventType of
    "InitGame" -> E.InitGame
    _          -> E.Invalid)

getTime :: ReadP (TS.TimeStamp Int Int)
getTime = do
  skipSpaces
  minutes <- numbers
  satisfy (== ':')
  seconds <- numbers
  skipSpaces
  return (TS.TimeStamp minutes seconds)

numbers :: ReadP Int
numbers = fmap read (munch1 isDigit)

getEventType :: ReadP String
getEventType = do
  eventType <- munch1 isLetter
  satisfy (== ':')
  skipSpaces
  return eventType
