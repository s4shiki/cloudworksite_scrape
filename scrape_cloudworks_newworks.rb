# URLにアクセスするためのライブラリの読み込み
require 'open-uri'
# Nokogiriライブラリの読み込み
require 'nokogiri'

# スクレイピング先のURL
url = 'http://crowdworks.jp/public/jobs/u/professionals?order=new'

charset = nil
html = open(url) do |f|
  charset = f.charset # 文字種別を取得
    f.read # htmlを読み込んで変数htmlに渡す
    end

# htmlをパース(解析)してオブジェクトを生成
doc = Nokogiri::HTML.parse(html, nil, charset)

doc.xpath('//div[@class="item job_item"]').each do |node|
  p '------------------------------------------------'
  p '[タイトル]'
  p node.css('h3[@class="item_title"]>a').inner_text
  p '[カテゴリ]'
  p node.css('span[@class="sub_category"]').inner_text
  if node.css('span[@class="amount"]>span')[1] then
    p '[希望額]'
    p '[最低額]'
    p node.css('span[@class="amount"]>span')[0].inner_text
    p '[最高額]'
    p node.css('span[@class="amount"]>span')[1].inner_text
  else
    p '[希望額]'
    if node.css('span[@class="amount"]>span').inner_text == "" then
      p '見積もり希望'
    else
      p node.css('span[@class="amount"]>span').inner_text 
    end
  end
  p '------------------------------------------------'
end
