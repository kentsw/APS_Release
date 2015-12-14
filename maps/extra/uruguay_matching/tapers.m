bg_only_poly = importdata('/data/URY/opencps/URY_BG_Geom/tables/BG_Only_Merge_Edge.poly');

total_only_poly =  importdata('/data/URY/opencps/URY_BG_Geom/tables/Total_Only_Merge_Edge.poly');

bg_only_poly.data(end+1,:)=bg_only_poly.data(1,:);
total_only_poly.data(end+1,:)=total_only_poly.data(1,:);

count = 1;

for segment = 1:size(bg_only_poly.data,1)-1
    xstart = bg_only_poly.data(segment,1);
    xend = bg_only_poly.data(segment+1,1);    
    ystart = bg_only_poly.data(segment,2);
    yend = bg_only_poly.data(segment+1,2);
    
    xinc = 100*((xend<xstart)*-2+1);
    num_pts = floor((xend-xstart)/xinc);

    bg_interp_poly(count,:) = bg_only_poly.data(segment,:);
      
    x = xstart+xinc;
    
    for pt = 1:num_pts
        count=count+1;
       
        y=((x-xstart)/(xend-xstart))*(yend-ystart)+ystart;
        bg_interp_poly(count,:)=[x,y];
        x = x + xinc;
        
    end
    %scatter(bg_interp_poly(:,1),bg_interp_poly(:,2));
end
figure; scatter(bg_interp_poly(:,1),bg_interp_poly(:,2));
count = 1;

for segment = 1:size(total_only_poly.data,1)-1
    xstart = total_only_poly.data(segment,1);
    xend = total_only_poly.data(segment+1,1);    
    ystart = total_only_poly.data(segment,2);
    yend = total_only_poly.data(segment+1,2);
    
    ysign = (yend<ystart)*-2+1;
    xinc = 100*((xend<xstart)*-2+1);
    num_pts = floor((xend-xstart)/xinc);

    total_interp_poly(count,:) = total_only_poly.data(segment,:);
      
    x = xstart+xinc;
    
    for pt = 1:num_pts
        count=count+1;
       
        y=((x-xstart)/(xend-xstart))*(yend-ystart)+ystart;
        total_interp_poly(count,:)=[x,y];
        x = x + xinc;
        
    end
    %scatter(bg_interp_poly(:,1),bg_interp_poly(:,2));
end
figure; scatter(total_interp_poly(:,1),total_interp_poly(:,2));

bg_interp_poly(:,3)=1;
total_interp_poly(:,3)=0;

gridpoints = [bg_interp_poly;total_interp_poly];
xmin=floor(min(gridpoints(:,1))/100)*100;
xmax=ceil(max(gridpoints(:,1))/100)*100;
ymin=floor(min(gridpoints(:,2))/100)*100;
ymax=ceil(max(gridpoints(:,2))/100)*100;

tapergrid = griddata(gridpoints(:,1),gridpoints(:,2),gridpoints(:,3),[xmin:25:xmax],([ymin:25:ymax])');

[taperx,tapery] = meshgrid(xmin:25:xmax,ymin:25:ymax);

dlmwrite('/data/URY/opencps/URY_BG_Geom/tables/Taper_Grid_xyz.csv',[taperx(:),tapery(:),tapergrid(:)]);
