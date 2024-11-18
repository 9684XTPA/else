%Roulette

clear
close all

bet=50;    % bet value on each
start=300;   % Total money you have at the beginning
% result=start;
simu=5000;

times_play=2;   % simulated play times
times_real=0;    %times that actually played

type=37;     % European=37   American=38
% type=1/type;

p_even=18/type;
p_color=18/type;
p_dozen=12/type;

win=zeros(1,times_play+1);   % money win & lose in each round
left=zeros(1,times_play+1);   % money left after each round
result=zeros(1,simu);     % money left for each simulation
BROKE=0;

left(1)=start;

for j=1:simu

for i=1:times_play

    times_real=i;

    r1=rand;
    r2=rand;
    r3=rand;

    % win & lose
    if r1<=p_even
        gain1=bet;
    else
        gain1=-bet;
    end

    if r2<=p_color
        gain2=bet;
    else
        gain2=-bet;
    end
        
    if r3<=p_dozen
        gain3=bet*2;
    else
        gain3=-bet;
    end

    win(i+1)=gain1+gain2+gain3;    % win in this round

    % money left in this round
%     if i==1
%         left(i+1)=start+win(i+1);
%     else
        left(i+1)=left(i)+win(i+1);
%     end

    % check if have enough money for next round
    if left(i+1)<3*bet
        break;
    end

end


win;

left;

result(j)=left(times_real+1);

if j==1 
    figure 
end

plot(1:times_real+1,left(1:times_real+1),'-.')
hold on

if (times_real~=times_play)||(left(end)<3*bet)
    plot(times_real+1,result(j),'k.','MarkerSize',20)
    BROKE=BROKE+1;
end

end

plot([0 times_play+1],[start,start],'b--')
plot([0 times_play+1],[3*bet,3*bet],'k-')
hold off

xlim([0 times_play+1])
ylim([0 inf])

figure
% boxplot(result-start,'BoxStyle','outline','Notch','marker')
swarmchart(ones(1,simu),result-start,50,'filled')
ylim([-start inf])

WIN=length(find(result>=start))/simu
LOSE=1-WIN
BROKE
Rate=BROKE/simu;
BROKE_Rate=sprintf([num2str(Rate*100) '%%'])


