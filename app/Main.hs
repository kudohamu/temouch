module Main where

import System.Environment

import Temouch

putUsage = putStrLn "Usage: temouch <FILE_PATH>"

main :: IO ()
main = do
  args <- getArgs
  if length args == 0 then do
    putUsage
  else do
    temouch $ head args
