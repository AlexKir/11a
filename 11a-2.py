#!/usr/bin/python3
import requests
from bs4 import BeautifulSoup

# Укажите URL страницы
url = 'https://сдо.лицей-амтэк.рф/shedule6.php'

print ("""
<!DOCTYPE html>
<html>
<head>
<title>Расписание 11А</title>
<meta charset="UTF-8">
<style>
table, th, td {
  border: 1px solid black;
  border-radius: 2px;
}
</style>
</head>
<body>
<h1>Расписание 11А</h1>
""")

# Отправляем запрос к странице
response = requests.get(url)


response.encoding = 'utf-8'  # Устанавливаем кодировку

# Создаем объект BeautifulSoup для разбора HTML
soup = BeautifulSoup(response.text, 'html.parser')

i = 0
print ('<table style="width:400px">')
for row in soup.find_all('tr'):
    if i in (2,80,158,236,314):
       s = ''
       for cell in row.find_all('td'):
            s = f'{s} {cell.text.rstrip()}'
       print(f'<tr><td colspan="4" align="center"><b>{s}</b></td></tr>')
    if i in (68,69,70,71,72,73,74,75,76, 146,147,148,149,150,151,152,153,154, 224,225,226,227,228,229,230,231,232, 302,303,304,305,306,307,308,309,310, 380,381,382,383,384,385,386,389,390):
       s = ''
       cell = row.find_all('td')
       s = f'<tr><td align="center">{cell[0].text.rstrip()}</td><td>{cell[1].text.rstrip()}</td><td align="center">{cell[2].text.rstrip()}</td><td align="center">{cell[3].text.rstrip()}</td></tr>'
       print(s)
#    print(row.text.strip())
    i = i + 1
print ('</table>')

print(f'<p>respose code {response.status_code}</p>')


print ("""
<h2><a href="https://сдо.лицей-амтэк.рф/mod/page/view.php?id=56">Источник</a></h2>
<img src="/lesson.png" width="400"></img>
</body>
</html>
""")
