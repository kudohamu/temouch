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
      it "拡張子がないとき\"\"を返すこと" $ do
        fileExtension "foo/bar/baz" `shouldBe` ""
    describe "exchangeFileExtensionについて" $ do
      it "拡張子を交換すること" $ do
        exchangeFileExtension "zip" "foo/bar/baz.tar" `shouldBe` "foo/bar/baz.zip"
      it "連続した拡張子のとき最後の拡張子を交換すること" $ do
        exchangeFileExtension "xz" "foo/bar/baz.tar.gz" `shouldBe` "foo/bar/baz.tar.xz"
      it "拡張子がないとき拡張子を追加だけすること" $ do
        exchangeFileExtension "rar" "foo/bar/baz" `shouldBe` "foo/bar/baz.rar"
    describe "filterFilesについて" $ do
      it "filterListに含まれるものが除去されること" $ do
        filterFiles ["hoge", "huga"] ["foo", "hoge", "bar", "huga", "baz"] `shouldBe` ["foo", "bar", "baz"]
      it "filterListが空のとき除去されるものが無いこと" $ do
        filterFiles [] ["foo", "bar", "baz"] `shouldBe` ["foo", "bar", "baz"]
    describe "subsについて" $ do
      it "置換ペアが1つのとき置換されること" $ do
        subs "qwertyfoo\nasdfoogh" [("foo", "hoge")] `shouldBe` "qwertyhoge\nasdhogegh"
      it "置換ペアが複数あるとき置換されること" $ do
        subs "barqwerty foo gvcee baz" [("foo", "hoge"), ("bar", "huga"), ("baz", "hage")] `shouldBe` "hugaqwerty hoge gvcee hage"
      it "置換ペアがないとき置換されないこと" $ do
        subs "qwerty" [] `shouldBe` "qwerty"
      it "置換ペアが同じのとき停止すること" $ do
        subs " bar foo bar " [("foo", "foo"), ("bar", "foo"), ("foo", "foo")] `shouldBe` " foo foo foo "
