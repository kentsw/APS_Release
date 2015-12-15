



    matfile = '/data/URY/segy/2014_BG_water_column_imaging/conditioned_datasets/cdps/4150A216/gridfit_rms_picks_2000x100_4150A216.mat';
    load(matfile,'alllocs','alltimes','gridtv','dec_ilxl','datadir','stack_all');
   
    % interval vels at pick locations =========================================
    
    % decimate original pick times onto new grid
           
    alllocs10=alllocs(mod(alllocs,10)==mod(dec_ilxl(1,2),10));
    alltimes10=alltimes(mod(alllocs,10)==mod(dec_ilxl(1,2),10));
    numpicks10=size(alllocs10,2);
    allsmvels10=zeros(1,numpicks10);
    
    % extract smoothed vels at picked locations
    alllocs_grid = ((alllocs10-dec_ilxl(1,2))./10)+1;
    
    for ii=1:numpicks10
        allsmvels10(ii)=gridtv(ceil(alltimes10(ii)/10),alllocs_grid(ii));
        
    end
    
    % interval velocities
    
    allvint10=zeros(size(allsmvels10));
    
    for trace = dec_ilxl(:,2)';
        picks=alllocs10==trace;
        ttimes=alltimes10(picks);
        vrms=allsmvels10(picks);
        tts = [0 ttimes(1:end-1)];
        vrms_s = [vrms(1) vrms(1:end-1)];
        allvint10(picks) = sqrt(((vrms.^2.*ttimes) - (vrms_s.^2.*tts)) ./ (ttimes-tts));
        
    end
    
    % copy each pick to immediately after previous pick
    % then interp1d to fill between
    % and reshape to make into a grid
    
    
    alltimes10_2 = zeros(size(alltimes10,2)*2-1,1);
    allvels10_2 = zeros(size(allvint10,2)*2-1,1);
    
    alltimes10_2(1:2:end)=round(alltimes10+(alllocs_grid-1).*5100);
    alltimes10_2(2:2:end-1)=round(alltimes10(1:end-1)+1+(alllocs_grid(1:end-1)-1).*5100);
    
    allvels10_2(1:2:end)=allvint10;
    allvels10_2(2:2:end-1)=allvint10(2:end);
    
    dec_traces = size(dec_ilxl,1);
    
    grid_vint = reshape(interp1(alltimes10_2,allvels10_2,1:5100*dec_traces),5100,dec_traces);
    
    % ========================================================================================
    


% gridded dix interval velocities for shallow =============================
% this is necessary to merge in the direct arrival velocities


% vint_shallow=zeros(50,dec_traces);

grid_vint2=zeros(size(gridtv));

for trace = 1:size(gridtv,2);
    
    ttimes = (10:10:5000)';
    vrms = gridtv(:,trace);
    
    tts = [0;ttimes(1:end-1)];
    vrms_s = [vrms(1);vrms(1:end-1)];
    
    grid_vint2(:,trace) = sqrt(((vrms.^2.*ttimes) - (vrms_s.^2.*tts)) ./ (ttimes-tts));
    
    % vint_merge(:,trace) = interp1([10:10:200 250:5000],[vint_shallow(1:20,trace)' grid_vint(250:5000,trace)'],1:5000,'linear','extrap');
end



    % plot vint and stack

    scrsz = get(0,'ScreenSize'); % get size of screen to use for controlling size of plot
    
    vint_plot = figure('Name','Interval velocities line 4150A216','OuterPosition',[1 scrsz(4) scrsz(3)/2 scrsz(4)]); 
    imagesc(grid_vint); caxis([1.48 1.54]); colorbar; 
    
    vint_plot2 = figure('Name','Interval velocities line 4150A216','OuterPosition',[1 scrsz(4) scrsz(3)/2 scrsz(4)]); 
    imagesc(grid_vint2); caxis([1.48 1.54]); colorbar; 

    % hold all; 
%    scatter(alllocs_grid,alltimes10,10,'black','filled');
%    plotfile=strcat(datadir,'/interval_velocity_',linenames{line},'.png');
%     saveas(vint_plot,plotfile);
%     close(vint_plot);
    
    stack_plot = figure('Name','Constant velocity stack line 4150A216','OuterPosition',[1 scrsz(4) scrsz(3)/2 scrsz(4)]);
    imagesc(stack_all); colormap(gray); caxis([-0.1 0.1])
%    plotfile=strcat(datadir,'/const_vel_stack_',linenames{line},'.png');
%     saveas(stack_plot,plotfile);
%     close(stack_plot);
     


