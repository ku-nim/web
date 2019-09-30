import htmlcc

proc index*(): string =
  let pageName = "Kyoto University Nim Club - 京都大学 Nim 大好き倶楽部"
  return
    htmlcc html:
      htmlcc head:
        title:
          pageName
        meta(charset="utf-8")
        link(rel="icon", href="/favicon.ico", type="image/x-icon")
      htmlcc body:
        htmlcc `div`:
          htmlcc h1:
            img(src="/favicon.ico", alt="Pizza!",width="30em")
            pageName
            img(src="/favicon.ico", alt="Pizza!",width="30em")
          htmlcc marquee:
            "Nim は 2019/9/23 に version 1.0.0 をリリースしました! -"
            " 2019/10/0 !!!"
        htmlcc `div`:
          a(href="https://nim-lang.org/blog/2019/09/23/version-100-released.html"):
            "バージョン 1.0 リリース! (リンク先は公式ブログ)"
          br()
          "おめでとう!!!"
          br()
          img(src="/pizza.jpg", alt="Pizza!")
        htmlcc footer:
          a(href="https://github.com/ku-nim/web"):
            "このサイトはNimで書かれています！ yay!"

if isMainModule:
  echo index()
