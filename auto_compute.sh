

figure=$1

if [ $figure = 'a0' ]
then
	#Figura a0
	for opt in a0 #a b c d e f
	do
		echo Opcio $opt
		./main $opt > Results_$opt.dat
		mv Results_$opt.dat ./a0
	done
elif [ $figure = 'a' ]
then
	#Figura a
	opt=a
	echo Opcio $opt
	./main $opt > Results_$opt.dat
	mv Results_$opt.dat ./$op
	opt=a2
	echo Opcio $opt
	./main $opt > Results_$opt.dat
	mv Results_$opt.dat ./$opt
elif [ $figure = 'b' ]
then
	#Figura b
	opt=b
	echo Opcio $opt
	./main $opt > Results_$opt.dat
	mv Results_$opt.dat ./$opt
elif [ $figure = 'c' ]
then
	#Figura c
	opt=c
	echo Opcio $opt
	./main $opt > Results_$opt.dat
	mv Results_$opt.dat ./$opt
elif [ $figure = 'd' ]
then
	#Figura d
	opt=d
	echo Opcio $opt
	./main $opt > Results_$opt.dat
	mv Results_$opt.dat ./$opt
elif [ $figure = 'e' ]
then
	#Figura e
	opt=e
	echo Opcio $opt
	./main $opt > Results_$opt.dat
	mv Results_$opt.dat ./$opt
elif [ $figure = 'f' ]
then
	#Figura f
	for opt in f1 f2 f3 f4 f5 f6
	do
		echo Opcio $opt
		./main $opt > Results_$opt.dat
		mv Results_$opt.dat ./f
	done
fi
