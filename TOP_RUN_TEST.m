clc
clear all
close all

filepath=uigetdir(cd,'Select Test Image folder');
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
        
        if(~isempty(eyepair_cord) && ~isempty(mouth_detect_cord) && mouth_detect_cord(1,3) >60) %% check the
            
            
            
            
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
            final_data_feat_test(index,1:26)=final_fe_pt;
            index=index+1;
            
            
        end
        
    end
    
end

%%

result_class{1}='Anger';
result_class{2}='Happy';
result_class{3}='Disgust';
result_class{4}='Sad';
result_class{5}='Surprise';



load data_base_in_feature.mat

train_data=final_data_feat(:,1:end-1);
train_class=[final_data_feat(:,end)']';




test_data=train_data;
train_class=full(ind2vec(train_class'));
network_form=selforgmap(5);
network_form.trainparam.epochs=100;%no of cycles
network_form=train(network_form,train_data',train_class);
result_som=sim(network_form,train_data');

result_som1=vec2ind(result_som);


for k7=1:length(result_som1)

    FINAL_RESULT_SOM{k7}=result_class{result_som1(1,k7)};
end

FINAL_RESULT_SOM=FINAL_RESULT_SOM





[ff COMF]=confusion(result_som,train_class);

CONFUSION_MATRIX=COMF


figure,plotconfusion(result_som,train_class);






fprintf('    --------------------------------------------------------------------------------------------------------------------------------'); 
fprintf('\n');
fprintf('                                   Facial expression results   confusion matrix                                '); 
fprintf('\n');
fprintf('    --------------------------------------------------------------------------------------------------------------------------------'); 
fprintf('\n');
fprintf('%25.18s %15.18s %15.18s %15.18s %15.18s %15.18s','type',...
                                                'Anger',...
                                                'Happy',...
                                                'Disgust',...
                                                'sad',...
                                                'surprise');
fprintf('\n');
fprintf('    -----------------------------------------------------------------------------------------------------------------------------------');    
fprintf('\n');
inx=1;
for k7=1:5

fprintf('%25.18s %15.18s %15.18s %15.18s %15.18s %15.18s',result_class{k7},...
                                                num2str(CONFUSION_MATRIX(k7,1)),...
                                                num2str(CONFUSION_MATRIX(k7,2)),...
                                                num2str(CONFUSION_MATRIX(k7,3)),...
                                                num2str(CONFUSION_MATRIX(k7,4)),...
                                                num2str(CONFUSION_MATRIX(k7,5)));
    fprintf('\n');
    
    inx=inx+1;
    
end

fprintf('\n');









