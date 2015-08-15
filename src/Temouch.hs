module Temouch
    ( 
    temouch
    , getFileExtension
    , getFiltedContents
    ) where

import System.FilePath
import System.Environment
import System.Directory
import System.IO
import Data.String.Utils

import FileLib

temouch = do
  args <- getArgs
  if length args /= 1
  then putUsage
  else do
    let filepath = head $ args
    homeDir <- getHomeDirectory
    let templatesDir = homeDir ++ "/temouch/templates/" ++ (getFileExtension filepath)
    contents <-  getDirectoryContents templatesDir
    let filtedContents = getFiltedContents contents
    if length filtedContents == 0
    then do
      putStrLn "No templates match. So the file was created as an empty file."
    else do
      putStrLn "You can use these files as template."
      putStrLn ""
      putStrLn "-----------------------------------------"
      mapM_ putStrLn . map (\(num, file) -> show num ++ ": " ++ file) $ (0, "no use") : zip [1..] filtedContents
      putStrLn "-----------------------------------------"
      putStrLn ""
      putStrLn "Which template do you want to use? Please choose number."
      templateNo <- readLn
      let (newDir, newFile) = splitFileName filepath
      createDirectoryIfMissing True newDir
      exist <- doesFileExist filepath
      let tempPath = if templateNo /= 0 then templatesDir ++ "/" ++ filtedContents !! (templateNo - 1) else ""
      if exist
      then do
        putStrLn "File already exist! Overwrite? [y|n]"
        overwrite <- getChar
        if overwrite == 'y'
        then do
          createFile tempPath filepath
        else do
          putStrLn "Stopped creating."
      else do
        createFile tempPath filepath

putUsage = putStrLn("Usage: temouch filepath")

createFile :: String -> String -> IO ()
createFile "" filePath = do
  writeFile filePath ""
  putStrLn $ "Created " ++ filePath ++ " (no using template)."
createFile tempPath filePath = do
  writeFile filePath ""
  templateHandle <- openFile tempPath ReadMode
  templateContents <- hGetContents templateHandle
  newFileHandle <- openFile filePath AppendMode
  mapM_ (\line -> hPutStrLn newFileHandle $ replace "!!!FILE_NAME!!!" (fst . splitExtension . snd $ splitFileName filePath) line) $ lines templateContents
  hClose templateHandle 
  hClose newFileHandle
  putStrLn $ "Created " ++ filePath ++ " (using template '" ++ tempPath ++ "')."


