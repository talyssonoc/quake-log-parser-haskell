module Parser
    ( parse
    ) where

import qualified Events             as E
import qualified Models.ParseResult as PR
import           Text.Regex         (mkRegex, splitRegex)

parse :: String -> PR.ParseResult
parse rawLog = foldl parseLine PR.initialValue (lines rawLog)

parseLine :: PR.ParseResult -> String -> PR.ParseResult
parseLine p l = E.nextState (eventType l) p

eventType :: String -> E.Event
eventType rawLine = case commonInfo of
  (_, "InitGame", _) -> E.InitGame
  _                  -> E.Invalid
  where
    commonInfo = case commonInfo' of
        (_ : t : _ : eventTypeString : unparsed : _) -> (t, eventTypeString, unparsed)
        _ -> ("", "", "")
    commonInfo' = splitRegex (mkRegex "\\s*(\\d+:\\d{2})\\s((\\w+):\\s?(.*))?") rawLine
