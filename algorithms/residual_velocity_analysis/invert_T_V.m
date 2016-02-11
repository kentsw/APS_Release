clear all
%% ------------------ Disclaimer  ------------------
% 
% BG Group plc or any of its respective subsidiaries, affiliates and 
% associated companies (or by any of their respective officers, employees 
% or agents) makes no representation or warranty, express or implied, in 
% respect to the quality, accuracy or usefulness of this repository. The code
% is this repository is supplied with the explicit understanding and 
% agreement of recipient that any action taken or expenditure made by 
% recipient based on its examination, evaluation, interpretation or use is 
% at its own risk and responsibility.
% 
% No representation or warranty, express or implied, is or will be made in 
% relation to the accuracy or completeness of the information in this 
% repository and no responsibility or liability is or will be accepted by 
% BG Group plc or any of its respective subsidiaries, affiliates and 
% associated companies (or by any of their respective officers, employees 
% or agents) in relation to it.
%% ------------------ License  ------------------ 
% GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007
%% github
% https://github.com/AnalysePrestackSeismic/
%% ------------------ FUNCTION DEFINITION ---------------------------------
x = [100:100:3000];
v = [2000; 3000; 3500];
T = [2; 2.5; 4];

% v2 = 3000;
% T2 = 2.5;
% 
% v3 = 3500;
% T3 = 4;
for ii = 1:length(v);
    ti(:,ii) = T(ii)^2 + (x.^2/v(ii)^2);
end
ti = sqrt(ti);
tol = 1e-10;
iter = 100;

op3 = [ones(1,length(x)); x.^2]';
op3 = blkdiag(op3,op3,op3);

%a3 = lsqr(@,(ti(:).^2),tol,iter,[],[]);

a3 = lsqr(op3,(ti(:).^2),tol,iter,[],[]);

v_in = v
T_in = T

count = 1;
for ii = 2:2:6
    v_est(count) = 1/sqrt(a3(ii));  
    count = count + 1;
end

count = 1;
for ii = 1:2:6
    t_est(count) = sqrt(a3(ii));
    count = count + 1;
end

v_est
t_est

% plot(x,-ti);
% 
% ti = diff(ti);
% ti = cumsum(ti);
% %ti = ti - ti(1);
% ti = [0 , ti];
% tau = ti;
% 
% tol = 1e-5;
% iter = 100;
% 
% op = [x.^2; -2.*tau]';
% 
% b = (tau.^2);
% (((op'*op)^-1)*op')*(((b'*b)^-1)*b')
% 
% a = lsqr(op,(tau.^2)',tol,iter,[],[]);
% plot(x,-tau);
% 
% op2 = [x.^2]';
% a2 = lsqr(op2,(ti.^2-T^2)',tol,iter,[],[]);





