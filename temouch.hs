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
    contents <-  getDirectoryContents $ homeDir ++ "/temouch/templates/" ++ (getFileExtension filepath)
    let filtedContents = getFiltedContents contents
    mapM_ print filtedContents
    print "which template do you want to use?..."
    templateNo <- readLn
    print $ filtedContents !! (templateNo - 1)

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
