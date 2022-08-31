import scrapy

class RedditSpider(scrapy.Spider):
    name = 'reddit'
    start_urls = ['https://www.reddit.com/r/gameofthrones/']

    def parse(self, response): 
        titles = response.xpath("//h3[@class='_eYtD2XCVieq6emjKBH3m']/text()").getall()
        votes = response.xpath("//div[@class='_1rZYMD_4xY3gRcSS3p8ODO _3a2ZHWaih05DgAOtvu6cIo ']/text()").extract()
        dates = response.xpath("//span[@class='_2VF2J19pUIMSLJFky-7PEI']/text()").getall()
        links = response.xpath("//a[@class='SQnoC3ObvgnGjWt90zD9Z _2INHSNB8V5eaWp4P0rY_mE']/@href").getall()

        posts = zip(titles, votes, dates, links)

        for post in posts:
            yield {
                "title": post[0],
                "votes": post[1], 
                "dates": post[2], 
                "links": "https://www.reddit.com/r/gameofthrones" + post[3],       
            }