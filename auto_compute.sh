

figure=$1

if [ $figure = 'a0' ]
then
	#Figura a0
	for opt in a0 a2 #a b c d e f
	do
		echo Opcio $opt
		./main $opt > Results_$opt.dat
		mv Results_$opt.dat ./a0
	done
elif [ $figure = 'a' ]
then
	#Figures a a b c d
	opt=a
	echo Opcio $opt
	./main $opt > Results_$opt.dat
	mv Results_$opt.dat ./$opt
elif [ $figure = 'b' ]
then
	#Figures a a b c d
	opt=b
	echo Opcio $opt
	./main $opt > Results_$opt.dat
	mv Results_$opt.dat ./$opt
elif [ $figure = 'c' ]
then
	#Figures a a b c d
	opt=c
	echo Opcio $opt
	./main $opt > Results_$opt.dat
	mv Results_$opt.dat ./$opt
elif [ $figure = 'd' ]
then
	#Figures a a b c d
	opt=d
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
