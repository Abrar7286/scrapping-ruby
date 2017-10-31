require 'nokogiri'
require 'open-uri'
#require 'test/unit'

#url="https://blog.tickpick.com/page/2/"

$i=1
$last_page=2
begin
	url="https://blog.tickpick.com/page/#$i/"
	puts "Scrapping Page #$i with url:",url
	data= Nokogiri::HTML(open(url))
	blogs=data.css('.main_content')
	#base_blog_url="https://blog.tickpick.com/"
	k=0
	blogs.xpath('//div//article').each do|blogs|
		puts "Blog",k+1, "Information"
	 	blog_title=blogs.at('.blog_post_title').text.strip
		blog_date=blogs.at('.blog_meta_date').text.strip
		blog_url=blogs.xpath('div//h2//a')[0]['href']
		puts blog_title, blog_date,blog_url+"\n"
		
	        puts "getting in detail data"

		bdata=Nokogiri::HTML(open(blog_url))
		bdetail_data=bdata.css('.main_content')
		bdetail_data.each do|bdetail|
			blog_author=bdetail.at('.blog_meta_author').text
			blog_description=bdetail.at('.blog_post_description').text
			blog_image_url=blogs.xpath('div//div//img')[0]['src']
			puts blog_author,blog_description,blog_image_url
		end
		k+=1
	end
	$i+=1
	
end while $i<=$last_page
