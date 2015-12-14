function [] =ava_qc_plot(job_meta_path,i_block)
%% FUNCTION FOR PRE DIGI QC. PLOTS FOR GIVEN BLOCK
% Plots AVA of RMS Amplitude,
% Plots AVA of Variance
%%
close all;
job_meta = load(job_meta_path);

plotype =2;% plot type 1 menas vertical plot 2 means horizontal plot

qc_filepath = strcat(job_meta.ava_qc_directory,'ava_qc_',i_block,'.mat');
ava_qc=load(qc_filepath);

angles=job_meta.tkey_min:job_meta.tkey_inc:job_meta.tkey_max;
% angles=sind(angles).^2;
figure(1);
subplot(1,2,1);plot(ava_qc.rms);
xlabel( 'angle'); ylabel( 'RMS Amplitude');
subplot(1,2,2);plot(ava_qc.var);
xlabel( 'angle'); ylabel( 'Variance');

% figure(2);
% for k=1:ava_qc.n_win
%     t=strcat('z below wb: ',num2str(((k-0.5)*job_meta.ns_overlap_qc*job_meta.s_rate/1000)),'m/ms');
%     subplot(ava_qc.n_win,2,(2*k-1));
%     scatter(angles,ava_qc.rms(:,k),'MarkerEdgeColor','b','MarkerFaceColor','c');xlim([min(angles) max(angles)]);
%     xlabel( 'angle'); ylabel( 'RMS Amp');grid on;
%     title (t);
% 
%     
%     subplot(ava_qc.n_win,2,2*k);
%     scatter(angles,ava_qc.var(:,k),'MarkerEdgeColor','r','MarkerFaceColor','y');xlim([min(angles) max(angles)]);
%     xlabel( 'angle'); ylabel( 'Variance');grid on;
%     title (t);
% end

figure(3);
for k=1:ava_qc.n_win
    t=strcat('z below wb: ',num2str(((k-0.5)*job_meta.ns_overlap_qc*job_meta.s_rate/1000)),'m/ms');
    if plotype==1
        subplot(ava_qc.n_win,2,(2*k-1));
    elseif plotype==2
        subplot(2,ava_qc.n_win,k);
    end
    scatter(angles,ava_qc.rms(:,k)/max(ava_qc.rms(:,k)),'MarkerEdgeColor','b','MarkerFaceColor','c');xlim([min(angles) max(angles)]);
    xlabel( 'angle'); ylabel( 'Norm RMS');grid on;
    title (t);
    
    if plotype==1
        subplot(ava_qc.n_win,2,2*k);
    elseif plotype==2
        subplot(2,ava_qc.n_win,ava_qc.n_win+k);
    end
    
    scatter(angles,ava_qc.var(:,k)/max(ava_qc.var(:,k)),'MarkerEdgeColor','r','MarkerFaceColor','y');xlim([min(angles) max(angles)]);
    xlabel( 'angle'); ylabel( 'Norm Var');grid on;
    title (t);
end


end