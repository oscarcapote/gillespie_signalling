plot 'Results.dat' u 1:2 w l t 'Raf',\
     '' u 1:3 w l t 'pRaf',\
     '' u 1:4 w l t 'ppRaf'
pause(-1)
plot 'Results.dat' u 1:5 w l t 'MEK',\
     '' u 1:6 w l t 'pMEK',\
     '' u 1:7 w l t 'ppMEK'
pause(-1)
plot 'Results.dat' u 1:8 w l t 'ERK',\
     '' u 1:9 w l t 'pERK',\
     '' u 1:10 w l t 'ppERK'
pause(-1)
plot 'Results.dat' u 1:11 w l ,\
     '' u 1:12 w l ,\
     '' u 1:13 w l ,\
     '' u 1:13 w l ,\
     '' u 1:14 w l ,\
     '' u 1:15 w l ,\
     '' u 1:16 w l ,\
     '' u 1:17 w l ,\
     '' u 1:18 w l ,\
     '' u 1:19 w l ,\
     '' u 1:20 w l ,\
     '' u 1:21 w l ,\
     '' u 1:22 w l 
pause(-1)
plot 'Results.dat' u 1:($14-$11) w l ,\
     '' u 1:($11-$12+$13-$14) w l ,\
     '' u 1:($12-$13) w l ,\
     '' u 1:($15-$16+$17-$18) w l ,\
     '' u 1:($16-$17) w l ,\
     '' u 1:($22-$19) w l,\
     '' u 1:($19-$20+$21-$22) w l,\
     '' u 1:($20-$21) w l   
pause(-1)
