module Main where

import           Parsing.Parser
import           Processing.Processor

main :: IO ()
main = do
  fileContent <- readFile "/home/talyssonoc/Development/haskell/quake-log-parser-haskell/logs/games.log"
  print $ process $ parse fileContent
