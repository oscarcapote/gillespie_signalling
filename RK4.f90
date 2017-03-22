program RKBio
use ritmes
implicit none
real(8) :: h,t0
real(8),dimension(9) :: x0 
integer(8) :: Nsteps,Nmeasure
real(8) ::factor,RasGTP,Raf,pRaf,ppRaf,MEK,pMEK,ppMEK,ERK,pERK,ppERK!Magnituds dinamiques
common RasGTP
!Inicialitzacio de parametres i condicions inicials

include 'declaration.dec'


x0(1)=Raf
x0(2)=pRaf
x0(3)=ppRaf
x0(4)=MEK
x0(5)=pMEK
x0(6)=ppMEK
x0(7)=ERK
x0(8)=pERK
x0(9)=ppERK

h = init(1)
Nsteps = init_int(2)
Nmeasure = 100


t0=0
!h = 5d-3
print*,h,Nsteps,Nmeasure,x0


open(unit=20,file='Resultats_determinista.dat')
call RK4(f2,x0,t0,h,Nsteps,Nmeasure,20)
close(20)


contains

function init(i) result(x)
!Funcio que agafa s'i-essim parametre passat per consola i el fa de doble precisio
    integer(4) ::i
    real(8) :: x
    character(100) :: c
    call get_command_argument(i,c)
    read(c,*) x
    !print*,i,c,x
end function

function init_int(i) result(x)
!Funcio que agafa s'i-essim parametre passat per conola i el fa de enter
    integer(4) ::i
    integer(8) :: x
    character(100) :: c
    call get_command_argument(i,c)
    print*,i,c
    read(c,*) x
end function

function f2(x,t) result(v)!v es el vector de pendientes de conejos y lobos
    real(8) :: t,RasGTP
    real(8),dimension(:) :: x
    real(8),dimension(size(x)) :: v
    common RasGTP
    v(1) = ni4(x(3),x(2))-ni1(RasGTP,x(1),x(2),x(9))  !d(Raf)/dt
    v(2) = ni1(RasGTP,x(1),x(2),x(9))-ni2(RasGTP,x(1),x(2),x(9))+ni3(x(3),x(2))-ni4(x(3),x(2))!d(pRaf)/dt
    v(3) = ni2(RasGTP,x(1),x(2),x(9))-ni3(x(3),x(2))!d(ppRAF)/dt
    v(4) = ni8(x(6),x(5))-ni5(x(3),x(4),x(5))!d(MEK)/dt
    v(5) = ni5(x(3),x(4),x(5))-ni6(x(3),x(4),x(5))+ni7(x(6),x(5))-ni8(x(6),x(5))!d(pMEK)/dt
    v(6) = ni6(x(3),x(4),x(5))-ni7(x(6),x(5))!d(ppMEK)/dt
    v(7) = ni12(x(9),x(7),x(8))-ni9(x(6),x(7),x(8))!d(ERK)/dt
    v(8) = ni9(x(6),x(7),x(8))-ni10(x(6),x(7),x(8))+ni11(x(9),x(7),x(8))-ni12(x(9),x(7),x(8))!d(pERK)/dt
    v(9) = ni10(x(6),x(7),x(8))-ni11(x(9),x(7),x(8))!d(ppERK)/dt
end function

subroutine RK4(func,x0,t0,h,Nsteps,Nmeasure,unitat)
    !func :: Es sa funcio a resoldre
    !x0   :: condicio inicial
    !t0   :: temps inicial
    !h    :: pas de integracio
    !Nsteps :: Nombre de passes de iteracions que fara
    !Nmeasure :: A cada cuantes iteracions mesura
    !unitat :: On escriures s'arxiu amb els resultats
    real(8),intent(in) :: h,t0
    real(8),intent(in),dimension(:) :: x0
    interface
        function func(x,t) result(v)!func es la derivada que dependera de mi variable independiente
            real(8) :: t
            real(8), dimension(:) ::x
            real(8), dimension(size(x)) :: v
        end function 
    end interface
    integer(8) :: i
    integer(8), intent(in) :: Nsteps,Nmeasure
    integer(4), intent(in) :: unitat
    real(8) :: ti
    real(8),dimension(size(x0)) :: xi,k1,k2,k3,k4
    
    xi = x0
    ti = t0
    do i=1,Nsteps
        !print*,t0
        k1 = func(xi,ti)
        k2 = func(xi+h/2.0d0,ti+h/2.0d0)
        k3 = func(xi+h/2.0d0,ti+h/2.0d0)
        k4 = func(xi+h,ti+h)
        xi = xi + h*(k1+2.0d0*k2+2.0d0*k3+k4)/6.0d0
        if(mod(i,Nmeasure)==0)then !A cada Nmeasure pasos de integracion mido
            write(unitat,*),ti,xi,func(xi,ti)
        endif
        !...............................................................
        !Condicion de extinciom + perturbaciones (se puede borrar para generalizar)
        !----perturbacions------------------
!        if (abs(ti-90)<h/2.0d0)then
!            print*,xi(1)
!            xi(1) = xi(1)/5.0d0
!            print*,xi(1)
!        endif
        
!        !!!!!!!!!!!!!!!!!!!!!!!!!!!
!         if(abs(xi(1))<0.001)then
!            exit
!         endif
!         if(abs(xi(2))<0.001)then
!            exit
!         endif
        !...............................................................
        ti = ti+h
    enddo
    close(99)
end subroutine

end program
