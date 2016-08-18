function [Rv] = GetClosestTarget(result)
% Given the coordinates of the targets from the call to GetSensorTargets()
% calculate the closest one and return its' coordinates

N=result.Length;
radius=zeros(N,1);
targ=zeros(N,3);
for k=1:N
    targ(k,:)=[result(k).xPosCm,result(k).yPosCm,result(k).zPosCm];
    radius(k,:)=sqrt(targ(k,1)^2+targ(k,2)^2+targ(k,3)^2);
end

    [val,index]=min(radius(radius>0));
   
    Xtarg=targ(index,1);
    Ytarg=targ(index,2);
    Ztarg=targ(index,3);
    
    Rv=[Xtarg;Ytarg;Ztarg];

end

