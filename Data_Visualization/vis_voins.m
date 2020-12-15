%% BUT WHEN ARE WE 
if ~exist('date','var')
    date = "2015-08-17-13-20-19";

end
%% INS STUFF
[ins_state,time] = get_ins(date);


%% VO STUFF
[vo,vo_time,scale] = get_vo(date);
vo(:,4:6) = vo(:,4:6)/scale; % Remove scaling from rotation values
vo_state = odometryToState([0 0 0 0 0 ((-pi/2)-(1.5*pi/18))]',vo');
% vo_state = odometryToState([0 0 0 0 0 0]',vo');

vo_state(1:3,:) = vo_state(1:3,:)/scale; % Remove scaling from translation values
visualize_two_state(ins_state,vo_state,"Todd")

%%
ins(3,:) = 0;
vo_state(3,:) = 0;
pcins = pointCloud(ins(1:3,:)');
pcvo = pointCloud(vo_state(1:3,:)');
rigid_boi = pcregistericp(pcins,pcvo);
pcins_moved = pctransform(pcins,rigid_boi);

merged = pcmerge(pcins_moved,pcvo,1);

pcshow(merged)