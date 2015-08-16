module FileLibSpec where

import Test.Hspec

import FileLib

fileLibSpec :: Spec
fileLibSpec = do
  describe "FileLib" $ do
    describe "fileExtensionについて" $ do
      it "拡張子を返すこと" $ do
        fileExtension "foo/bar/baz.txt" `shouldBe` "txt"
      it "連続した拡張子のとき最後の拡張子を返すこと" $ do
        fileExtension "foo/bar/baz.tar.gz" `shouldBe` "gz"
