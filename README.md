#temouch

新しくファイルを作るときにテンプレートファイルから選んで作れるよ。  
template + touch 的なノリの命名

##Usage

事前に`~/temouch/templates/`以下に拡張子ごとにフォルダを分けてテンプレートファイルを入れておく。 
例えばこんな感じ

```
~/
┗ templates/
      ┣ rb/
      ┃ ┣ hoge.rb
      ┃ ┗ huga.rb
      ┃ 
      ┗ md/
         ┣ foo.md
         ┣ bar.md
         ┗ baz.md
```

あとはファイル作りたくなったときにtouchコマンドの気分で

```
temouch newFileName.rb
```

で使いたいテンプレートを聞かれる。

答えたらその内容の入った_newFileName_.rbが作られる。
![](https://dl.dropboxusercontent.com/u/74925506/temouch.png)


`temouch ~/foo/bar/baz/kudohamu.rb`  
みたいな指定もOK.  
存在しないディレクトリ内に作るときは勝手に作るし、作ろうとしているファイルが既にある場合は上書きするか聞くよ。

####ファイル名埋め込み

テンプレートファイル内で`!!!FILE_NAME!!!`という文字列を入れた場所はファイル名（拡張子除く）に置き換わるよ。  
##TODO

* ちゃんとタイムスタンプだけ変えるオプションも入れる...
