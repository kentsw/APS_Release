function [ rgb ] = make_colormap( color_idx,red,green,blue,num_colors,max_color )
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
% make a colormap from rgb values
%   color_idx: index of supplied rgb values (vector)
%   red: red values 
%   green: green values 
%   blue: blue values 
%   num_colors: number of colours in output colormap
%   max_color: [max_color max_color max_color] is white
%   
%   color_idx, red, green and blue vectors should all be same size
%   color_idx is zero-indexed
%   
%   Example:
%   red_white_blue = make_colormap([0 1 2],[1 1 0],[0 1 0],[0 1 1],256,1);

color_idx = color_idx./(max(color_idx)/num_colors);

num_colors = num_colors-1;

red_interp = interp1(color_idx,red,[0:num_colors])';
green_interp = interp1(color_idx,green,[0:num_colors])';
blue_interp = interp1(color_idx,blue,[0:num_colors])';

rgb = [red_interp green_interp blue_interp];
rgb = rgb./max_color;

end

