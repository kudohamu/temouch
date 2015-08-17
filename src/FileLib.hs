module FileLib where

import System.FilePath
import Data.String.Utils

type FileName = String

fileExtension :: FileName -> String
fileExtension filename = case snd $ splitExtension filename of
                           [] -> ""
                           xs -> tail xs

exchangeFileExtension :: String -> FileName -> FileName
exchangeFileExtension ""  filePath =  fst $ splitExtension filePath
exchangeFileExtension ext filepath = (fst $ splitExtension filepath) ++ '.' : ext

filterFiles :: [String] -> [FileName] -> [FileName]
filterFiles filterList = filter (\file -> notElem file filterList)

subs :: String -> [(String, String)] -> String
subs = foldr (\(prev, next) str -> replace prev next str)
