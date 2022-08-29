import scrapy

""" URL = 'https://quotes.toscrape.com/'

response = fetch("https://quotes.toscrape.com/")

response.css(".quote span.text::text").extract()
response.css(".quote small.author::text").extract()

response.xpath("//div[@class='tags']").extract_first() 
products = response.css('div.quote')
products.css('a').attrib['href']

"""


class QuoteSpider(scrapy.Spider):
    name = 'quotes'
    start_urls = ['https://quotes.toscrape.com/']

    def parse(self, response):
        for quote in response.css(".quote span.text"):
             yield {
                'quote': quote.css('span.text::text').get(),
                'tags' : quote.css('a.tag::text').getall(),
                #'link': quote.css('a').attrib['href'],
             }

