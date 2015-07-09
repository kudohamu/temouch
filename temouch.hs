import System.Environment

putUsage = putStrLn("Usage: temouch filepath")

main = do
  args <- getArgs
  if length args /= 1
  then putUsage
  else do
    let filepath = head $ args
    print (filepath)
