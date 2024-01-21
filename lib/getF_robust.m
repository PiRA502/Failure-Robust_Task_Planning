function [fF,phiF,W ,Z] = getF_robust(formula,args,k,W ,Z)

if length(args)~=1
    disp('F(eventually) takes a single argument')
    assert(length(args)==1)
end


if k < h

    % phi2 
    [fF,phi2] = getLTL_robust(args{1},k,W ,Z);
    
    % F[[phi2]]_i+1
    [fU2,phiF2] = getF_robust(formula, args, k+1,W ,Z);
    fF = [fF, fU2];

    % phiF_k = Or(phi2_k,phiF_k+1)
    [phiF,Z] = getZ(formula,h,1,Z);
    phiF = phiF(k, :);  
    fF = [fF, phiF>=phi2, phiF>=phiF2, phiF<=phiF2+phi2];
    
else  
    phi1 = 1;
    [fF,phi2,W ,Z] = getLTL_robust(args{1},k,W ,Z);
    
    za = [];
    zb = [];
    
    formulaOr = 'Or(';
    for i=1:k 
       [za_i,Z] = getZ(strcat('~',formula),h,1,Z); %这里记录的是辅助变量
       za_i = za_i(i,:); 
       za = [za;za_i];
       formulaAnd = strcat('And(', ...
                    'zLoop', '[',num2str(i),'],', ...
        strcat('~',formula), '[',num2str(i),'])');

       [zb_i,Z] = getZ(formulaAnd,1,1,Z);  

       zb = [zb;zb_i];
       fF = [fF, zb(i)<=za(i), zb(i)<=zLoop(i), zb(i)>=za(i)+zLoop(i)-1];
       
       formulaOr = strcat(formulaOr, formulaAnd, ',');
    
    end
    formulaOr = strcat(formulaOr,')');
    [zOr,Z] = getZ(formulaOr,1,1,Z); 
    fF = [fF, zOr<=sum(zb), repmat(zOr,k,1)>=zb];
    
    [phiF,Z] = getZ(formula,h,1,Z);  
    phiF = phiF(k,:);
    fF = [fF, phiF<=zOr+phi2, phiF>=phi2, phiF>=zOr];
    
    for i=1:k-1
        
        [phi2_i,Z] = getZ(args{1},h,1,Z);
        phi2_i = phi2_i(i, :);
        fF = [fF, za(i)<=za(i+1)+phi2_i, za(i)>=phi2_i, za(i)>=za(i+1)];
    end

    [phi2_k,Z] = getZ(args{1},h,1,Z);
    phi2_k = phi2_k(k,:);
    fF = [fF, za(k)==phi2_k];

    
end
    