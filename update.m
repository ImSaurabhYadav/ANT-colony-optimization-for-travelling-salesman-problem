function [t]=update(m,n,t,tour,f,e);
for i=1:m
    for j=1:n
        dt=1/f(i);
        t(tour(i,j),tour(i,j+1))=(1-e)*t(tour(i,j),tour(i,j+1))+dt;
    end
end
