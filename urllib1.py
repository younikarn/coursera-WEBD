import urllib.request, urllib.parse, urllib.error
from bs4 import BeautifulSoup

file = urllib.request.urlopen('http://py4e-data.dr-chuck.net/comments_842424.html').read()
html = BeautifulSoup(file,'html.parser')
sum = 0
tags = html('span')

for tag in tags :
    num = tag.contents[0]
    num = int(num)
    sum = sum + num
print(sum)

print()
input("Press any key to continue........")
