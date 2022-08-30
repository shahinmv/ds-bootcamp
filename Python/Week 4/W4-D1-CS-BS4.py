import requests
from bs4 import BeautifulSoup

URL = 'https://www.reddit.com/r/gameofthrones/'

headers = {'User-Agent': 'Chrome/90.0.4430.93'}

r = requests.get(URL, headers=headers)

soup = BeautifulSoup(r.content, 'html5lib')

posts_each = soup.find_all('h3', attrs = {'class':'_eYtD2XCVieq6emjKBH3m'})
votes_each = soup.find_all('div', attrs = {'class':'_1rZYMD_4xY3gRcSS3p8ODO _3a2ZHWaih05DgAOtvu6cIo'})
dates_each = soup.find_all('span', attrs = {'class':'_2VF2J19pUIMSLJFky-7PEI'})
links_each = soup.find_all('a', attrs = {'class':'SQnoC3ObvgnGjWt90zD9Z _2INHSNB8V5eaWp4P0rY_mE'})


posts = []
votes = []
dates = []
links = []

for row in posts_each:
    posts.append(row.get_text()) 

for row in votes_each:
    votes.append(row.get_text()) 

for row in dates_each:
    dates.append(row.get_text()) 

for row in links_each:
    links.append("https://www.reddit.com/" + row['href'])



