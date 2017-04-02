DECLARATIONS = $(wildcard ./declarations/*.dec)
DATA_a0 = $(wildcard ./a0/*.dat)
DATA_a = $(wildcard ./a/*.dat)
DATA_b = $(wildcard ./b/*.dat)
DATA_c = $(wildcard ./c/*.dat)
DATA_d = $(wildcard ./d/*.dat)
DATA_e = $(wildcard ./e/*.dat)
DATA_f = $(wildcard ./f/*.dat)
DATA_tot = $(DATA_a0) $(DATA_a) $(DATA_b) $(DATA_c) $(DATA_d) $(DATA_e) $(DATA_f)

.PHONY : install
install : main

main : treball.o ritmes.o $(DECLARATIONS)
	gfortran treball.o ritmes.o -o main

treball.o: treball.f90 ritmes.o $(DECLARATIONS)
	gfortran -c ritmes.o treball.f90

ritmes.o : ritmes.f90
	gfortran -c ritmes.f90

mainRK4 : RK4.o ritmes.o
	gfortran ritmes.o RK4.o -o mainRK4

RK4 : RK4.f90 ritmes.o
	gfortran -c ritmes.o RK4.f90

.PHONY: clean
clean:
	@rm *.o
	@rm *.mod


.PHONY: data
data : $(DATA_a0) $(DATA_a) $(DATA_b) $(DATA_c) $(DATA_d) $(DATA_e) $(DATA_f) $(DECLARATIONS)
	echo $(DATA_f)

$(DATA_a0) : $(filter %a0.dat %a2.dat ,$(DECLARATIONS) $(DATA_a0))
	sh auto_compute.sh a0
$(DATA_b) : $(filter %b.dat ,$(DECLARATIONS)) $(DATA_b)
	sh auto_compute.sh b
$(DATA_a) : $(filter %a.dat ,$(DECLARATIONS)) $(DATA_a)
	sh auto_compute.sh a
$(DATA_c) : $(filter %c.dat ,$(DECLARATIONS)) $(DATA_c)
	sh auto_compute.sh c
$(DATA_d) : $(filter %d.dat ,$(DECLARATIONS)) $(DATA_d)
	sh auto_compute.sh d
$(DATA_e) : $(filter %e.dat ,$(DECLARATIONS)) $(DATA_e)
	sh auto_compute.sh e
$(DATA_f) : $(filter %f%.dat ,$(DECLARATIONS)) $(DATA_f)
	@echo $(filter %f%.dat ,$(DECLARATIONS))
	sh auto_compute.sh f
