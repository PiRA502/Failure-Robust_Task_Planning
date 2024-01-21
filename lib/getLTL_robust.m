function [fLTL,phi,W,Z] = getLTL_robust(formula,k,W,Z)

[Op,args] = parseLTL(formula);  

switch Op
    case 'And'
        [fLTL,phi, W,Z] = getAnd_robust(formula,args,k, W, Z);
    case 'Or'
        [fLTL,phi,W,Z] = getOr_robust(formula,args,k,W,Z);
    case 'Neg'
        [fLTL,phi,W,Z] = getNeg_robust(formula,args,k,W,Z);
    case 'AndI'
        [fLTL,phi,W,Z] = getAndI_robust(formula,args,k,W,Z);
    case 'G'
        [fLTL,phi,W,Z] = getG_robust(formula,args,k,W,Z);
    case 'F'
        [fLTL,phi,W,Z] = getF_robust(formula,args,k,W,Z);
    case 'U'
        [fLTL,phi,W,Z] = getU_robust(formula,args,k,W,Z);
    case 'FG'
        [fLTL,phi,W,Z] = getFG_robust(formula,args,k,W,Z);
    case 'GF'
        [fLTL,phi,W,Z] = getGF_robust(formula,args,k, W, Z);
    otherwise
        disp('wrong formula');

end


    