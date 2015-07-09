import System.Environment
import System.FilePath
import System.Directory

putUsage = putStrLn("Usage: temouch filepath")

main = do
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
      mapM_ putStrLn . map (\(num, file) -> show num ++ ": " ++ file) $ zip [1..] filtedContents
      putStrLn "-----------------------------------------"
      putStrLn ""
      putStrLn "Which template do you want to use? Please choose number."
      templateNo <- readLn
      let (newDir, newFile) = splitFileName filepath
      createDirectoryIfMissing True newDir
      exist <- doesFileExist filepath
      if exist
      then do
        putStrLn "File already exist! Overwrite? [y|n]"
        overwrite <- getChar
        if overwrite == 'y'
        then do
          copyFile (templatesDir ++ "/" ++ filtedContents !! (templateNo - 1)) filepath
          putStrLn $ "Created " ++ newFile ++ " (using template '" ++ (filtedContents !! (templateNo - 1)) ++ "')."
        else do
          putStrLn "Stopped creating."
      else do
        copyFile (templatesDir ++ "/" ++ filtedContents !! (templateNo - 1)) filepath
        putStrLn $ "Created " ++ newFile ++ " (using template '" ++ (filtedContents !! (templateNo - 1)) ++ "')."

{- 
 >> getFileExtension "abc"
 >  ""
 >> getFileExtension "abc.txt"
 >  "txt"
 >> getFileExtension "abc.txt.exe"
 >  "exe"
 -}

getFileExtension :: String -> String
getFileExtension = tail . snd . splitExtension



{-
 >> getFiltedContents ["hoge", ".", "huga", ".git"]
 >  ["hoge", "huga"]
 >> getFiltedContents ["hoge", "huga"]
 >  ["hoge", "huga"]
 >> getFiltedContents [".DS_Store", ".svn"]
 >  []
-}

ignoreFiles = [".", "..", ".DS_Store", ".git", ".svn"]

getFiltedContents :: [String] -> [String]
getFiltedContents = filter (\file -> notElem file ignoreFiles)
