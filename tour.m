% function to calculate one cycle tour

function [p]=ant_tour(start,m,n,h,t,a,b);
for i=1:m
    mh=h;
    for j=1:n-1
        c=p(i,j);
        mh(:,c)=0;
        temp=(t(c,:).^b).*(mh(c,:).^a);
        s=(sum(temp));
        p=(1/s).*temp;
        r=rand;
        s=0;
        for k=1:n
            s=s+p(k);
            if r<=s
                p(i,j+1)=k;
                break
            end
        end
    end
end
p=start;
