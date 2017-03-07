module ritmes
implicit none
real(8) :: k1,k2,V3,V4,k5,k6,V7,V8,k9,k10,V11,V12!Ratios
real(8) :: Km1,Km2,Km3,Km4,Km5,Km6,Km7,Km8,Km9,Km10,Km11,Km12,Km13,F,Kf

contains

!Definim ses velocitats de reaccions numerades segons sa taula I
function ni1(RasGTP,Raf,pRaf,ppERK) result(ni)
    real(8) :: ni,RasGTP,Raf,pRaf,ppERK
    ni = k1*RasGTP*Raf/Km1
    ni = ni/(1.0d0+(Raf/Km1)+(pRaf/Km2))
    ni = ni*((1.0d0+(F*ppERK/Kf))/(1.0d0+(ppERK/Kf)))
    !print*,'-',F,ppERK,Kf,((1.0d0+(F*ppERK/Kf))/(1.0d0+(ppERK/Kf)))
end function

function ni2(RasGTP,Raf,pRaf,ppERK) result(ni)
    real(8) :: ni,RasGTP,Raf,pRaf,ppERK
    ni = k2*RasGTP*Raf/Km2
    ni = ni/(1.0d0+(Raf/Km1)+(pRaf/Km2))
    ni = ni*((1.0d0+(F*ppERK/Kf))/(1.0d0+(ppERK/Kf)))
end function

function ni3(ppRaf,pRaf) result(ni)
    real(8) :: ni,ppRaf,pRaf
    ni = V3*ppRaf/Km3
    ni = ni/(1.0d0+(ppRaf/Km3)+(pRaf/Km4))
end function

function ni4(ppRaf,pRaf) result(ni)
    real(8) :: ni,ppRaf,pRaf
    ni = V4*ppRaf/Km4
    ni = ni/(1.0d0+(ppRaf/Km3)+(pRaf/Km4))
end function

function ni5(ppRaf,MEK,pMEK) result(ni)
    real(8) :: ni,MEK,pMEK,ppRaf
    ni = k5*ppRaf*MEK/Km5
    ni = ni/(1.0d0+(MEK/Km5)+(pMEK/Km6))
end function

function ni6(ppRaf,MEK,pMEK) result(ni)
    real(8) :: ni,MEK,pMEK,ppRaf
    ni = k6*ppRaf*pMEK/Km6
    ni = ni/(1.0d0+(MEK/Km5)+(pMEK/Km6))
end function

function ni7(ppMEK,pMEK) result(ni)
    real(8) :: ni,ppMEK,pMEK
    ni = V7*ppMEK/Km7
    ni = ni/(1.0d0+(ppMEK/Km7)+(pMEK/Km8))
end function

function ni8(ppMEK,pMEK) result(ni)
    real(8) :: ni,ppMEK,pMEK
    ni = V8*pMEK/Km8
    ni = ni/(1.0d0+(ppMEK/Km7)+(pMEK/Km8))
end function

function ni9(ppMEK,ERK,pERK) result(ni)
    real(8) :: ni,ppMEK,pERK,ERK
    ni = k9*ppMEK*ERK/Km9
    ni = ni/(1.0d0+(ERK/Km9)+(pERK/Km10))
end function

function ni10(ppMEK,ERK,pERK) result(ni)
    real(8) :: ni,ppMEK,pERK,ERK
    ni = k10*ppMEK*pERK/Km10
    ni = ni/(1.0d0+(ERK/Km9)+(pERK/Km10))
end function

function ni11(ppERK,ERK,pERK) result(ni)
    real(8) :: ni,ppERK,pERK,ERK
    ni = V11*ppERK/Km11
    ni = ni/(1.0d0+(ppERK/Km11)+(pERK/Km12)+(ERK/Km13))
end function

function ni12(ppERK,ERK,pERK) result(ni)
    real(8) :: ni,ppERK,pERK,ERK
    ni = V12*pERK/Km12
    ni = ni/(1.0d0+(ppERK/Km11)+(pERK/Km12)+(ERK/Km13))
end function

end module 
