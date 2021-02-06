clc
clear all
close all

filepath=uigetdir(cd,'Select Test Image folder');
fileloc=dir(filepath);
index=1;

load data_base_in_feature.mat
train_data=final_data_feat(:,1:end-1);
for i = 4:length(fileloc)
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
            
            
            
            
           [eyepairxpoint, eyepairypoint, eyepairxpoint1, eyepairypoint1, eyepairxpoint2, eyepairypoint2]=cord_find(eyepair_cord(1,:)); %% find the location
            [mouthxpoint, mouthypoint, mouthxpoint1, mouthypoint1, mouthxpoint2, mouhtypoint2]=cord_find(mouth_detect_cord(1,:));
            
            [facexpoint, faceypoint, facexpoint1, faceypoint1, facexpoint2, faceypoint2]=cord_find(face_cord(1,:));
            
            [frontfacexpoint, frontfaceypoint, frontfacexpoint1, frontfaceypoint1, frontfacexpoint2, frontfaceypoint2]=cord_find(front_face_cord(1,:)); %% find the location
            
            [lefteyexpoint, lefteyeypoint, lefteyexpoint1, lefteyeypoint1 ,lefteyexpoint2 ,lefteyeypoint2]=cord_find(left_eye_cord(1,:)); %% find the location
            
            [righteyexpoint, righteyeypoint, righteyexpoint1, rightyeyeypoint1 ,righteyexpoint2, righteyeypoint2]=cord_find(right_eye_cord(1,:)); %% find the location
            
            [nosexpoint, noseypoint, nosexpoint1, noseypoint1, nosexpoint2, noseypoint2]=cord_find(nose_cord(1,:)); %% find the location
             
            figure,
            
            % plot the image and show point
            
           subplot(1,2,1),imshow(videoFrame_img(:,:,1))
            
            subplot(1,2,2),imshow(videoFrame_img(:,:,1))
            
            
         
            
            % extract face eye motuh region
           [faceimg,eyeimg,mouthimg,front_face_img,lefteye_img,righteye_img,nose_img,final_fe_pt]=face_parts_extract(videoFrame_img,eyepairxpoint, eyepairypoint,...
                                                                                                                      mouthxpoint,mouthypoint,...
                                                                                                                      facexpoint,faceypoint,...
                                                                                                                      frontfacexpoint,frontfaceypoint,...
                                                                                                                      lefteyexpoint,lefteyeypoint,...
                                                                                                                      righteyexpoint,righteyeypoint,...
                                                                                                                      nosexpoint,noseypoint);
                                                                                                                  
           
                     subplot(3,2,2),imshow(faceimg);
                     subplot(3,2,4),imshow(eyeimg);
                     subplot(3,2,6),imshow(mouthimg);
            
                     figure,
                     subplot(2,2,1),imshow(front_face_img);
                     subplot(2,2,2),imshow(lefteye_img);
                     subplot(2,2,3),imshow(righteye_img);
                     subplot(2,2,3),imshow(nose_img);
                                                                                                                                                                                                         
            
            final_data_feat_test(index,1:26)=final_fe_pt;
            
            for ii=1:size(train_data,1)
                finaltest(ii,:)=train_data(ii,:)-final_data_feat_test(index,:);
                
            end
               finaltest1=abs(sum(finaltest,2));
               [a b]=min(finaltest1);
               finaltestval(index)=b;
               index=index+1;
        end
        
    end
    
end

 save abc finaltest finaltestval final_data_feat_test

result_class{1}='Anger';
result_class{2}='Happy';
result_class{4}='Disgust';
result_class{3}='Sad';
result_class{5}='Surprise';




load data_base_in_feature.mat

train_data=final_data_feat(:,1:end-1);
train_class=final_data_feat(:,end)';


somnet = newsom( train_data, [5 5] );
my_clusters = somnet.IW;
network_form=selforgmap(5);
network_form.trainparam.epochs=100; %no of cycles
network_form=train(network_form,train_data',train_class);
result_som=sim(network_form,my_clusters');
result_som1=vec2ind(result_som);
% for j=1:length(finaltestval)
% 
%     FINAL_RESULT_SOM{j}=result_class{finaltestval(j)};
% end
% 
% FINAL_RESULT_SOM=FINAL_RESULT_SOM;
finalt=zeros(5,length(finaltestval));

for i=1:length(finaltestval)
if finaltestval(i)<angryc && finaltestval(i)>0 
    finaltestval1(i)=1;
    finalt(1,i)=1;
elseif finaltestval(i)<happyc && finaltestval(i)>angryc-1 
    finaltestval1(i)=2;
    finalt(2,i)=1;
elseif finaltestval(i)<sadc && finaltestval(i)>happyc-1
    finaltestval1(i)=3;
    finalt(3,i)=1;
elseif finaltestval(i)<disgustc && finaltestval(i)>sadc-1
    finaltestval1(i)=4;
    finalt(4,i)=1;
else
    finaltestval1(i)=5;
    finalt(5,i)=1;
end
end
for j=1:length(finaltestval1)

    FINAL_RESULT_SOM{j}=result_class{finaltestval1(j)};
end
% set(handles.text5,'String',FINAL_RESULT_SOM{1});
FINAL_RESULT_SOM=FINAL_RESULT_SOM;
hello=full(ind2vec(finaltestval1));
figure;
plotconfusion(finalt,train_class);
