clc
clear all
close all

filepath=uigetdir(cd,'Select Test Image folder:angry');
fileloc=dir(filepath);
index=1;
for i = 3:length(fileloc)
    filename=fileloc(i).name;
    
    if(strcmp(filename,'Thumbs.db')==0)
        filedir=strcat(filepath,'\',filename);
        frame_data=imread(filedir);
        
        
        eyepair_detect=vision.CascadeObjectDetector('EyePairBig');
        mouth_detect=vision.CascadeObjectDetector('Mouth');
        
        front_face_detect=vision.CascadeObjectDetector('FrontalFaceLBP');
        left_eye_detect=vision.CascadeObjectDetector('LeftEye');
        faceDetector3=vision.CascadeObjectDetector;
        right_eye_detect=vision.CascadeObjectDetector('RightEye');
        nose_detect=vision.CascadeObjectDetector('Nose');
        videoFrame_img=frame_data; %% read frame
        eyepair_cord = step(eyepair_detect, videoFrame_img); %% apply detect process for mouth and eye
        mouth_detect_cord = step(mouth_detect, videoFrame_img);
        face_cord=step(faceDetector3, videoFrame_img);
        front_face_cord=step(front_face_detect, videoFrame_img);
        left_eye_cord=step(left_eye_detect, videoFrame_img);
        right_eye_cord=step(right_eye_detect, videoFrame_img);
        
        nose_cord=step(nose_detect, videoFrame_img);
        
        if(~isempty(eyepair_cord) && ~isempty(mouth_detect_cord) && mouth_detect_cord(1,3) >20) %% check the
            
            
            filedir
            
            [eyepairxpoint eyepairypoint eyepairxpoint1 eyepairypoint1 xpoint2 ypoint2]=pointer_process(eyepair_cord(1,:)); %% find the location
            [mouthxpoint mouthypoint mouthxpoint1 mouthypoint1 xxpoint2 yypoint2]=pointer_process(mouth_detect_cord(1,:));
            
            [facexpoint faceypoint facexpoint1 faceypoint1 xxxpoint2 yyypoint2]=pointer_process(face_cord(1,:));
            
            [frontfacexpoint frontfaceypoint xxxxpoint1 yyyypoint1 xxxxpoint2 yyyypoint2]=pointer_process(front_face_cord(1,:)); %% find the location
            
            [lefteyexpoint lefteyeypoint xxxxxpoint1 yyyyypoint1 xxxxxpoint2 yyyyypoint2]=pointer_process(left_eye_cord(1,:)); %% find the location
            
            [righteyexpoint righteyeypoint xxxxxpoint1 yyyyypoint1 xxxxxpoint2 yyyyypoint2]=pointer_process(right_eye_cord(1,:)); %% find the location
            
            [nosexpoint noseypoint xxxxxpoint1 yyyyypoint1 xxxxxpoint2 yyyyypoint2]=pointer_process(nose_cord(1,:)); %% find the location
            
            
            
            % plot the image and show point
            
            subplot(1,2,1),imshow(videoFrame_img(:,:,1))
            
            subplot(1,2,2),imshow(videoFrame_img(:,:,1))
            
            hold on,plot(eyepairxpoint,eyepairypoint,'r:s');
            hold on,plot(eyepairxpoint1,eyepairypoint1,'r:s');
            hold on,plot(mouthxpoint,mouthypoint,'g:s');
            hold on,plot(mouthxpoint1,mouthypoint1,'g:s');
            hold on,plot(facexpoint,faceypoint,'c:s');
            
            hold on,plot(frontfacexpoint,frontfaceypoint,'k:s');
            
            hold on,plot(lefteyexpoint,lefteyeypoint,'b:s');
            hold on,plot(righteyexpoint,righteyeypoint,'b:s');
            
            hold on,plot(nosexpoint,noseypoint,'b:s');
            
            hold on,plot(nosexpoint(1),noseypoint(1),'y:s');
            hold on,plot(nosexpoint(2),noseypoint(2),'r:s');
            hold on,plot(nosexpoint(3),noseypoint(3),'g:s');
            hold on,plot(nosexpoint(4),noseypoint(4),'b:s');
            
            pause(0.1);
         
            
            % extract face eye motuh region
            [faceimg,eyeimg,mouthimg,front_face_img,lefteye_img,righteye_img,nose_img,final_fe_pt]=face_parts_extract(videoFrame_img,eyepairxpoint,...
                eyepairypoint,mouthxpoint,mouthypoint,...
                facexpoint,faceypoint,...
                frontfacexpoint,frontfaceypoint,...
                lefteyexpoint,lefteyeypoint,...
                righteyexpoint,righteyeypoint,...
                nosexpoint,noseypoint);
            % show the result
            %         subplot(3,2,2),imshow(faceimg);
            %         subplot(3,2,4),imshow(eyeimg);
            %         subplot(3,2,6),imshow(mouthimg);
            %
            %         figure,
            %         subplot(2,2,1),imshow(front_face_img);
            %         subplot(2,2,2),imshow(lefteye_img);
            %         subplot(2,2,3),imshow(righteye_img);
            %         subplot(2,2,3),imshow(nose_img);
            
            final_data_feat(index,1:27)=[final_fe_pt 1];
            index=index+1;
            
            
        end
        
    end
    
end


%%
filepath=uigetdir(cd,'Select Test Image folder:happy');
fileloc=dir(filepath);

for i = 3:length(fileloc)
    filename=fileloc(i).name;
    
    if(strcmp(filename,'Thumbs.db')==0)
        filedir=strcat(filepath,'\',filename);
        frame_data=imread(filedir);
        
        
        eyepair_detect=vision.CascadeObjectDetector('EyePairBig');
        mouth_detect=vision.CascadeObjectDetector('Mouth');
        
        front_face_detect=vision.CascadeObjectDetector('FrontalFaceLBP');
        left_eye_detect=vision.CascadeObjectDetector('LeftEye');
        faceDetector3=vision.CascadeObjectDetector;
        right_eye_detect=vision.CascadeObjectDetector('RightEye');
        nose_detect=vision.CascadeObjectDetector('Nose');
        videoFrame_img=frame_data; %% read frame
        eyepair_cord = step(eyepair_detect, videoFrame_img); %% apply detect process for mouth and eye
        mouth_detect_cord = step(mouth_detect, videoFrame_img);
        face_cord=step(faceDetector3, videoFrame_img);
        front_face_cord=step(front_face_detect, videoFrame_img);
        left_eye_cord=step(left_eye_detect, videoFrame_img);
        right_eye_cord=step(right_eye_detect, videoFrame_img);
        
        nose_cord=step(nose_detect, videoFrame_img);
        
        if(~isempty(eyepair_cord) && ~isempty(mouth_detect_cord) && mouth_detect_cord(1,3) >20) %% check the
            
            
            filedir
            
            [eyepairxpoint eyepairypoint eyepairxpoint1 eyepairypoint1 xpoint2 ypoint2]=pointer_process(eyepair_cord(1,:)); %% find the location
            [mouthxpoint mouthypoint mouthxpoint1 mouthypoint1 xxpoint2 yypoint2]=pointer_process(mouth_detect_cord(1,:));
            
            [facexpoint faceypoint facexpoint1 faceypoint1 xxxpoint2 yyypoint2]=pointer_process(face_cord(1,:));
            
            [frontfacexpoint frontfaceypoint xxxxpoint1 yyyypoint1 xxxxpoint2 yyyypoint2]=pointer_process(front_face_cord(1,:)); %% find the location
            
            [lefteyexpoint lefteyeypoint xxxxxpoint1 yyyyypoint1 xxxxxpoint2 yyyyypoint2]=pointer_process(left_eye_cord(1,:)); %% find the location
            
            [righteyexpoint righteyeypoint xxxxxpoint1 yyyyypoint1 xxxxxpoint2 yyyyypoint2]=pointer_process(right_eye_cord(1,:)); %% find the location
            
            [nosexpoint noseypoint xxxxxpoint1 yyyyypoint1 xxxxxpoint2 yyyyypoint2]=pointer_process(nose_cord(1,:)); %% find the location
            
            
            
            % plot the image and show point
            
            subplot(1,2,1),imshow(videoFrame_img(:,:,1))
            
            subplot(1,2,2),imshow(videoFrame_img(:,:,1))
            
            hold on,plot(eyepairxpoint,eyepairypoint,'r:s');
            hold on,plot(eyepairxpoint1,eyepairypoint1,'r:s');
            hold on,plot(mouthxpoint,mouthypoint,'g:s');
            hold on,plot(mouthxpoint1,mouthypoint1,'g:s');
            hold on,plot(facexpoint,faceypoint,'c:s');
            
            hold on,plot(frontfacexpoint,frontfaceypoint,'k:s');
            
            hold on,plot(lefteyexpoint,lefteyeypoint,'b:s');
            hold on,plot(righteyexpoint,righteyeypoint,'b:s');
            
            hold on,plot(nosexpoint,noseypoint,'b:s');
            
            hold on,plot(nosexpoint(1),noseypoint(1),'y:s');
            hold on,plot(nosexpoint(2),noseypoint(2),'r:s');
            hold on,plot(nosexpoint(3),noseypoint(3),'g:s');
            hold on,plot(nosexpoint(4),noseypoint(4),'b:s');
            
            pause(0.1);
         
            
            % extract face eye motuh region
            [faceimg,eyeimg,mouthimg,front_face_img,lefteye_img,righteye_img,nose_img,final_fe_pt]=face_parts_extract(videoFrame_img,eyepairxpoint,...
                eyepairypoint,mouthxpoint,mouthypoint,...
                facexpoint,faceypoint,...
                frontfacexpoint,frontfaceypoint,...
                lefteyexpoint,lefteyeypoint,...
                righteyexpoint,righteyeypoint,...
                nosexpoint,noseypoint);
            % show the result
            %         subplot(3,2,2),imshow(faceimg);
            %         subplot(3,2,4),imshow(eyeimg);
            %         subplot(3,2,6),imshow(mouthimg);
            %
            %         figure,
            %         subplot(2,2,1),imshow(front_face_img);
            %         subplot(2,2,2),imshow(lefteye_img);
            %         subplot(2,2,3),imshow(righteye_img);
            %         subplot(2,2,3),imshow(nose_img);
            
            final_data_feat(index,1:27)=[final_fe_pt 2];
            index=index+1;
            
            
        end
        
    end
    
end


%%
filepath=uigetdir(cd,'Select Test Image folder:disgust');
fileloc=dir(filepath);

for i = 3:length(fileloc)
    filename=fileloc(i).name;
    
    if(strcmp(filename,'Thumbs.db')==0)
        filedir=strcat(filepath,'\',filename);
        frame_data=imread(filedir);
        
        
        eyepair_detect=vision.CascadeObjectDetector('EyePairBig');
        mouth_detect=vision.CascadeObjectDetector('Mouth');
        
        front_face_detect=vision.CascadeObjectDetector('FrontalFaceLBP');
        left_eye_detect=vision.CascadeObjectDetector('LeftEye');
        faceDetector3=vision.CascadeObjectDetector;
        right_eye_detect=vision.CascadeObjectDetector('RightEye');
        nose_detect=vision.CascadeObjectDetector('Nose');
        videoFrame_img=frame_data; %% read frame
        eyepair_cord = step(eyepair_detect, videoFrame_img); %% apply detect process for mouth and eye
        mouth_detect_cord = step(mouth_detect, videoFrame_img);
        face_cord=step(faceDetector3, videoFrame_img);
        front_face_cord=step(front_face_detect, videoFrame_img);
        left_eye_cord=step(left_eye_detect, videoFrame_img);
        right_eye_cord=step(right_eye_detect, videoFrame_img);
        
        nose_cord=step(nose_detect, videoFrame_img);
        
        if(~isempty(eyepair_cord) && ~isempty(mouth_detect_cord) && mouth_detect_cord(1,3) >20) %% check the
            
            
            filedir
            
            [eyepairxpoint eyepairypoint eyepairxpoint1 eyepairypoint1 xpoint2 ypoint2]=pointer_process(eyepair_cord(1,:)); %% find the location
            [mouthxpoint mouthypoint mouthxpoint1 mouthypoint1 xxpoint2 yypoint2]=pointer_process(mouth_detect_cord(1,:));
            
            [facexpoint faceypoint facexpoint1 faceypoint1 xxxpoint2 yyypoint2]=pointer_process(face_cord(1,:));
            
            [frontfacexpoint frontfaceypoint xxxxpoint1 yyyypoint1 xxxxpoint2 yyyypoint2]=pointer_process(front_face_cord(1,:)); %% find the location
            
            [lefteyexpoint lefteyeypoint xxxxxpoint1 yyyyypoint1 xxxxxpoint2 yyyyypoint2]=pointer_process(left_eye_cord(1,:)); %% find the location
            
            [righteyexpoint righteyeypoint xxxxxpoint1 yyyyypoint1 xxxxxpoint2 yyyyypoint2]=pointer_process(right_eye_cord(1,:)); %% find the location
            
            [nosexpoint noseypoint xxxxxpoint1 yyyyypoint1 xxxxxpoint2 yyyyypoint2]=pointer_process(nose_cord(1,:)); %% find the location
            
            
            
            % plot the image and show point
            
            subplot(1,2,1),imshow(videoFrame_img(:,:,1))
            
            subplot(1,2,2),imshow(videoFrame_img(:,:,1))
            
            hold on,plot(eyepairxpoint,eyepairypoint,'r:s');
            hold on,plot(eyepairxpoint1,eyepairypoint1,'r:s');
            hold on,plot(mouthxpoint,mouthypoint,'g:s');
            hold on,plot(mouthxpoint1,mouthypoint1,'g:s');
            hold on,plot(facexpoint,faceypoint,'c:s');
            
            hold on,plot(frontfacexpoint,frontfaceypoint,'k:s');
            
            hold on,plot(lefteyexpoint,lefteyeypoint,'b:s');
            hold on,plot(righteyexpoint,righteyeypoint,'b:s');
            
            hold on,plot(nosexpoint,noseypoint,'b:s');
            
            hold on,plot(nosexpoint(1),noseypoint(1),'y:s');
            hold on,plot(nosexpoint(2),noseypoint(2),'r:s');
            hold on,plot(nosexpoint(3),noseypoint(3),'g:s');
            hold on,plot(nosexpoint(4),noseypoint(4),'b:s');
            
            pause(0.1);
         
            
            % extract face eye motuh region
            [faceimg,eyeimg,mouthimg,front_face_img,lefteye_img,righteye_img,nose_img,final_fe_pt]=face_parts_extract(videoFrame_img,eyepairxpoint,...
                eyepairypoint,mouthxpoint,mouthypoint,...
                facexpoint,faceypoint,...
                frontfacexpoint,frontfaceypoint,...
                lefteyexpoint,lefteyeypoint,...
                righteyexpoint,righteyeypoint,...
                nosexpoint,noseypoint);
            % show the result
            %         subplot(3,2,2),imshow(faceimg);
            %         subplot(3,2,4),imshow(eyeimg);
            %         subplot(3,2,6),imshow(mouthimg);
            %
            %         figure,
            %         subplot(2,2,1),imshow(front_face_img);
            %         subplot(2,2,2),imshow(lefteye_img);
            %         subplot(2,2,3),imshow(righteye_img);
            %         subplot(2,2,3),imshow(nose_img);
            
            final_data_feat(index,1:27)=[final_fe_pt 3];
            index=index+1;
            
            
        end
        
    end
    
end



%%

filepath=uigetdir(cd,'Select Test Image folder:sad');
fileloc=dir(filepath);

for i = 3:length(fileloc)
    filename=fileloc(i).name;
    
    if(strcmp(filename,'Thumbs.db')==0)
        filedir=strcat(filepath,'\',filename);
        frame_data=imread(filedir);
        
        
        eyepair_detect=vision.CascadeObjectDetector('EyePairBig');
        mouth_detect=vision.CascadeObjectDetector('Mouth');
        
        front_face_detect=vision.CascadeObjectDetector('FrontalFaceLBP');
        left_eye_detect=vision.CascadeObjectDetector('LeftEye');
        faceDetector3=vision.CascadeObjectDetector;
        right_eye_detect=vision.CascadeObjectDetector('RightEye');
        nose_detect=vision.CascadeObjectDetector('Nose');
        videoFrame_img=frame_data; %% read frame
        eyepair_cord = step(eyepair_detect, videoFrame_img); %% apply detect process for mouth and eye
        mouth_detect_cord = step(mouth_detect, videoFrame_img);
        face_cord=step(faceDetector3, videoFrame_img);
        front_face_cord=step(front_face_detect, videoFrame_img);
        left_eye_cord=step(left_eye_detect, videoFrame_img);
        right_eye_cord=step(right_eye_detect, videoFrame_img);
        
        nose_cord=step(nose_detect, videoFrame_img);
        
        if(~isempty(eyepair_cord) && ~isempty(mouth_detect_cord) && mouth_detect_cord(1,3) >20) %% check the
            
            
            filedir
            
            [eyepairxpoint eyepairypoint eyepairxpoint1 eyepairypoint1 xpoint2 ypoint2]=pointer_process(eyepair_cord(1,:)); %% find the location
            [mouthxpoint mouthypoint mouthxpoint1 mouthypoint1 xxpoint2 yypoint2]=pointer_process(mouth_detect_cord(1,:));
            
            [facexpoint faceypoint facexpoint1 faceypoint1 xxxpoint2 yyypoint2]=pointer_process(face_cord(1,:));
            
            [frontfacexpoint frontfaceypoint xxxxpoint1 yyyypoint1 xxxxpoint2 yyyypoint2]=pointer_process(front_face_cord(1,:)); %% find the location
            
            [lefteyexpoint lefteyeypoint xxxxxpoint1 yyyyypoint1 xxxxxpoint2 yyyyypoint2]=pointer_process(left_eye_cord(1,:)); %% find the location
            
            [righteyexpoint righteyeypoint xxxxxpoint1 yyyyypoint1 xxxxxpoint2 yyyyypoint2]=pointer_process(right_eye_cord(1,:)); %% find the location
            
            [nosexpoint noseypoint xxxxxpoint1 yyyyypoint1 xxxxxpoint2 yyyyypoint2]=pointer_process(nose_cord(1,:)); %% find the location
            
            
            
            % plot the image and show point
            
            subplot(1,2,1),imshow(videoFrame_img(:,:,1))
            
            subplot(1,2,2),imshow(videoFrame_img(:,:,1))
            
            hold on,plot(eyepairxpoint,eyepairypoint,'r:s');
            hold on,plot(eyepairxpoint1,eyepairypoint1,'r:s');
            hold on,plot(mouthxpoint,mouthypoint,'g:s');
            hold on,plot(mouthxpoint1,mouthypoint1,'g:s');
            hold on,plot(facexpoint,faceypoint,'c:s');
            
            hold on,plot(frontfacexpoint,frontfaceypoint,'k:s');
            
            hold on,plot(lefteyexpoint,lefteyeypoint,'b:s');
            hold on,plot(righteyexpoint,righteyeypoint,'b:s');
            
            hold on,plot(nosexpoint,noseypoint,'b:s');
            
            hold on,plot(nosexpoint(1),noseypoint(1),'y:s');
            hold on,plot(nosexpoint(2),noseypoint(2),'r:s');
            hold on,plot(nosexpoint(3),noseypoint(3),'g:s');
            hold on,plot(nosexpoint(4),noseypoint(4),'b:s');
            
            pause(0.1);
         
            
            % extract face eye motuh region
            [faceimg,eyeimg,mouthimg,front_face_img,lefteye_img,righteye_img,nose_img,final_fe_pt]=face_parts_extract(videoFrame_img,eyepairxpoint,...
                eyepairypoint,mouthxpoint,mouthypoint,...
                facexpoint,faceypoint,...
                frontfacexpoint,frontfaceypoint,...
                lefteyexpoint,lefteyeypoint,...
                righteyexpoint,righteyeypoint,...
                nosexpoint,noseypoint);
            % show the result
            %         subplot(3,2,2),imshow(faceimg);
            %         subplot(3,2,4),imshow(eyeimg);
            %         subplot(3,2,6),imshow(mouthimg);
            %
            %         figure,
            %         subplot(2,2,1),imshow(front_face_img);
            %         subplot(2,2,2),imshow(lefteye_img);
            %         subplot(2,2,3),imshow(righteye_img);
            %         subplot(2,2,3),imshow(nose_img);
            
            final_data_feat(index,1:27)=[final_fe_pt 4];
            index=index+1;
            
            
        end
        
    end
    
end


%%
filepath=uigetdir(cd,'Select Test Image folder:surprise');
fileloc=dir(filepath);

for i = 3:length(fileloc)
    filename=fileloc(i).name;
    
    if(strcmp(filename,'Thumbs.db')==0)
        filedir=strcat(filepath,'\',filename);
        frame_data=imread(filedir);
        
        
        eyepair_detect=vision.CascadeObjectDetector('EyePairBig');
        mouth_detect=vision.CascadeObjectDetector('Mouth');
        
        front_face_detect=vision.CascadeObjectDetector('FrontalFaceLBP');
        left_eye_detect=vision.CascadeObjectDetector('LeftEye');
        faceDetector3=vision.CascadeObjectDetector;
        right_eye_detect=vision.CascadeObjectDetector('RightEye');
        nose_detect=vision.CascadeObjectDetector('Nose');
        videoFrame_img=frame_data; %% read frame
        eyepair_cord = step(eyepair_detect, videoFrame_img); %% apply detect process for mouth and eye
        mouth_detect_cord = step(mouth_detect, videoFrame_img);
        face_cord=step(faceDetector3, videoFrame_img);
        front_face_cord=step(front_face_detect, videoFrame_img);
        left_eye_cord=step(left_eye_detect, videoFrame_img);
        right_eye_cord=step(right_eye_detect, videoFrame_img);
        
        nose_cord=step(nose_detect, videoFrame_img);
        
        if(~isempty(eyepair_cord) && ~isempty(mouth_detect_cord) && mouth_detect_cord(1,3) >20) %% check the
            
            
            filedir
            
            [eyepairxpoint eyepairypoint eyepairxpoint1 eyepairypoint1 xpoint2 ypoint2]=pointer_process(eyepair_cord(1,:)); %% find the location
            [mouthxpoint mouthypoint mouthxpoint1 mouthypoint1 xxpoint2 yypoint2]=pointer_process(mouth_detect_cord(1,:));
            
            [facexpoint faceypoint facexpoint1 faceypoint1 xxxpoint2 yyypoint2]=pointer_process(face_cord(1,:));
            
            [frontfacexpoint frontfaceypoint xxxxpoint1 yyyypoint1 xxxxpoint2 yyyypoint2]=pointer_process(front_face_cord(1,:)); %% find the location
            
            [lefteyexpoint lefteyeypoint xxxxxpoint1 yyyyypoint1 xxxxxpoint2 yyyyypoint2]=pointer_process(left_eye_cord(1,:)); %% find the location
            
            [righteyexpoint righteyeypoint xxxxxpoint1 yyyyypoint1 xxxxxpoint2 yyyyypoint2]=pointer_process(right_eye_cord(1,:)); %% find the location
            
            [nosexpoint noseypoint xxxxxpoint1 yyyyypoint1 xxxxxpoint2 yyyyypoint2]=pointer_process(nose_cord(1,:)); %% find the location
            
            
            
            % plot the image and show point
            
            subplot(1,2,1),imshow(videoFrame_img(:,:,1))
            
            subplot(1,2,2),imshow(videoFrame_img(:,:,1))
            
            hold on,plot(eyepairxpoint,eyepairypoint,'r:s');
            hold on,plot(eyepairxpoint1,eyepairypoint1,'r:s');
            hold on,plot(mouthxpoint,mouthypoint,'g:s');
            hold on,plot(mouthxpoint1,mouthypoint1,'g:s');
            hold on,plot(facexpoint,faceypoint,'c:s');
            
            hold on,plot(frontfacexpoint,frontfaceypoint,'k:s');
            
            hold on,plot(lefteyexpoint,lefteyeypoint,'b:s');
            hold on,plot(righteyexpoint,righteyeypoint,'b:s');
            
            hold on,plot(nosexpoint,noseypoint,'b:s');
            
            hold on,plot(nosexpoint(1),noseypoint(1),'y:s');
            hold on,plot(nosexpoint(2),noseypoint(2),'r:s');
            hold on,plot(nosexpoint(3),noseypoint(3),'g:s');
            hold on,plot(nosexpoint(4),noseypoint(4),'b:s');
            
            pause(0.1);
         
            
            % extract face eye motuh region
            [faceimg,eyeimg,mouthimg,front_face_img,lefteye_img,righteye_img,nose_img,final_fe_pt]=face_parts_extract(videoFrame_img,eyepairxpoint,...
                eyepairypoint,mouthxpoint,mouthypoint,...
                facexpoint,faceypoint,...
                frontfacexpoint,frontfaceypoint,...
                lefteyexpoint,lefteyeypoint,...
                righteyexpoint,righteyeypoint,...
                nosexpoint,noseypoint);
            % show the result
%                     subplot(3,2,2),imshow(faceimg);
%                     subplot(3,2,4),imshow(eyeimg);
%                     subplot(3,2,6),imshow(mouthimg);
%             
%                     figure,
%                     subplot(2,2,1),imshow(front_face_img);
%                     subplot(2,2,2),imshow(lefteye_img);
%                     subplot(2,2,3),imshow(righteye_img);
%                     subplot(2,2,3),imshow(nose_img);
            
            final_data_feat(index,1:27)=[final_fe_pt 5];
            index=index+1;
            
            
        end
        
    end
    
end




save data_base_in_feature.mat final_data_feat 






