function [wb_idx] = water_bottom_picker(traces,padding)
% Water bottom flatten function
% Input:
% Output:   

    exponent = 12;
    %[~, wb_idx] = max(traces);
    %med_wb_idx = median(wb_idx)-10;
    inverse_gain = (size(traces,1):-1:1)'.^exponent;
    %inverse_gain = circshift(inverse_gain,med_wb_idx); 
    traces = abs(bsxfun(@times,double(traces),inverse_gain));   
    [~, wb_idx] = max(traces);
    filtw = [1 2 3 3 3 3 3 3 3 3 2 1]/30;
    for i_trace = 1:1:size(traces,2);
        conv_traces(:,i_trace) = conv(traces(:,i_trace),filtw,'same');
    end
    linearInd = sub2ind(size(traces), wb_idx, 1:1:size(traces,2));
    trace_divide = bsxfun(@rdivide,traces-conv_traces,traces(linearInd)-conv_traces(linearInd));
    
    trace_divide = bsxfun(@times,trace_divide > 0.3,(1:1:size(traces,1))');
    trace_divide(trace_divide == 0) = NaN;
    [wb_idx,~] = min(trace_divide);
   
    wb_idx = wb_idx-padding;
    wb_idx(isnan(wb_idx)) = 1;
    wb_idx(wb_idx < 1) = 1;
    %wb_idx = medfilt1(wb_idx,20);
    % add header to scan file
    
    
% x = 0:10;
% y = sin(x);
% xx = 0:.25:10;
% yy = spline(x,y,xx);
% peaks = false(size(yy));
% peaks(2:end-1) = sign(x(2:end-1)-x(1:end-2)) + sign(x(2:end-1)-x(3:end)) > 1;

    
    
end