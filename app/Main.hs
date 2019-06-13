module Main where

import           Parsing.Parser
import           Processing.Processor

main :: IO ()
main = do
  fileContent <- readFile "/Users/c_tcassiano/development/haskell/quake-log-parser/logs/games.log"
  print $ process $ parse fileContent
