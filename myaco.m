% 1.Main program of ACO (myaco.m)
% 2.Function to generate solution (ant_root.m)
% 3.Function to calculate the cost (distance) (calculate.m)
% 4.Function to update the traces (update.m)
% function myaco(num_of_nodes,num_of_ants, max_iteration)
function myaco()
% inputs
miter=10;
m=10;
n=10;
% parameters
e=.15;            % evaporation coefficient.
alpha=1;          % effect of ants sight.
beta=4;           % trace's effect.
t=0.0001*ones(n); % primary tracing.
el=.97;           % common cost elimination. 
% Generate coordinates of cities and plot
for i=1:n
    x(i)=rand*20;
    y(i)=rand*20;
end    
subplot(3,1,1);
plot(x,y,'o','MarkerFaceColor','k','MarkerEdgeColor','b','MarkerSize',10);
title('Coordinates of Cities');
xlabel('x  (km)');
ylabel('y  (km)');
% generating distace between cities matrix.
for i=1:n
    for j=1:n
        d(i,j)=sqrt((x(i)-x(j))^2+(y(i)-y(j))^2);
    end
end
% generating sight matrix.
for i=1:n
    for j=1:n
        if d(i,j)==0
            h(i,j)=0;
        else
            h(i,j)=1/d(i,j);
        end
    end
end
for i=1:miter
% Step 1: Forward ants and solution construction
% Generate places for each ant    
for j=1:m
    start_places(j,1)=fix(1+rand*(n-1));
end
% Step 2:probabilistic solution contruction   
    [tour]=ant_root(start_places,m,n,h,t,alpha,beta);
    tour=horzcat(tour,tour(:,1));
% Step 3: Calculate the cost --> total distace
    [cost,f]=calculate(m,n,d,tour,el);
    [t]=update(m,n,t,tour,f,e);
    average_cost(i)=mean(cost);    
% Step 4: Determine the best route
    [min_cost(i),best_index]=min(cost);
    besttour(i,:)=tour(best_index,:);
    iteration(i)=i;
end
% Plot Average of tour distance vs Number of Iterations
subplot(3,1,2);plot(iteration,average_cost);
title('Average of tour distance vs Number of iterations');
xlabel('iteration');
ylabel('distance (km)');
% Plot the best route
[k,l]=min(min_cost);
for i=1:n+1
    X(i)=x(besttour(l,i));
    Y(i)=y(besttour(l,i));
end
subplot(3,1,3);plot(X,Y,'--o',...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',10)
xlabel('x (km)');ylabel('y (km)');
title(['minimum cost (total length)= ',num2str(k)]);
end
    % % % % % % % % % % % % % % % % %
  % %       Saurabh  Yadav          % %
% %           B.Tech CSE             % %
% %  Lovely Professional University  % %
  % %       +919457761570           % %
    % % % % % % % % % % % % % % % % %
