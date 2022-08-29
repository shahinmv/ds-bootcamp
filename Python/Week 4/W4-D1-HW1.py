import requests
from bs4 import BeautifulSoup

URL = "https://bina.az/"
r = requests.get(URL)

soup = BeautifulSoup(r.content, 'html5lib')

vip_section = soup.find('section', attrs = {'class':'vipped_row thumblist row slider-row js-slider-row'}) 
vip_each = vip_section.find_all('div', attrs = {'class':'items_slider_row--vipped'}) 

latest_section = soup.find('section', attrs = {'class':'latest_row thumblist row slider-row js-slider-row'})
latest_each = latest_section.find_all('div', attrs = {'class':'items_list'})

location = []
date = []
link = []
section = []

for row in vip_each:
    x = row.find_all('div', attrs = {'class':['items-i vipped', 'items-i featured vipped']})
    for info in x:
        section.append('VIP')
        link.append('https://bina.az' + info.find('a', attrs = {'class':'item_link'})['href'])
        location.append(info.find('div', attrs = {'class':'location'}).text)
        date.append(info.find('div', attrs = {'class':'city_when'}).text.split(',')[1].lstrip())

for row in latest_each:
    x = row.find_all('div', attrs = {'class':['items-i vipped', 'items-i']})
    for info in x:
        section.append('Latest')
        link.append('https://bina.az' + info.find('a', attrs = {'class':'item_link'})['href'])
        location.append(info.find('div', attrs = {'class':'location'}).text)
        date.append(info.find('div', attrs = {'class':'city_when'}).text.split(',')[1].lstrip())


