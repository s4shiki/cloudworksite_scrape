# URLにアクセスするためのライブラリの読み込み
require 'open-uri'
# Nokogiriライブラリの読み込み
require 'nokogiri'

# スクレイピング先のURL
url = 'http://www.lancers.jp/work/search/all?sort=Work.started&direction=desc&keyword=&parent_category=&money_min=&money_max=&typeCompetition=1&typeProject=1&typeTask=0&feedback=0&identification=0&lancers_check=0&nda=0&approval_rate=0&award_guarantee=0&new=1&hurry=0&feature=0&completed=0'

charset = nil
html = open(url) do |f|
  charset = f.charset # 文字種別を取得
    f.read # htmlを読み込んで変数htmlに渡す
    end

# htmlをパース(解析)してオブジェクトを生成
doc = Nokogiri::HTML.parse(html, nil, charset)

doc.xpath('//tr').each do |node|
  p '------------------------------------------------'
  p '[タイトル]'
  p node.css('p[@class="work_title"]>a').inner_text
  p '[カテゴリ]'
  p node.css('p[@class="category"]>a').inner_text
  p '[最低額]'
  p node.css('span[@class="price-block top"]>span[@class="work-price-span price-number"]').inner_text
  p '[最高額]'
  p node.css('span[@class="price-block bottom"]>span[@class="work-price-span price-number"]').inner_text
  p '------------------------------------------------'
end
