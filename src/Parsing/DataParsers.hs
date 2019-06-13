module Parsing.DataParsers
    (
      parseString,
      numbers
    ) where

import           Data.Char                    (isDigit)
import           Text.ParserCombinators.ReadP

parseString :: ReadP r -> String -> r
parseString parser str = fst $ last $ readP_to_S parser str

numbers :: ReadP Int
numbers = fmap read (munch1 isDigit)
