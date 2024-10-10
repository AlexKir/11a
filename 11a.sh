#!/bin/bash
#
cd /var/www/html/tmp || exit 1
rm -f a.png b.png c.png d.png
set -x
LANG=en_US.UTF-8

cat << EOF
<!DOCTYPE html>
<html>
<head>
<title>Расписание 11А</title>
<meta charset="UTF-8">
</head>
<body>
<h1>Расписание 11А</h1>
EOF

#for D in $(date +%d.%m.%Y;date -d '+1 day' +%d.%m.%Y;date -d '+2 day' +%d.%m.%Y;date -d '+3 day' +%d.%m.%Y;)
d4=0
[ $(date +%d) -gt 23 ] && d4=4
for i in {0..7}
do
#  wget https://сдо.амтэк35.рф/shedule/$D.png -O a.png >> /tmp/wget.log 2>&1 || continue
#  https://2ip.ru/punycode/
  D=$(date -d '+'${i}' day' +%d.%m.%Y)
  if $(wget https://xn--d1auh.xn----8sbnlgibn8c8a2f.xn--p1ai/shedule/${D}.png -O a.png)
  then
   echo "<h2>${D}</h2>"
   echo "<img src=\"/tmp/${D}.png\" width="500"></img>"
#   convert a.png -chop 0x4000 b.png
   convert a.png -chop 0x4850 b.png
#   convert b.png -gravity South -chop 0x787 c.png
   convert b.png -gravity South -chop 0x1 c.png
   convert c.png -gravity East -chop 2691x0 d.png
#   convert c.png -gravity East -chop 3000x0 d.png
   mv d.png $D.png
  fi
  if [ ${d4} -eq 4 ] && [ ${D:0:1} -eq 0 ]
  then
    D=$(echo $D | sed -e 's/^0/4/')
    wget https://xn--d1auh.xn----8sbnlgibn8c8a2f.xn--p1ai/shedule/${D}.png  -O a.png || continue
    echo "<h2>${D}</h2>"
    echo "<img src=\"/tmp/${D}.png\" width="500"></img>"
    convert a.png -chop 0x4840 b.png
#    convert b.png -gravity South -chop 0x787 c.png
    convert b.png -gravity South -chop 0x1 c.png
    convert c.png -gravity East -chop 2691x0 d.png
#    convert c.png -gravity East -chop 3000x0 d.png
    mv d.png $D.png
  fi
done
cat << EOF
<h2><a href="https://сдо.лицей-амтэк.рф/mod/page/view.php?id=56">Источник</a></h2>
<h2>Расписание уроков</h2>
<img src="/lesson.png" width="400"></img>
<h3>$(date)</h3>
</body>
</html>
EOF
