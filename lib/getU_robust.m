function [fU,phiU,W ,Z] = getU_robust(formula, args, k,W ,Z)

if length(args)~=2
    disp('U(until) takes a two argument')
    assert(length(args)==2)
end


if k < h
    
    % phi1
    [fU,phi1,W ,Z] = getLTL_robust(args{1},k,W ,Z);
    
    % phi2 
    [f2,phi2,W ,Z] = getLTL_robust(args{2},k,W, Z);
    fU = [fU, f2];
    
    % [[phi1 U phi2]]_i+1
    [fU2,phiU2,W, Z] = getU_robust(formula, args, k+1,W, Z);
    fU = [fU, fU2];
    
    formulaAnd = strcat('And(', ...
        num2str(args{1}), '[',num2str(k),'],', ...
                 formula, '[',num2str(k+1),'])');
    [zAnd,Z] = getZ(formulaAnd,1,1,Z);
    fU = [fU, zAnd<=phi1, zAnd<=phiU2, zAnd>=phiU2+phi1-1];
   
    [phiU,Z] = getZ(formula,1,1,Z);

    fU = [fU, phiU>=phi2, phiU>=zAnd, phiU<=zAnd+phi2];
    
else

    [fU,phi1,W, Z] = getLTL_robust(args{1},k,W, Z);
    
    [f2,phi2,W, Z] = getLTL_robust(args{2},k,W, Z);
    fU = [fU, f2];
    
    za = [];
    zb = [];
    
    formulaOr = 'Or( ';
    for i=1:k

       [za_i,Z] = getZ(strcat('~',formula),h,1,Z); 
       za_i = za_i(i,:); 
       za = [za;za_i];
       
       formulaAnd = strcat('And(', ...
                    'zLoop', '[',num2str(i),'],', ...
        strcat('~',formula), '[',num2str(i),'])');
        [zb_i,Z] = getZ(formulaAnd,1,1,Z);  
       zb = [zb;zb_i];
       fU = [fU, zb(i)<=za(i), zb(i)<=zLoop(i), zb(i)>=za(i)+zLoop(i)-1];
       formulaOr = strcat(formulaOr, formulaAnd, ',');
    
    end
    formulaOr = strcat(formulaOr,')');
    [zOr,Z] = getZ(formulaOr,1,1,Z);
    fU = [fU, zOr<=sum(zb), repmat(zOr,k,1)>=zb];
    
    formulaAnd = strcat('And( ', ...
        num2str(args{1}), '[',num2str(k),'], ', ...
               formulaOr, '[-1]');
    [zAnd,Z] = getZ(formulaAnd,1,1,Z);
    fU = [fU, zAnd<=zOr, zAnd<=phi1, zAnd>=phi1+zOr-1];
    
    [phiU,Z] = getZ(formula,1,1,Z);
    fU = [fU, phiU<=zAnd+phi2, phiU>=phi2, phiU>=zAnd];
    
    for i=1:k-1

       formulaAnd = strcat('And( ', ...
         num2str(args{1}), '[',num2str(i),'], ', ...
      strcat('~',formula), '[', num2str(i+1),'])'); 
  
       [zAnd,Z] = getZ(formulaAnd,1,1,Z);
       [phi1_i,Z] = getZ(args{1},h,1,Z);
       phi1_i = phi1_i(i,:);  
       fU = [fU, zAnd<=za(i+1), zAnd<=phi1_i, zAnd>=za(i+1)+phi1_i-1];
       
        [phi2_i,Z] = getZ(args{2},h,1,Z);
        phi2_i = phi2_i(i,:); 
        fU = [fU, za(i)<=zAnd+phi2_i, za(i)>=phi2_i, za(i)>=zAnd];
        
    end

    [phi2_k,Z] = getZ(args{2},1,1,Z);
    phi2_k = phi2_k(k,:);
    fU = [fU, za(k)==phi2_k];
    
end
    