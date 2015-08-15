module FileLib where

import System.FilePath

getFileExtension :: String -> String
getFileExtension = tail . snd . splitExtension

exchangeFileExtension :: String -> String -> String
exchangeFileExtension filepath ext = (fst $ splitExtension filepath) ++ ext

getFiltedContents :: [String] -> [String] -> [String]
getFiltedContents filterList = filter (\file -> notElem file filterList)
