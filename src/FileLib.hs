module FileLib where

import System.FilePath

type FileName = String

fileExtension :: FileName -> String
fileExtension filename = case snd $ splitExtension filename of
                           [] -> ""
                           xs -> tail xs

exchangeFileExtension :: String -> FileName -> FileName
exchangeFileExtension ext filepath = (fst $ splitExtension filepath) ++ '.' : ext

filterFiles :: [String] -> [FileName] -> [FileName]
filterFiles filterList = filter (\file -> notElem file filterList)

