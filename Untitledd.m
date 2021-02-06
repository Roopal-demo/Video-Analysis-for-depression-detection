clc
clear all
close all
load data_base_in_feature.mat
train_data=final_data_feat(:,1:end-1);
%% 


filepath=uigetdir(cd,'Select Test Image folder');
fileloc=dir(filepath);


index=1;a=0;
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
        videoFrame_img=frame_data;
        
        eyepair_cord = step(eyepair_detect, videoFrame_img); %% apply detect process for mouth and eye
        mouth_detect_cord = step(mouth_detect, videoFrame_img);
        face_cord=step(faceDetector3, videoFrame_img);
        front_face_cord=step(front_face_detect, videoFrame_img);
        left_eye_cord=step(left_eye_detect, videoFrame_img);
        right_eye_cord=step(right_eye_detect, videoFrame_img);
        
        nose_cord=step(nose_detect, videoFrame_img);
        
        if(~isempty(eyepair_cord) && ~isempty(mouth_detect_cord) && mouth_detect_cord(1,3) >20) %% check the cordinates...
            
            
            filedir;
            
            [eyepairxpoint, eyepairypoint, eyepairxpoint1, eyepairypoint1, eyepairxpoint2, eyepairypoint2]=cord_find(eyepair_cord(1,:)); %% find the location
            [mouthxpoint, mouthypoint, mouthxpoint1, mouthypoint1, mouthxpoint2, mouhtypoint2]=cord_find(mouth_detect_cord(1,:));
            
            [facexpoint, faceypoint, facexpoint1, faceypoint1, facexpoint2, faceypoint2]=cord_find(face_cord(1,:));
            
            [frontfacexpoint, frontfaceypoint, frontfacexpoint1, frontfaceypoint1, frontfacexpoint2, frontfaceypoint2]=cord_find(front_face_cord(1,:)); %% find the location
            
            [lefteyexpoint, lefteyeypoint, lefteyexpoint1, lefteyeypoint1 ,lefteyexpoint2 ,lefteyeypoint2]=cord_find(left_eye_cord(1,:)); %% find the location
            
            [righteyexpoint, righteyeypoint, righteyexpoint1, rightyeyeypoint1 ,righteyexpoint2, righteyeypoint2]=cord_find(right_eye_cord(1,:)); %% find the location
            
            [nosexpoint, noseypoint, nosexpoint1, noseypoint1, nosexpoint2, noseypoint2]=cord_find(nose_cord(1,:)); %% find the location
            
            
%             figure,
%             % plot the image and show point
%             
%             subplot(1,2,1),imshow(videoFrame_img(:,:,1))
%             
%             subplot(1,2,2),imshow(videoFrame_img(:,:,1))
%             
           % hold on,plot(facexpoint,faceypoint,'c:s');
           % hold on,plot(mouthxpoint,mouthypoint,'g:s'); 
           % hold on,plot(lefteyexpoint,lefteyeypoint,'b:s');
           % hold on,plot(righteyexpoint,righteyeypoint,'b:s');
            
           % hold on,plot(nosexpoint,noseypoint,'b:s');
            
             pause(0.1);
         
            
            % extract face eye motuh region
            [faceimg,eyeimg,mouthimg,front_face_img,lefteye_img,righteye_img,nose_img,final_fe_pt]=face_parts_extract(videoFrame_img,eyepairxpoint, eyepairypoint,...
                                                                                                                      mouthxpoint,mouthypoint,...
                                                                                                                      facexpoint,faceypoint,...
                                                                                                                      frontfacexpoint,frontfaceypoint,...
                                                                                                                      lefteyexpoint,lefteyeypoint,...
                                                                                                                      righteyexpoint,righteyeypoint,...
                                                                                                                      nosexpoint,noseypoint);
                                                                                                                  
                                                                                                                  
            % show the result
