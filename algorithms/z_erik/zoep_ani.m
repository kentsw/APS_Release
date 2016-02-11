
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
%                               INPUTS
%--------------------------------------------------------------------------
% note: C=rho*A
C13=1;  % input
C33=1;  % input
A11=1;  % input
A13=1;  % input
A33=1;  % input
A55=1;  % input
th=1;   % input
th1=1;  % input
th2=1;  % input
th3=1;  % input
th4=1;  % input
V1=1;   % input
V2=1;   % input
V3=1;   % input
V4=1;   % input
%--------------------------------------------------------------------------
%                           CONDITION INPUTS
%--------------------------------------------------------------------------
A1=(2*(A13+A55))-((A33-A55)*(A11+A33-(2*A55)));
A2=((A11+A33-(2*A55))^2)-(4*((A13+A55)^2));
%--------------------------------------------------------------------------
x=sin(th1);
n=V1/V2;
%--------------------------------------------------------------------------
k1=V3/V1;
k2=V4/V2;
%--------------------------------------------------------------------------
%                       PREPARE EQUATION VARIABLES
%--------------------------------------------------------------------------
Q=(((A33-A55)^2)+(2*A1*sin(th))+(A2*((sin(th))^2)))^(0.5);            %%%%
% Lu=((((Q-A11+A55)/((sin(th))^2))+(A11+A33-(2*A55)))/(2*Q))^(0.5);   %%%%
% Mu=((((Q-A11+A55)/((cos(th))^2))+(A11+A33-(2*A55)))/(2*Q))^(0.5);   %%%%
l1=1;   % undetermined - see above
l2=1;   % undetermined - see above
l3=1;   % undetermined - see above
l4=1;   % undetermined - see above
m1=1;   % undetermined - see above
m2=1;   % undetermined - see above
m3=1;   % undetermined - see above
m4=1;   % undetermined - see above
l=(l2+m2)/(l1+m1);
bet1=1; %
bet2=1; %
del1=(l3*C33)-(m3*C13);
del2=(l4*C33)-(m4*C13);
eps1=((l1*C13)+(((m1*C33)-(l1*C13))*((cos(th1))^2)));
eps2=(((l2*C13)+(((m2*C33)-(l2*C13))*((cos(th2))^2)))*V1)/V2;
ome1=(V1*((m3*((cos(th3))^2))-(l3*((sin(th3))^2))))/(V3*(l1+m1));
ome2=(V1*((m4*((cos(th4))^2))-(l4*((sin(th4))^2))))/(V4*(l1+m1));
%--------------------------------------------------------------------------
%                       RUN PRELIMINARY EQUATIONS
%--------------------------------------------------------------------------
T1=eps2-((eps1*l2)/(n*l1));
T2=((bet2*ome2*k1*l3)/m1)-((bet1*ome1*k2*l4)/(n*m1));
T3=(bet2*ome2)+((bet1*k2*l4*(x^2))/(n*m1));
T4=((eps2*m3)/l1)+((del1*l2*(x^2))/(n*l1));
T5=bet1*(ome1+((k1*l3*(x^2))/m1));
T6=((eps2*m4)/l1)+((del2*l2*(x^2))/(n*l1));
T7=(bet2*l)-((bet1*m2)/m1);
T8=((del2*m3)/l1)-((del1*m4)/l1);
T9=bet2*(((ome2*m2)/m1)+((k2*l*l4*(x^2))/(n*m1)));
T10=((eps1*m3)/l1)+(del1*(x^2));
T11=((eps1*m4)/l1)+(del2*(x^2));
T12=((bet2*k1*l*l3*(x^2))/m1)+((bet1*ome1*m2)/m1);
%--------------------------------------------------------------------------
P=(1-(x^2))^(0.5);
Q=(1-((k1^2)*(x^2)))^(0.5);
S=(1-((x^2)/(n^2)))^(0.5);
R=(1-(((k2^2)*(x^2))/(n^2)))^(0.5);
%--------------------------------------------------------------------------
E1=T1*T2*(x^2);
E2=T3*T4*P*Q;
E3=T5*T6*P*R;
E4=T7*T8*(x^2)*P*Q*R*S;
E5=T9*T10*Q*S;
E6=T11*T12*R*S;
E7=2*T5*T11*P*R;
E8=2*T2*T10*P*Q;
E9=-2*x*T7*T11*P*R*S;
E10=-2*x*T1*T3*P;
E11=-2*x*T7*T10*P*Q*S;
E12=2*x*T1*T5*P;
E13=-2*x*T8*T12*Q*R*S;
E14=-2*x*T2*T4*Q;
E15=2*x*T5*T8*P*Q*R;
E16=-2*x*T2*T10*Q;
E17=2*T10*T12*Q*S;
E18=2*T4*T5*P*Q;
%--------------------------------------------------------------------------
%                       RUN REFLECTIVITY EQUATION
%--------------------------------------------------------------------------
D=(E1+E2+E3+E4+E5+E6);
R11=(-E1+E2+E3+E4-E5-E6)/D;
R12=(E7+E8)/D;
R13=(E9+E10)/D;
R14=(E11+E12)/D;
R31=(E13+E14)/D;
R32=(E15+E16)/D;
R33=(-E1+E2-E3+E4+E5-E6)/D;
R34=(E17+E18)/D;
%--------------------------------------------------------------------------
%                                   PLOT
%--------------------------------------------------------------------------
reflectivity=[R11,R12,R13,R14,R31,R32,R33,R34];
Es=[E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18];
plot(reflectivity)
figure
plot(Es)