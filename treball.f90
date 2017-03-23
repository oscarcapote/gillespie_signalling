program gillespie
use ritmes
implicit none
real(8),dimension(12) :: Pr!Ratios i probabilitats de donar una reaccio
real(8) ::RasGTP,Raf,pRaf,ppRaf,MEK,pMEK,ppMEK,ERK,pERK,ppERK!Magnituds dinamiques
real(8) :: suma,a0,factor,tFinal,rnd2,a,ba!,ran2
real(8) :: t,tau,rnd!Temps actual,temps estocastic i variable aleatoria entre 0 i 1
integer(8) :: mu,MaxItt,itt,Nmeasure,Nitt
character(2) :: opt


!----------------------INICIALITZACIO---------------------
!!--Condicions inicials--

!Llegim argument passat per linia de comandes per part de s'usuari
!Per defecte simulara a
call get_command_argument(1,opt)
if(opt==''.or.opt=='a')then
    include './declarations/declaration_a.dec'
elseif(opt=='a0')then
    include './declarations/declaration_a0.dec'
elseif(opt=='b')then
    include './declarations/declaration_b.dec'
elseif(opt=='c')then
    include './declarations/declaration_c.dec'
elseif(opt=='d')then
    include './declarations/declaration_d.dec'
elseif(opt=='e')then
    include './declarations/declaration_e.dec'
elseif(opt=='f')then
    include './declarations/declaration_f.dec'
endif
t=0
itt=1
tFinal = 100
MaxItt=1000000!-1492324
Nitt = 100!Cada cuantes iteracions vull printar resultats
Nmeasure = 1
!Parametres per reescalar U(0,1) i evitar que surti 0: Passa a ser U(a,1)
a = 0.0000000001
ba = 1.0d0-a
!----------------------------------------------------------
do
!------------------UPDATE DE PROBABILITATS-----------------
call prob_compute(Pr,a0)
!print*,Raf,pRaf,ppRaf,MEK,pMEK,ppMEK,ERK,pERK,ppERK
!print*,Pr!,a0,mu
!read(*,*)
!----------------------------------------------------------

!-------------------MONTECARLO TIME STEP-------------------
rnd2= a+ba*rand()!rand()
tau = -log(rnd2)/(a0/factor)!Temps per que passi una reaccio
rnd =rand()
mu = 1!Reaccio qua pasara
suma =Pr(mu)
!print*,'Probabilitats',Pr
do while(rnd>suma)
    mu = mu+1
    suma = suma+Pr(mu)
enddo
!read(*,*)
t = t+(tau/60.0d0)
call reaction(mu)
if(mod(itt,Nitt)==0)then
    print*,t,Raf,pRaf,ppRaf,MEK,pMEK,ppMEK,ERK,pERK,ppERK,Pr,a0,mu
    Nmeasure = Nmeasure +1
endif
if(Nmeasure==MaxItt.or.t>tFinal)then!Si em pas de nombre de mesures o arribo a un temps maxim, acabo simu
    print*,t,Raf,pRaf,ppRaf,MEK,pMEK,ppMEK,ERK,pERK,ppERK,Pr,a0,mu
    stop
endif
itt=itt+1
enddo
!----------------------------------------------------------
contains

subroutine prob_compute(Pr,a0)
    real(8),dimension(12) :: Pr!Ratios i probabilitats de donar una reaccio
    real(8) :: a0
    !Pr = a
    !print*,a
    Pr(1) = ni1(RasGTP,Raf,pRaf,ppERK)
    Pr(2) = ni2(RasGTP,Raf,pRaf,ppERK)
    Pr(3) = ni3(ppRaf,pRaf)
    Pr(4) = ni4(ppRaf,pRaf)
    Pr(5) = ni5(ppRaf,MEK,pMEK)
    Pr(6) = ni6(ppRaf,MEK,pMEK)
    Pr(7) = ni7(ppMEK,pMEK)
    Pr(8) = ni8(ppMEK,pMEK)
    Pr(9) = ni9(ppMEK,ERK,pERK)
    Pr(10) = ni10(ppMEK,ERK,pERK)
    Pr(11) = ni11(ppERK,ERK,pERK)
    Pr(12) = ni12(ppERK,ERK,pERK)
    a0 = sum(Pr)
!    print*,Pr,a0
!    read(*,*)
    !print*,Pr
    Pr = Pr/a0
end subroutine

subroutine reaction(mu)
!Feim sa reaccio triada
    integer(8),intent(in) :: mu
    !print*,'mu',mu
    if(mu==1)then
        Raf = Raf-factor
        pRaf = pRaf+factor
        !print*,'AQUI!!!!',pRaf,Raf,RasGTP,ppERK,Pr(2)
    elseif(mu==2)then
        pRaf = pRaf-factor
        ppRaf = ppRaf+factor
    elseif(mu==3)then
        pRaf = pRaf+factor
        ppRaf = ppRaf-factor
    elseif(mu==4)then
        Raf = Raf+factor
        pRaf = pRaf-factor
    elseif(mu==5)then
        MEK = MEK - factor
        pMEK = pMEK + factor
    elseif(mu==6)then
        pMEK = pMEK - factor
        ppMEK = ppMEK + factor
    elseif(mu==7)then
        pMEK = pMEK + factor
        ppMEK = ppMEK - factor
    elseif(mu==8)then
        MEK = MEK + factor
        pMEK = pMEK - factor
    elseif(mu==9)then
        ERK = ERK - factor
        pERK = pERK + factor
        !print*,'9:',ppMEK,pERK,factor,1.0d0/315.31118266529563d0
    elseif(mu==10)then
        pERK = pERK - factor
        ppERK = ppERK + factor
    elseif(mu==11)then
        pERK = pERK + factor
        ppERK = ppERK - factor
    elseif(mu==12)then
        ERK = ERK + factor
        pERK = pERK - factor
    endif
end subroutine

!include 'ran2.f'
end program