%             
%                      subplot(3,2,2),imshow(faceimg);
%                      subplot(3,2,4),imshow(eyeimg);
%                      subplot(3,2,6),imshow(mouthimg);
%             
%                      figure,
%                      subplot(2,2,1),imshow(front_face_img);
%                      subplot(2,2,2),imshow(lefteye_img);
%                      subplot(2,2,3),imshow(righteye_img);
%                      subplot(2,2,3),imshow(nose_img);

          
            
            final_data_feat_test(index,1:26)=[final_fe_pt];
            index=index+1;
            for jj=1:size(final_data_feat_test,1)
            for ii=1:size(train_data,1)
                finaltest(ii,:)=train_data(ii,:)-final_data_feat_test(jj,:);
                
            end
               finaltest1=abs(sum(finaltest,2));
               [a b]=min(finaltest1);
               finaltestval(jj)=b;
            end
            
        end
        
    end
    
end
ac=index;

load data_base_in_feature.mat

train_data=final_data_feat(:,1:end-1);
train_class=final_data_feat(:,end)';


test_data=final_data_feat_test;
train_class=full(ind2vec(train_class));
network_form=selforgmap(5);
network_form.trainparam.epochs=1000; %no of cycles
network_form=train(network_form,train_data',train_class);
result_som=sim(network_form,test_data');
result_som1=vec2ind(result_som);

finalt=zeros(5,length(finaltestval));

for i=1:length(finaltestval)
    
if finaltestval(i)<angryc && finaltestval(i)>0 
    
    finaltestval1(i)=1;
    
    finalt(1,i)=1;
    a=a+1;
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              for i=1:length(r)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             if (r(i)==finaltestval)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 a=a-1;
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             end
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              end
end
end
anger=(a/ac)*100;

%% 
index=1;h=0;
filepath=uigetdir(cd,'Select Test Image folder:Happy');
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
        
        if(~isempty(eyepair_cord) && ~isempty(mouth_detect_cord) && mouth_detect_cord(1,3) >20) %% check the cordinates...
            
            
            filedir;
            
            [eyepairxpoint, eyepairypoint, eyepairxpoint1, eyepairypoint1, eyepairxpoint2, eyepairypoint2]=cord_find(eyepair_cord(1,:)); %% find the location
            [mouthxpoint, mouthypoint, mouthxpoint1, mouthypoint1, mouthxpoint2, mouhtypoint2]=cord_find(mouth_detect_cord(1,:));
            
            [facexpoint, faceypoint, facexpoint1, faceypoint1, facexpoint2, faceypoint2]=cord_find(face_cord(1,:));
            
            [frontfacexpoint, frontfaceypoint, frontfacexpoint1, frontfaceypoint1, frontfacexpoint2, frontfaceypoint2]=cord_find(front_face_cord(1,:)); %% find the location
            
            [lefteyexpoint, lefteyeypoint, lefteyexpoint1, lefteyeypoint1 ,lefteyexpoint2 ,lefteyeypoint2]=cord_find(left_eye_cord(1,:)); %% find the location
            
            [righteyexpoint, righteyeypoint, righteyexpoint1, rightyeyeypoint1 ,righteyexpoint2, righteyeypoint2]=cord_find(right_eye_cord(1,:)); %% find the location
            
            [nosexpoint, noseypoint, nosexpoint1, noseypoint1, nosexpoint2, noseypoint2]=cord_find(nose_cord(1,:)); %% find the location
            
            
            
            % plot the image and show point
            
%             subplot(1,2,1),imshow(videoFrame_img(:,:,1))
%             
%             subplot(1,2,2),imshow(videoFrame_img(:,:,1))
            
           % hold on,plot(facexpoint,faceypoint,'c:s');
           % hold on,plot(mouthxpoint,mouthypoint,'g:s'); 
           % hold on,plot(lefteyexpoint,lefteyeypoint,'b:s');
            % hold on,plot(righteyexpoint,righteyeypoint,'b:s');
            
           % hold on,plot(nosexpoint,noseypoint,'b:s');
            
             pause(0.1);
         
            
            % extract face eye motuh region
            [faceimg,eyeimg,mouthimg,front_face_img,lefteye_img,righteye_img,nose_img,final_fe_pt]=face_parts_extract(videoFrame_img,eyepairxpoint, eyepairypoint,...
                                                                                                                      mouthxpoint,mouthypoint,...
                                                                                                                      facexpoint,faceypoint,...
                                                                                                                      frontfacexpoint,frontfaceypoint,...
                                                                                                                      lefteyexpoint,lefteyeypoint,...
                                                                                                                      righteyexpoint,righteyeypoint,...
                                                                                                                      nosexpoint,noseypoint);
          
            
%                                                                                                                    % show the result
%                     subplot(3,2,2),imshow(faceimg);
%                      subplot(3,2,4),imshow(eyeimg);
%                      subplot(3,2,6),imshow(mouthimg);
%             
%                      figure,
%                      subplot(2,2,1),imshow(front_face_img);
%                      subplot(2,2,2),imshow(lefteye_img);
%                      subplot(2,2,3),imshow(righteye_img);
%                      subplot(2,2,3),imshow(nose_img);

            final_data_feat_test(index,1:26)=[final_fe_pt];
            index=index+1;
            for jj=1:size(final_data_feat_test,1)
            for ii=1:size(train_data,1)
                finaltest(ii,:)=train_data(ii,:)-final_data_feat_test(jj,:);
                
            end
               finaltest1=abs(sum(finaltest,2));
               [a b]=min(finaltest1);
               finaltestval(jj)=b;
            end
            
        end
        
    end
    
end
hc=index;

load data_base_in_feature.mat

train_data=final_data_feat(:,1:end-1);
train_class=final_data_feat(:,end)';


test_data=final_data_feat_test;
train_class=full(ind2vec(train_class));
network_form=selforgmap(5);
network_form.trainparam.epochs=1000; %no of cycles
network_form=train(network_form,train_data',train_class);
result_som=sim(network_form,test_data');
result_som1=vec2ind(result_som);

finalt=zeros(5,length(finaltestval));

for i=1:length(finaltestval)
    
if finaltestval(i)<happyc && finaltestval(i)>angryc-1 
    
    finaltestval1(i)=1;
    
    finalt(1,i)=1;
    h=h+1;
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              for i=1:length(r)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             if (r(i)==finaltestval)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 h=h-1;
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             end
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              end
end
end

happy=(h/hc)*100;


%% 
index=1;s=0;
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
        
        if(~isempty(eyepair_cord) && ~isempty(mouth_detect_cord) && mouth_detect_cord(1,3) >20) %% check the cordinates...
            
            
            filedir;
            
            [eyepairxpoint, eyepairypoint, eyepairxpoint1, eyepairypoint1, eyepairxpoint2, eyepairypoint2]=cord_find(eyepair_cord(1,:)); %% find the location
            [mouthxpoint, mouthypoint, mouthxpoint1, mouthypoint1, mouthxpoint2, mouhtypoint2]=cord_find(mouth_detect_cord(1,:));
            
            [facexpoint, faceypoint, facexpoint1, faceypoint1, facexpoint2, faceypoint2]=cord_find(face_cord(1,:));
            
            [frontfacexpoint, frontfaceypoint, frontfacexpoint1, frontfaceypoint1, frontfacexpoint2, frontfaceypoint2]=cord_find(front_face_cord(1,:)); %% find the location
            
            [lefteyexpoint, lefteyeypoint, lefteyexpoint1, lefteyeypoint1 ,lefteyexpoint2 ,lefteyeypoint2]=cord_find(left_eye_cord(1,:)); %% find the location
            
            [righteyexpoint, righteyeypoint, righteyexpoint1, rightyeyeypoint1 ,righteyexpoint2, righteyeypoint2]=cord_find(right_eye_cord(1,:)); %% find the location
            
            [nosexpoint, noseypoint, nosexpoint1, noseypoint1, nosexpoint2, noseypoint2]=cord_find(nose_cord(1,:)); %% find the location
            
            
            
            % plot the image and show point
            
%               subplot(1,2,1),imshow(videoFrame_img(:,:,1))
%             
%             subplot(1,2,2),imshow(videoFrame_img(:,:,1))
            
           % hold on,plot(facexpoint,faceypoint,'c:s');
           % hold on,plot(mouthxpoint,mouthypoint,'g:s'); 
            % hold on,plot(lefteyexpoint,lefteyeypoint,'b:s');
            % hold on,plot(righteyexpoint,righteyeypoint,'b:s');
            
           % hold on,plot(nosexpoint,noseypoint,'b:s');
            
             pause(0.1);
         
            
            % extract face eye motuh region
            [faceimg,eyeimg,mouthimg,front_face_img,lefteye_img,righteye_img,nose_img,final_fe_pt]=face_parts_extract(videoFrame_img,eyepairxpoint, eyepairypoint,...
                                                                                                                      mouthxpoint,mouthypoint,...
                                                                                                                      facexpoint,faceypoint,...
                                                                                                                      frontfacexpoint,frontfaceypoint,...
                                                                                                                      lefteyexpoint,lefteyeypoint,...
                                                                                                                      righteyexpoint,righteyeypoint,...
                                                                                                                      nosexpoint,noseypoint);
    
                                                                                                                  
              % show the result
%                     subplot(3,2,2),imshow(faceimg);
%                      subplot(3,2,4),imshow(eyeimg);
%                      subplot(3,2,6),imshow(mouthimg);
%             
%                      figure,
%                      subplot(2,2,1),imshow(front_face_img);
%                      subplot(2,2,2),imshow(lefteye_img);
%                      subplot(2,2,3),imshow(righteye_img);
%                      subplot(2,2,3),imshow(nose_img);

            
            final_data_feat_test(index,1:26)=[final_fe_pt];
            index=index+1;
            for jj=1:size(final_data_feat_test,1)
            for ii=1:size(train_data,1)
                finaltest(ii,:)=train_data(ii,:)-final_data_feat_test(jj,:);
                
            end
               finaltest1=abs(sum(finaltest,2));
               [a b]=min(finaltest1);
               finaltestval(jj)=b;
            end
            
        end
        
    end
    
end

sc=index;

load data_base_in_feature.mat

train_data=final_data_feat(:,1:end-1);
train_class=final_data_feat(:,end)';


test_data=final_data_feat_test;
train_class=full(ind2vec(train_class));
network_form=selforgmap(5);
network_form.trainparam.epochs=1000; %no of cycles
network_form=train(network_form,train_data',train_class);
result_som=sim(network_form,test_data');
result_som1=vec2ind(result_som);

finalt=zeros(5,length(finaltestval));

for i=1:length(finaltestval)
    
if finaltestval(i)<sadc && finaltestval(i)>happyc-1
    
    finaltestval1(i)=1;
    
    finalt(1,i)=1;
    s=s+1;
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              for i=1:length(r)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             if (r(i)==finaltestval)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 s=s-1;
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             end
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              end
end
end

sad=(s/sc)*100;


%% 
index=1;d=0;
filepath=uigetdir(cd,'Select Test Image folder:disgust');
fileloc=dir(filepath);

for i = 3:length(fileloc)
    filename=fileloc(i).name
    
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
        
        if(~isempty(eyepair_cord) && ~isempty(mouth_detect_cord) && mouth_detect_cord(1,3) >20) %% check the cordinates...
            
            
            filedir;
            
            [eyepairxpoint, eyepairypoint, eyepairxpoint1, eyepairypoint1, eyepairxpoint2, eyepairypoint2]=cord_find(eyepair_cord(1,:)); %% find the location
            [mouthxpoint, mouthypoint, mouthxpoint1, mouthypoint1, mouthxpoint2, mouhtypoint2]=cord_find(mouth_detect_cord(1,:));
            
            [facexpoint, faceypoint, facexpoint1, faceypoint1, facexpoint2, faceypoint2]=cord_find(face_cord(1,:));
            
            [frontfacexpoint, frontfaceypoint, frontfacexpoint1, frontfaceypoint1, frontfacexpoint2, frontfaceypoint2]=cord_find(front_face_cord(1,:)); %% find the location
            
            [lefteyexpoint, lefteyeypoint, lefteyexpoint1, lefteyeypoint1 ,lefteyexpoint2 ,lefteyeypoint2]=cord_find(left_eye_cord(1,:)); %% find the location
            
            [righteyexpoint, righteyeypoint, righteyexpoint1, rightyeyeypoint1 ,righteyexpoint2, righteyeypoint2]=cord_find(right_eye_cord(1,:)); %% find the location
            
            [nosexpoint, noseypoint, nosexpoint1, noseypoint1, nosexpoint2, noseypoint2]=cord_find(nose_cord(1,:)); %% find the location
            
            
            
            % plot the image and show point
            
%             subplot(1,2,1),imshow(videoFrame_img(:,:,1))
%             
%             subplot(1,2,2),imshow(videoFrame_img(:,:,1))
            
           % hold on,plot(facexpoint,faceypoint,'c:s');
           % hold on,plot(mouthxpoint,mouthypoint,'g:s'); 
           % hold on,plot(lefteyexpoint,lefteyeypoint,'b:s');
           % hold on,plot(righteyexpoint,righteyeypoint,'b:s');
            
           % hold on,plot(nosexpoint,noseypoint,'b:s');
            
             pause(0.1);
         
            
            % extract face eye motuh region
            [faceimg,eyeimg,mouthimg,front_face_img,lefteye_img,righteye_img,nose_img,final_fe_pt]=face_parts_extract(videoFrame_img,eyepairxpoint, eyepairypoint,...
                                                                                                                      mouthxpoint,mouthypoint,...
                                                                                                                      facexpoint,faceypoint,...
                                                                                                                      frontfacexpoint,frontfaceypoint,...
                                                                                                                      lefteyexpoint,lefteyeypoint,...
                                                                                                                      righteyexpoint,righteyeypoint,...
                                                                                                                      nosexpoint,noseypoint);
          
 % show the result
%                     subplot(3,2,2),imshow(faceimg);
%                      subplot(3,2,4),imshow(eyeimg);
%                      subplot(3,2,6),imshow(mouthimg);
%             
%                      figure,
%                      subplot(2,2,1),imshow(front_face_img);
%                      subplot(2,2,2),imshow(lefteye_img);
%                      subplot(2,2,3),imshow(righteye_img);
%                      subplot(2,2,3),imshow(nose_img);

                                                                                                                  
            final_data_feat_test(index,1:26)=[final_fe_pt];
            index=index+1;
            for jj=1:size(final_data_feat_test,1)
            for ii=1:size(train_data,1)
                finaltest(ii,:)=train_data(ii,:)-final_data_feat_test(jj,:);
                
            end
               finaltest1=abs(sum(finaltest,2));
               [a b]=min(finaltest1);
               finaltestval(jj)=b;
            end
            
        end
        
    end
    
end
dc=index;


load data_base_in_feature.mat

train_data=final_data_feat(:,1:end-1);
train_class=final_data_feat(:,end)';


test_data=final_data_feat_test;
train_class=full(ind2vec(train_class));
network_form=selforgmap(5);
network_form.trainparam.epochs=1000; %no of cycles
network_form=train(network_form,train_data',train_class);
result_som=sim(network_form,test_data');
result_som1=vec2ind(result_som);

finalt=zeros(5,length(finaltestval));

for i=1:length(finaltestval)
    
if finaltestval(i)<disgustc && finaltestval(i)>sadc-1 
    
    finaltestval1(i)=1;
    
    finalt(1,i)=1;
    d=d+1;
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              for i=1:length(r)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             if (r(i)==finaltestval)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 d=d-1;
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             end
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              end
end
end

disgust=(d/dc)*100;

%% 
index=1;sp=0;
filepath=uigetdir(cd,'Select Test Image folder:surprise');
fileloc=dir(filepath);

for i = 3:length(fileloc)
    filename=fileloc(i).name
    
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
        
        if(~isempty(eyepair_cord) && ~isempty(mouth_detect_cord) && mouth_detect_cord(1,3) >20) %% check the cordinates...
            
            
            filedir;
            
            [eyepairxpoint, eyepairypoint, eyepairxpoint1, eyepairypoint1, eyepairxpoint2, eyepairypoint2]=cord_find(eyepair_cord(1,:)); %% find the location
            [mouthxpoint, mouthypoint, mouthxpoint1, mouthypoint1, mouthxpoint2, mouhtypoint2]=cord_find(mouth_detect_cord(1,:));
            
            [facexpoint, faceypoint, facexpoint1, faceypoint1, facexpoint2, faceypoint2]=cord_find(face_cord(1,:));
            
            [frontfacexpoint, frontfaceypoint, frontfacexpoint1, frontfaceypoint1, frontfacexpoint2, frontfaceypoint2]=cord_find(front_face_cord(1,:)); %% find the location
            
            [lefteyexpoint, lefteyeypoint, lefteyexpoint1, lefteyeypoint1 ,lefteyexpoint2 ,lefteyeypoint2]=cord_find(left_eye_cord(1,:)); %% find the location
            
            [righteyexpoint, righteyeypoint, righteyexpoint1, rightyeyeypoint1 ,righteyexpoint2, righteyeypoint2]=cord_find(right_eye_cord(1,:)); %% find the location
            
            [nosexpoint, noseypoint, nosexpoint1, noseypoint1, nosexpoint2, noseypoint2]=cord_find(nose_cord(1,:)); %% find the location
            
            
            
            % plot the image and show point
            
%             subplot(1,2,1),imshow(videoFrame_img(:,:,1))
%             
%             subplot(1,2,2),imshow(videoFrame_img(:,:,1))
            
           % hold on,plot(facexpoint,faceypoint,'c:s');
          % hold on,plot(mouthxpoint,mouthypoint,'g:s'); 
           % hold on,plot(lefteyexpoint,lefteyeypoint,'b:s');
           % hold on,plot(righteyexpoint,righteyeypoint,'b:s');
            
           % hold on,plot(nosexpoint,noseypoint,'b:s');
            
             pause(0.1);
         
            
            % extract face eye motuh region
            [faceimg,eyeimg,mouthimg,front_face_img,lefteye_img,righteye_img,nose_img,final_fe_pt]=face_parts_extract(videoFrame_img,eyepairxpoint, eyepairypoint,...
                                                                                                                      mouthxpoint,mouthypoint,...
                                                                                                                      facexpoint,faceypoint,...
                                                                                                                      frontfacexpoint,frontfaceypoint,...
                                                                                                                      lefteyexpoint,lefteyeypoint,...
                                                                                                                      righteyexpoint,righteyeypoint,...
                                                                                                                      nosexpoint,noseypoint);

                                                                                                                   % show the result
%                     subplot(3,2,2),imshow(faceimg);
%                      subplot(3,2,4),imshow(eyeimg);
%                      subplot(3,2,6),imshow(mouthimg);
%             
%                      figure,
%                      subplot(2,2,1),imshow(front_face_img);
%                      subplot(2,2,2),imshow(lefteye_img);
%                      subplot(2,2,3),imshow(righteye_img);
%                      subplot(2,2,3),imshow(nose_img);

            
            final_data_feat_test(index,1:26)=[final_fe_pt];
            index=index+1;
            for jj=1:size(final_data_feat_test,1)
            for ii=1:size(train_data,1)
                finaltest(ii,:)=train_data(ii,:)-final_data_feat_test(jj,:);
                
            end
               finaltest1=abs(sum(finaltest,2));
               [a b]=min(finaltest1);
               finaltestval(jj)=b;
            end
            
        end
        
    end
    
end
spc=index;

load data_base_in_feature.mat

train_data=final_data_feat(:,1:end-1);
train_class=final_data_feat(:,end)';


test_data=final_data_feat_test;
train_class=full(ind2vec(train_class));
network_form=selforgmap(5);
network_form.trainparam.epochs=1000; %no of cycles
network_form=train(network_form,train_data',train_class);
result_som=sim(network_form,test_data');
result_som1=vec2ind(result_som);

finalt=zeros(5,length(finaltestval));

for i=1:length(finaltestval)
    
if finaltestval(i)>disgustc
    
    finaltestval1(i)=1;
    
    finalt(1,i)=1;
    sp=sp+1;
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              for i=1:length(r)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             if (r(i)==finaltestval)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 sp=sp-1;
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             end
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              end
end
end

surprise=(sp/spc)*100;

%% 

RANGE=1:1:5;

error=[anger disgust happy sad surprise];

figure,semilogy(RANGE,error,'bo:','linestyle','-','linewidth',2);

hold on;

% semilogy(RANGE,error,'bo:','linestyle','-','linewidth',2);

xlabel('Emotions');

ylabel('TAR');
ylim(0, 100);
legend('K-som');
grid on










