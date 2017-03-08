program gillespie
use ritmes
implicit none
real(8),dimension(12) :: Pr!Ratios i probabilitats de donar una reaccio
real(8) ::RasGTP,Raf,pRaf,ppRaf,MEK,pMEK,ppMEK,ERK,pERK,ppERK!Magnituds dinamiques
real(8) :: suma,a0,factor
real(8) :: t,tau,rnd!Temps actual,temps estocastic i variable aleatoria entre 0 i 1
integer(8) :: mu,MaxItt,itt

!----------------------INICIALITZACIO---------------------
!--Condicions inicials--
    factor = 1.0d0/315.31118266529563d0
    RasGTP=10.0d0
    Raf=300.0d0
    pRaf=0.0d0
    ppRaf=0.0d0
    MEK=300.0d0
    pMEK=0.0d0
    ppMEK=0.0d0
    ERK=300.0d0
    pERK=0.0d0
    ppERK=0.0d0

!--Parametres--
    k1=1.0d0
    k2=0.25d0
    V3=100.0d0
    V4=3.750d0
    k5=2.5d0
    k6=0.5d0
    V7=3.0d0
    V8=3.75d0
    k9=0.125d0
    k10=0.125d0
    V11=3.75d0
    V12=5.0d0


    Km1=100.0d0
    Km2=200.0d0
    Km3=50.0d0
    Km4=100.0d0
    Km5=250.0d0
    Km6=250.0d0
    Km7=250.0d0
    Km8=80.0d0
    Km9=250.0d0
    Km10=250.0d0
    Km11=120.0d0
    Km12=20.0d0
    Km13=300.0d0
    F=1.0d0!???
    Kf=25.0d0!???

t=0
itt=1
MaxItt=500000!-1492324
!call srand(9)
!----------------------------------------------------------
do
!------------------UPDATE DE PROBABILITATS-----------------
call prob_compute(Pr,a0)
!----------------------------------------------------------

!-------------------MONTECARLO TIME STEP-------------------
tau = -log(rand())/(a0)!Temps per que passi una reaccio
rnd = rand()
mu = 1!Reaccio qua pasara
suma =Pr(mu)
do while(rnd>suma)
    mu = mu+1
    suma = suma+Pr(mu)
enddo
t = t+(tau/60.0d0)
call reaction(mu)
print*,t,Raf,pRaf,ppRaf,MEK,pMEK,ppMEK,ERK,pERK,ppERK,Pr,a0,mu
if(itt==MaxItt.or.t>100)then
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
    !print*,Pr,a0
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


end program
