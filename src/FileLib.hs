module FileLib where

import System.FilePath

type FileName = String

getFileExtension :: FileName -> String
getFileExtension = tail . snd . splitExtension

exchangeFileExtension :: String -> FileName -> FileName
exchangeFileExtension filepath ext = (fst $ splitExtension filepath) ++ ext

getFiltedContents :: [String] -> [FileName] -> [FileName]
getFiltedContents filterList = filter (\file -> notElem file filterList)
