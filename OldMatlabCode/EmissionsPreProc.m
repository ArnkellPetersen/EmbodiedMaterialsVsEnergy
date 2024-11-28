
% Temporal adjustement according to Reisch
Tend = 100; % Time for temporal adjustment
Y =1:Tend;
T= tadj(Y);
TemporalAdjustment = figure;
plot(Y,T)
title('Temporal adjustment of GWP')
xlabel('Year')
ylabel('Reduction in GWP [%]')
box on
saveas(gcf,'TemporalAdjustment.png')

% Electricity mix NO + EU28
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%sjekkes !!!!
NOEU28=[2023	2024	2025	2026	2027	2028	2029	2030	2031	2032	2033	2034	2035	2036	2037	2038	2039	2040	2041	2042	2043	2044	2045	2046	2047	2048	2049	2050	2051	2052	2053	2054	2055	2056	2057	2058	2059	2060	2061	2062	2063	2064	2065	2066	2067	2068	2069	2070	2071	2072	2073	2074	2075	2076	2077	2078	2079	2080	2081

318	306	295	284	272	261	250	239	227	216	205	193	182	171	160	148	137	126	114	103	92	80	69	58	47	35	24	24	24	24	24	24	24	24	24	24	24	24	24	24	24	24	24	24	24	24	24	24	24	24	24	24	24	24	24	24	24	24	24
];

NS3720 = figure;
plot(NOEU28(1,:),NOEU28(2,:))
title('Emissions from electricity NO + EU28')
legend('Emissions from electricity','Location','northeast')
xlabel('Year')
ylabel('CO_2 [kgCO_2e/kWh]')
box on
saveas(gcf,'NS3720.png')

% electricity mix weighed with a set SCOP of 3
NOEU28SCOP = NOEU28(2,:)/3;

NS3720SCOP = figure;
hold on
plot(NOEU28(1,:),NOEU28(2,:))
plot(NOEU28(1,:),NOEU28SCOP(1,:))
legend({'Emissions from electricity','Emissions from thermal energy'},'Location','northeast')
%legend('Emissions from electricity','Location','northeast')
title({'Emissions from electricity NO + EU28 and ',' thermal energy based on SCOP of 3'})
xlabel('Year')
ylabel('CO_2 [kgCO_2e/kWh]')
box on
saveas(gcf,'NS3720-EaT.png')
hold off

% emission calculations weighed a temporal factor
StartYear=2025;
Toffset=-(NOEU28(1,1)-StartYear)+1;
T2=T(:,Toffset:length(NOEU28(1,:)));
TemporalEmissions= [NOEU28(2,Toffset:end); NOEU28SCOP(1,Toffset:end) ].*T2/100;

TemporalEmissionsFig = figure;
hold on
plot(NOEU28(1,Toffset:end),TemporalEmissions(1,:))
plot(NOEU28(1,Toffset:end),TemporalEmissions(2,:))
legend({'Temporal emissions from electricity','Temporal emissions from thermal energy'},'Location','northeast')
title({'Temporal emissions from electricity NO + EU28',' and thermal energy based on SCOP of 3'})
xlabel('Year')
ylabel('CO_2 [kgCO_2e/kWh]')
box on
saveas(gcf,'TemporalEmissions.png')
hold off

% Allowance for an investement
a=15;
TPL=movsum(TemporalEmissions,[0 a],2);
TPL15=TPL(:,1:end-a);
YTPL15=NOEU28(1,Toffset:end-a);
a=25;
TPL=movsum(TemporalEmissions,[0 a],2);
TPL25=TPL(:,1:end-a);
YTPL25=NOEU28(1,Toffset:end-a);
a=35;
TPL=movsum(TemporalEmissions,[0 a],2);
TPL35=TPL(:,1:end-a);
YTPL35=NOEU28(1,Toffset:end-a);
a=45;
TPL=movsum(TemporalEmissions,[0 a],2);
TPL45=TPL(:,1:end-a);
YTPL45=NOEU28(1,Toffset:end-a);


AllowanceEL = figure;
hold on
plot(YTPL15,TPL15(1,:))
plot(YTPL25,TPL25(1,:))
plot(YTPL35,TPL35(1,:))
plot(YTPL45,TPL45(1,:))
legend({'Investment lifetime 15 years','Investment lifetime 25 years','Investment lifetime 35 years','Investment lifetime 45 years'},'Location','northeast')
title({'CO_2  Allowance for an investement with different lifetimes','provided the energy saved is electricity'})
xlabel('Year')
ylabel('CO_2 [kgCO_2e]')
box on
saveas(gcf,'Allowance-el.png')
hold off

AllowanceHP = figure;
hold on
plot(YTPL15,TPL15(2,:))
plot(YTPL25,TPL25(2,:))
plot(YTPL35,TPL35(2,:))
legend({'TPL 15','TPL 25','TPL 35'},'Location','northeast')
title({'CO_2  Allowance for an investement with different lifetimes','provided the energy saved has a SCOP of 3'})
xlabel('Year')
ylabel('CO_2 [kgCO_2e]')
box on
saveas(gcf,'Allowance-HP.png')
hold off

% TPLF25=movsum(TemporalEmissions,25)
% YTPLF25=[NOEU28(1,1):NOEU28(1,1)+length(TPLF25)-1]
% TPLF35=movsum(TemporalEmissions,15)
% YTPLF15=[NOEU28(1,1):NOEU28(1,1)+length(TPLF15)-1]
% Lifetimes=[15;20;25;30;35]
% TPLFEL=[]

% for n=1:length(Lifetimes)
%      if n == 1
%          TPLFEL= movsum(TemporalEmissions(1,:,2),Lifetimes(1,1))
%      else
%         TPLFEL=[TPLFEL; movsum(TemporalEmissions,Lifetimes(n,1))]
%      end
% end

%cumulative temporalemissions
% TemRun=[];
% for n=1:length(TemporalEmissions)
%     TemRun= [cumsum(TemporalEmissions(1,1:n)); cumsum(TemporalEmissions(2,1:n))];
% end


CumTemporalEmissionsFig = figure;
hold on
plot(1:length(TemporalEmissions),TemRun(1,:))
plot(1:length(TemporalEmissions),TemRun(2,:))
legend({'CumTemporal emissions from electricity','CumTemporal emissions from thermal energy'},'Location','southeast')
title({'CumTemporal emissions from electricity NO + EU28 and',' thermal energy starting in 2035 & based on SCOP of 3'})
xlabel('Year')
ylabel('CO_2 [kgCO_2e/kWh]')
box on
saveas(gcf,'CumTemporalEmissions.png')
hold off

% clear n T T2 Toffset Y Tend a 

% function for temporal adjustment. 
function Tadj = tadj(x)
    Tadj =100* (2-exp(log(2)/max(x)*x));
end

