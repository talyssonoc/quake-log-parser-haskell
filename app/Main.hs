module Main where

import           Models.ParseResult
import           Parser

main :: IO ()
main = do
  fileContent <- readFile "/Users/c_tcassiano/development/haskell/quake-log-parser/logs/games.log"
  putStrLn $ show $ parse fileContent
