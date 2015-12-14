function [dout,M,ti,vi] = nmo(d,dt,h,tnmo,vnmo,max_stretch);
%NMO: A program for NMO correction.
%
% [dout,M] = nmo(d,dt,h,tnno,vnmo,max_streatch);
%
%  IN   d(nt,nh):  data (gather)
%       dt:        sampling interval in secs
%       h(nh):     vector of offsets in meters
%       tnmo,vnmo: vectors of intercept, nmo velocities 
%                  (vnmo is in m/s and tnmo in secs)
%                  Pick pairs from Velocity Spectra (use velan.m)
%                  example tnmo=[1.,2.2,3.] vnmo=[1500,2000,3000]
%                  if  tnmo=[0] vnmo=1500 applies constant v nmo with 1500m/s
%     max_stretch: maximum stetch allowed in %
%
%  OUT  dout:      data after NMO correction
%       M(nt):     number of x-samples that survived muting
%                  at each time position  
%
%  Example: moveout_demo.m
%
%
%  Copyright (C) 2008, Signal Analysis and Imaging Group
%  For more information: http://www-geo.phys.ualberta.ca/saig/SeismicLab
%  Author: M.D.Sacchi
%
%  This program is free software: you can redistribute it and/or modify
%  it under the terms of the GNU General Public License as published
%  by the Free Software Foundation, either version 3 of the License, or
%  any later version.
%
%  This program is distributed in the hope that it will be useful,
%  but WITHOUT ANY WARRANTY; without even the implied warranty of
%  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%  GNU General Public License for more details: http://www.gnu.org/licenses/
%
%   Modified by Dan Bright 30/07/2014
%   fixed interpolation for adding start/end points
%   also added line to convert offsets to a double


% Intepolate t0,v pairs 

[nt,nh] = size(d);

% ensure offset vector is a double

h = double(h);


mute_count = zeros(nt,1);
N = length(vnmo);

if (N>1)
    t1 = tnmo;
    v1 = vnmo;
    if t1(1)>0 % add t,v pair at time zero
        t1 = cat(1,0,t1);
        v1 = cat(1,v1(1),v1);
    end
    if max(t1) < (nt-1)*dt % add t,v pair at end of trace
        t1 = cat(1,t1, (nt-1)*dt);
        v1 = cat(1,v1, v1(N));
    end
   
    ti = (0:1:nt-1)*dt;
    vi = interp1(t1,v1,ti,'linear');
    
else
    
    ti = (0:1:nt-1)*dt;
    vi = ones(1,nt)*vnmo;
    
end;

dout = zeros(size(d));
M = zeros(nt,1);

for it = 1:nt;
    for ih = 1:nh;
        
        arg = double(( ti(it)^2 + (h(ih)/vi(it)).^2 ));
        
        time = sqrt(arg);
        stretch = (time-ti(it))/(ti(it)+1e-10);
        if stretch<max_stretch/100;
            
            M(it)= M(it) + 1;
            
            its = time/dt+1;
            
            it1 = floor(time/dt+1);
            it2 = it1+1;
            a = its-it1;
            
            if it2 <= nt; dout(it,ih) = (1-a)*d(it1,ih)+a*d(it2,ih); end;
            
       end
    end;
end;

return;
    