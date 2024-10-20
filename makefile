hangman: modulo.o main.o getword.o printword.o getguess.o initguess.o printguess.o check_key.o
	gcc -o hangman modulo.o main.o getword.o printword.o getguess.o initguess.o printguess.o check_key.o
	
modulo.o: modulo.s
	gcc -g -c modulo.s

main.o: main.s
	gcc -g -c main.s

getword.o: getword.s
	gcc -g -c getword.s

printword.o: printword.s
	gcc -g -c printword.s

getguess.o: getguess.s
	gcc -g -c getguess.s

initguess.o: initguess.s
	gcc -g -c initguess.s

printguess.o: printguess.s
	gcc -g -c printguess.s

check_key.o: check_key.s
	gcc -g -c check_key.s

clean:
	rm hangman *.o
