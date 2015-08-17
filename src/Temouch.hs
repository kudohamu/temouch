module Temouch ( 
  temouch
) where

import Control.Applicative
import qualified Data.Foldable as F hiding (mapM_)
import System.FilePath
import System.IO
import System.Directory
import System.Posix.Files
import System.Posix.Time
import System.Posix.Types
import Data.String.Utils

import FileLib

ignoreFiles = [".", "..", ".DS_Store", ".git", ".svn"]

temouch :: FilePath -> IO ()
temouch filePath = do
  -- テンプレートファイル群を取得する
  let ext = fileExtension filePath
  tempDir <- (++) <$> getHomeDirectory <*> pure ("/temouch/templates/" ++ ext)
  exist <- doesDirectoryExist tempDir
  if exist then do
    templates <- filterFiles ignoreFiles <$> getDirectoryContents tempDir
    -- どのテンプレートを使うか
    putStrLn "You can use these files as template.\n\
             \ \n\
             \-----------------------------------------"
    mapM_ putStrLn . map (\(num, file) -> show num ++ ": " ++ file) $ (0, "don't use") : zip [1..] templates
    putStrLn "-----------------------------------------\n\
             \ \n\
             \Which template do you want to use? Please choose number."
    templateNo <- readLn :: IO Int

    if templateNo == 0
    then do
      -- 空のファイルを作成する
      touch filePath ""
      putStrLn $ "Created " ++ filePath ++ " (no using template)."
    else do
      let newFilePath = (exchangeFileExtension $ fileExtension (templates !! (templateNo - 1))) filePath
      template <- readFile $ tempDir ++ "/" ++ templates !! (templateNo - 1)
      -- メタ変数を置き換えてファイルに書き込む
      touch newFilePath $ subs template [("!!!FILE_NAME!!!", (fst . splitExtension . snd $ splitFileName newFilePath))]
      putStrLn $ "Created " ++ newFilePath ++ " (using template '" ++ templates !! (templateNo - 1) ++ "')."
  else do
    touch filePath ""
    putStrLn "No templates match. So the file was created as an empty file."


touch :: FilePath -> String -> IO ()
touch filePath content = do
    nowTime <- epochTime
    amtouch filePath content nowTime nowTime

amtouch :: FilePath -> String -> EpochTime -> EpochTime -> IO ()
amtouch filePath content atime mtime= do
  exist <- doesFileExist filePath
  if exist then do
    -- タイムスタンプ変更
    setFileTimes filePath atime mtime
  else do
    createDirectoryIfMissing True $ fst $ splitFileName filePath
    writeFile filePath content
