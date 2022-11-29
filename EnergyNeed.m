
% clearvars
% close all

UWall=[0.125 , 0.275];
%UWall=UWall.';
Ti=22;

Tu = readmatrix("C:\Users\arnkepet\Dropbox\FagligeTing\02-Verktoy\klimadata\Byggforsk\NOR_Oslo_Blindern_v140821.epw",'FileType','text','Range',"G10:G8769");
% HeatLossWall = U * (Ti - Tu);
% HeatLossWall = max(HeatLossWall,0);
% HeatLossWallOslo=sum(HeatLossWall)/1000
HeatLossWallOsloBlindern = sum(max((Ti - Tu) .* UWall,0))/1000 ; % kWh/year/m2

Tu = readmatrix("C:\Users\arnkepet\Dropbox\FagligeTing\02-Verktoy\klimadata\Byggforsk\NOR_Rogaland_Sola_v140821.epw",'FileType','text','Range',"G10:G8769");
HeatLossWallSola = sum(max((Ti - Tu) .* UWall ,0))/1000 ; % kWh/year/m2

% Tu = readmatrix("C:\Users\arnkepet\Dropbox\FagligeTing\02-Verktoy\klimadata\Byggforsk\NOR_Vest-Agder_Kjevik_v140821.epw",'FileType','text','Range',"G10:G8769");
% HeatLossWallKjevik = sum(max((Ti - Tu) .* UWall,0))/1000 ; % kWh/year/m2

Tu = readmatrix("C:\Users\arnkepet\Dropbox\FagligeTing\02-Verktoy\klimadata\Byggforsk\NOR_Østfold_Rygge_v140821.epw",'FileType','text','Range',"G10:G8769");
HeatLossWallRygge = sum(max((Ti - Tu) .* UWall,0))/1000 ; % kWh/year/m2

Tu = readmatrix("C:\Users\arnkepet\Dropbox\FagligeTing\02-Verktoy\klimadata\Byggforsk\NOR_Nordland_Tromsø-Langnes_v140821.epw",'FileType','text','Range',"G10:G8769");
HeatLossWallLangnes = sum(max((Ti - Tu) .* UWall,0))/1000 ; % kWh/year/m2

Tu = readmatrix("C:\Users\arnkepet\Dropbox\FagligeTing\02-Verktoy\klimadata\Byggforsk\NOR_Sør-Trøndelag_Værnes_v140821.epw",'FileType','text','Range',"G10:G8769");
HeatLossWallVaernes = sum(max((Ti - Tu) .* UWall,0))/1000 ; % kWh/year/m2

HeatLoss = figure;
hold on
plot(UWall,HeatLossWallOsloBlindern)
plot(UWall,HeatLossWallSola)
%plot(UWall,HeatLossWallKjevik)
plot(UWall,HeatLossWallRygge)
plot(UWall,HeatLossWallLangnes)
plot(UWall,HeatLossWallVaernes)

title('HeatLoss as a function of location and U-value')
% legend('Emissions from electricity','Location','northeast')

catnames = {'Oslo','Sola','Rygge','Tromsø','Trondheim'};%'Agder',
X = categorical(catnames); %,HeatLossWall,catnames,'Ordinal',true);
xlabel('U-value [W/m^2K]')
ylabel('HeatLossWall per year [kWh/m^2]')
legend(X,'Location','northwest')
box on
saveas(gcf,'HeatlossLocations.png')
hold off


HeatLossWall = [ HeatLossWallOsloBlindern ; HeatLossWallSola ; HeatLossWallRygge; HeatLossWallLangnes; HeatLossWallVaernes];%HeatLossWallKjevik ; 

% HeatLossWall = [ HeatLossWallOsloBlindern , HeatLossWallSola, HeatLossWallKjevik , HeatLossWallRygge, HeatLossWallLangnes, HeatLossWallVaernes];

% catnames = {'Oslo','Sola','Agder','Rygge','Tromsø','Trondheim'};
% X = categorical(catnames); %,HeatLossWall,catnames,'Ordinal',true);
% X = reordercats(X,catnames);
% bar(X,HeatLossWall)
% ylabel("HeatLossWall per year [kWh/m^2]")
% box on
% saveas(gcf,'HeatLossWall.png')

clear Tu Ti X