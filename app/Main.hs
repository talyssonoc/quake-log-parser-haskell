module Main where

import           Control.Applicative
import           Data.Char                    (isDigit, isLetter)
import           Events                       as E
import           Models.ParseResult
import           Models.TimeStamp             as TS
import           Parser
import           Text.ParserCombinators.ReadP

main :: IO ()
-- main = do
--   print $ readP_to_S getEvent "  0:00 ------------------------------------------------------------"
--
-- getEvent :: ReadP E.Event
-- getEvent = do
--   time <- getTime
--   eventType <- option "Invalid" getEventType
--   restOfLine <- look
--
--   return (case eventType of
--     "InitGame" -> E.InitGame
--     _          -> E.Invalid)
--
-- getTime :: ReadP (TS.TimeStamp Int Int)
-- getTime = do
--   skipSpaces
--   minutes <- numbers 1 <|> numbers 2
--   satisfy (== ':')
--   seconds <- numbers 2
--   skipSpaces
--   return (TS.TimeStamp minutes seconds)
--
-- numbers :: Int -> ReadP Int
-- numbers digits =
--     fmap read (count digits digit)
--
-- digit :: ReadP Char
-- digit = satisfy isDigit
--
-- getEventType :: ReadP String
-- getEventType = do
--   eventType <- munch1 isLetter
--   satisfy (== ':')
--   skipSpaces
--   return eventType

main = do
  fileContent <- readFile "/Users/c_tcassiano/development/haskell/quake-log-parser/logs/games.log"
  putStrLn $ show $ parse fileContent
