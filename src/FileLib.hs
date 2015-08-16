module FileLib where

import System.FilePath

type FileName = String

fileExtension :: FileName -> String
fileExtension = tail . snd . splitExtension

exchangeFileExtension :: String -> FileName -> FileName
exchangeFileExtension filepath ext = (fst $ splitExtension filepath) ++ ext

filterFiles :: [String] -> [FileName] -> [FileName]
filterFiles filterList = filter (\file -> notElem file filterList)
