function frame_data=frame_extarct_process(videoFileReader)

ind_frm=1;
ind_frm2=1;
while ~isDone(videoFileReader)
    
    videoFrame=step(videoFileReader); %% read frame
    ind_frm=ind_frm+1;
    
    if(ind_frm>30 && ind_frm<40)
        
        frame_data{ind_frm2}=videoFrame;
        ind_frm2=ind_frm2+1;
    end
    
    pause(0.2);
end

ind_frm=ind_frm;

ind_frm2=ind_frm2;

