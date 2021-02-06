function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 20-Oct-2020 23:55:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
clc;
warning off;
% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;




% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filepath=uigetdir(cd,'Select An Image folder');
set(handles.lblFolder,'String',filepath);
emotion = menu('Select emotion','Depressive','Non Depressive','Neutral');
save('filepath','filepath','emotion');

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('filepath','filepath','emotion');
fileloc = dir(filepath);

try
    load('database','features','emotions');
catch ex
    features = [];
    emotions = [];
    save('database','features','emotions');
end

face_detector = buildDetector();
for i = 3:length(fileloc)
    filename=fileloc(i).name
    
    if(strcmp(filename,'Thumbs.db')==0)
        filedir=strcat(filepath,'\',filename);
        img=imread(filedir);
        I = img;
        Bbox = Detect_face_pts(face_detector,I,2);
        if(size(Bbox,1) == 0)
            %If no face was detected by the detector
            imshow(I);
            title('No face detected');
        else
            %Find the face, left eye and right eye and mouth box
            face_box1=Bbox(1,1:4);
            left_eye1=Bbox(1,5:8);
            right_eye1=Bbox(1,9:12);
            mouth_box1=Bbox(1,13:16);
            nose_box1=Bbox(1,17:20);

            %Increment the counter
            idx = (find(Bbox == 0));
            Bbox(idx) = 1:length(idx);
            face_box=Bbox(1,1:4);
            left_eye=Bbox(1,5:8);
            right_eye=Bbox(1,9:12);
            mouth_box=Bbox(1,13:16);
            nose_box=Bbox(1,17:20);

            axes(handles.axes8);
            imshow(I),title(' Pre-Processed Image');

            axes(handles.axes3);
            imshow(I),title('Detected Face Parts');
            hold on
            rectangle('position',face_box);
            hold on
            rectangle('position',left_eye);
            hold on
            rectangle('position',right_eye);
            hold on
            rectangle('position',mouth_box);
            hold on
            rectangle('position',nose_box);

            eye_width = (left_eye(3) + right_eye(3))/2;
            eye_height = (left_eye(4) + right_eye(4))/2;
            nose_width = nose_box(3);
            nose_height = nose_box(4);
            mouth_width = mouth_box(3);
            mouth_height = mouth_box(4);
            e2e_dist = pdist([left_eye(1) left_eye(2);right_eye(1) right_eye(2)]);
            le2n_dist = pdist([left_eye(1) left_eye(2);nose_box(1) nose_box(2)]);
            re2n_dist = pdist([right_eye(1) right_eye(2);nose_box(1) nose_box(2)]);
            le2m_dist = pdist([left_eye(1) left_eye(2);mouth_box(1) mouth_box(2)]);
            re2m_dist = pdist([right_eye(1) right_eye(2);mouth_box(1) mouth_box(2)]);
            n2m_dist = pdist([nose_box(1) nose_box(2);mouth_box(1) mouth_box(2)]);

            face_feature=[eye_width,eye_height,nose_width,nose_height,mouth_width,mouth_height,e2e_dist,le2n_dist,re2n_dist,le2m_dist,re2m_dist,n2m_dist];
            str = sprintf('Eye Width:%0.02f, Eye Height:%0.02f\nNose Width:%0.02f, Nose Height:%0.02f\nMouth Width:%0.02f, Mouth Height:%0.02f\n,Eye to eye Distance:%0.02f\nLeft Eye to Nose Distance:%0.02f\nRight Eye to Nose Distance:%0.02f\nLeft Eye to Mouth Distance:%0.02f\nRight Eye to Mouth Distance:%0.02f\nNose to Mouth Distance:%0.02f',eye_width,eye_height,nose_width,nose_height,mouth_width,mouth_height,e2e_dist,le2n_dist,re2n_dist,le2m_dist,re2m_dist,n2m_dist);
            
            db_count = length(emotions) + 1;
            features(:,db_count) = face_feature;
            emotions(db_count) = emotion;
            set(handles.lblEmotion,'String',emotion);
            save('database','features','emotions');
            
            set(handles.lblFeatures,'String',str);
        end
        pause(0.1);
    end
    
end
ch = menu(sprintf('Database saved with %d entries\nWhat to do next?',db_count),'Clear DB','Exit');
if(ch == 1)
    ch = menu('Are you sure','Yes','No');
    if(ch == 1)
        features = [];
        emotions = [];
        save('database','features','emotions');
        menu('DB Cleared','Ok');
    end
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global file;
[filename, pathname]=uigetfile('*.*','Selet Image for Recognition');
file=strcat(pathname,filename);
  axes(handles.axes8),imshow(imread(file));
  axes(handles.axes9),imshow(imread(file));

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
graaph2;

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = get(hObject, 'String');
val = get(hObject,'Value');

wtype=str{val};
save av str val wtype
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2
str = get(hObject, 'String');
val = get(hObject,'Value');

wtype1=str{val};
save avv str val wtype1

% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
graaph;




% --- Executes during object creation, after setting all properties.
function axes7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axes(hObject);
imshow('main.jpg');

% Hint: place code in OpeningFcn to populate axes7


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('filepath','filepath','emotion');
fileloc = dir(filepath);

try
    load('database','features','emotions');
catch ex
    menu('No Database Found','Exit');
    return;
end

face_detector = buildDetector();

acc_som = 0;
acc_ksom = 0;
delay_som = 0;
delay_ksom = 0;

emotion_str = {'Depressive','Non Depressive','Neutral'};
tot_count = 0;

for i = 3:length(fileloc)
    filename=fileloc(i).name
    
    if(strcmp(filename,'Thumbs.db')==0)
        filedir=strcat(filepath,'\',filename);
        img=imread(filedir);
        I = img;
        Bbox = Detect_face_pts(face_detector,I,2);
        if(size(Bbox,1) == 0)
            %If no face was detected by the detector
            imshow(I);
            title('No face detected');
        else
            %Find the face, left eye and right eye and mouth box
            face_box1=Bbox(1,1:4);
            left_eye1=Bbox(1,5:8);
            right_eye1=Bbox(1,9:12);
            mouth_box1=Bbox(1,13:16);
            nose_box1=Bbox(1,17:20);

            %Increment the counter
            idx = (find(Bbox == 0));
            Bbox(idx) = 1:length(idx);
            face_box=Bbox(1,1:4);
            left_eye=Bbox(1,5:8);
            right_eye=Bbox(1,9:12);
            mouth_box=Bbox(1,13:16);
            nose_box=Bbox(1,17:20);

            axes(handles.axes8);
            imshow(I),title(' Pre-Processed Image');

            axes(handles.axes3);
            imshow(I),title('Detected Face Parts');
            hold on
            rectangle('position',face_box);
            hold on
            rectangle('position',left_eye);
            hold on
            rectangle('position',right_eye);
            hold on
            rectangle('position',mouth_box);
            hold on
            rectangle('position',nose_box);

            eye_width = (left_eye(3) + right_eye(3))/2;
            eye_height = (left_eye(4) + right_eye(4))/2;
            nose_width = nose_box(3);
            nose_height = nose_box(4);
            mouth_width = mouth_box(3);
            mouth_height = mouth_box(4);
            e2e_dist = pdist([left_eye(1) left_eye(2);right_eye(1) right_eye(2)]);
            le2n_dist = pdist([left_eye(1) left_eye(2);nose_box(1) nose_box(2)]);
            re2n_dist = pdist([right_eye(1) right_eye(2);nose_box(1) nose_box(2)]);
            le2m_dist = pdist([left_eye(1) left_eye(2);mouth_box(1) mouth_box(2)]);
            re2m_dist = pdist([right_eye(1) right_eye(2);mouth_box(1) mouth_box(2)]);
            n2m_dist = pdist([nose_box(1) nose_box(2);mouth_box(1) mouth_box(2)]);

            face_feature=[eye_width,eye_height,nose_width,nose_height,mouth_width,mouth_height,e2e_dist,le2n_dist,re2n_dist,le2m_dist,re2m_dist,n2m_dist];
            str = sprintf('Eye Width:%0.02f, Eye Height:%0.02f\nNose Width:%0.02f, Nose Height:%0.02f\nMouth Width:%0.02f, Mouth Height:%0.02f\n,Eye to eye Distance:%0.02f\nLeft Eye to Nose Distance:%0.02f\nRight Eye to Nose Distance:%0.02f\nLeft Eye to Mouth Distance:%0.02f\nRight Eye to Mouth Distance:%0.02f\nNose to Mouth Distance:%0.02f',eye_width,eye_height,nose_width,nose_height,mouth_width,mouth_height,e2e_dist,le2n_dist,re2n_dist,le2m_dist,re2m_dist,n2m_dist);
            
            set(handles.lblFeatures,'String',str);
            save('state');
            tic;
            class1 = evaluatekSOM(face_feature,features',emotions);
            delay1 = toc;
            delay_som = delay_som + delay1;
            
            tic;
            class2 = evaluateAdvSOM(face_feature,features',emotions);
            delay2 = toc;
            delay_ksom = delay_ksom + delay2;
            
            emotion_som = emotion_str{class1};
            emotion_ksom = emotion_str{class2};
            
            set(handles.lblEmotion,'String',sprintf('Adv. SOM Emotion:%s\n',emotion_ksom));
            set(handles.lblDelay,'String',sprintf('Adv. SOM:%0.04f s',delay2));
            
            if(class1 == emotion)
                acc_som = acc_som + 1;
            end
            if(class2 == emotion)
                acc_ksom = acc_ksom + 1;
            end
            tot_count = tot_count + 1;
        end
        pause(0.1);
    end
end
menu(sprintf('Accuracy of Adv. SOM:%0.04f %%\nMean Delay Adv. SOM:%0.04f s',(acc_ksom*100/tot_count),delay_ksom/tot_count),'Ok');


% --- Executes during object creation, after setting all properties.
function axes8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes8


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file,path] = uigetfile('*.avi');
vid = read(VideoReader([path,file]));
num_frames = str2num(cell2mat(inputdlg(sprintf('Enter number of frames to process (1-%d)',size(vid,4)))));
folder_name = cell2mat(inputdlg(sprintf('Enter folder name to store')));
try
    mkdir(folder_name);
end
for count=1:num_frames
    img = vid(:,:,:,count);
    imwrite(img,sprintf('%s/%d.jpg',folder_name,count));
    axes(handles.axes8);
    imshow(img);
    title(sprintf('Video frame %d',count));
    pause(0.01);
end


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file,path] = uigetfile('*.*');

try
    load('database','features','emotions');
catch ex
    menu('No Database Found','Exit');
    return;
end

face_detector = buildDetector();

emotion_str = {'Depressive','Non Depressive','Neutral'};
img=imread([path,file]);
I = img;
Bbox = Detect_face_pts(face_detector,I,2);
if(size(Bbox,1) == 0)
    %If no face was detected by the detector
    imshow(I);
    title('No face detected');
else
    %Find the face, left eye and right eye and mouth box
    face_box1=Bbox(1,1:4);
    left_eye1=Bbox(1,5:8);
    right_eye1=Bbox(1,9:12);
    mouth_box1=Bbox(1,13:16);
    nose_box1=Bbox(1,17:20);

    %Increment the counter
    idx = (find(Bbox == 0));
    Bbox(idx) = 1:length(idx);
    face_box=Bbox(1,1:4);
    left_eye=Bbox(1,5:8);
    right_eye=Bbox(1,9:12);
    mouth_box=Bbox(1,13:16);
    nose_box=Bbox(1,17:20);

    axes(handles.axes8);
    imshow(I),title(' Pre-Processed Image');

    axes(handles.axes3);
    imshow(I),title('Detected Face Parts');
    hold on
    rectangle('position',face_box);
    hold on
    rectangle('position',left_eye);
    hold on
    rectangle('position',right_eye);
    hold on
    rectangle('position',mouth_box);
    hold on
    rectangle('position',nose_box);

    eye_width = (left_eye(3) + right_eye(3))/2;
    eye_height = (left_eye(4) + right_eye(4))/2;
    nose_width = nose_box(3);
    nose_height = nose_box(4);
    mouth_width = mouth_box(3);
    mouth_height = mouth_box(4);
    e2e_dist = pdist([left_eye(1) left_eye(2);right_eye(1) right_eye(2)]);
    le2n_dist = pdist([left_eye(1) left_eye(2);nose_box(1) nose_box(2)]);
    re2n_dist = pdist([right_eye(1) right_eye(2);nose_box(1) nose_box(2)]);
    le2m_dist = pdist([left_eye(1) left_eye(2);mouth_box(1) mouth_box(2)]);
    re2m_dist = pdist([right_eye(1) right_eye(2);mouth_box(1) mouth_box(2)]);
    n2m_dist = pdist([nose_box(1) nose_box(2);mouth_box(1) mouth_box(2)]);

    face_feature=[eye_width,eye_height,nose_width,nose_height,mouth_width,mouth_height,e2e_dist,le2n_dist,re2n_dist,le2m_dist,re2m_dist,n2m_dist];
    str = sprintf('Eye Width:%0.02f, Eye Height:%0.02f\nNose Width:%0.02f, Nose Height:%0.02f\nMouth Width:%0.02f, Mouth Height:%0.02f\n,Eye to eye Distance:%0.02f\nLeft Eye to Nose Distance:%0.02f\nRight Eye to Nose Distance:%0.02f\nLeft Eye to Mouth Distance:%0.02f\nRight Eye to Mouth Distance:%0.02f\nNose to Mouth Distance:%0.02f',eye_width,eye_height,nose_width,nose_height,mouth_width,mouth_height,e2e_dist,le2n_dist,re2n_dist,le2m_dist,re2m_dist,n2m_dist);

    set(handles.lblFeatures,'String',str);
    tic;
    class2 = evaluateAdvSOM(face_feature,features',emotions);
    delay2 = toc;
    try
        emotion_ksom = emotion_str{class2};
    catch ex
        emotion_ksom = emotion_str{2};
    end

    set(handles.lblEmotion,'String',sprintf('Adv. SOM Emotion:%s\n',emotion_ksom));
    set(handles.lblDelay,'String',sprintf('Adv. SOM:%0.04f s',delay2));
end


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    load('database','features','emotions');
catch ex
    menu('No Database Found','Exit');
    return;
end

face_detector = buildDetector();

acc_som = 0;
acc_ksom = 0;
delay_som = 0;
delay_ksom = 0;

emotion_str = {'Depressive','Non Depressive','Neutral'};
tot_count = 0;

[file,path] = uigetfile('*.avi');
vid = read(VideoReader([path,file]));
num_frames = str2num(cell2mat(inputdlg(sprintf('Enter number of frames to use (1-%d)',size(vid,4)))));
out_classes = zeros([1 num_frames]);
out_str = 'Frame, Emotion';

for i = 1:num_frames
    
    img=vid(:,:,:,i);
    I = img;
    Bbox = Detect_face_pts(face_detector,I,2);
    if(size(Bbox,1) == 0)
        %If no face was detected by the detector
        imshow(I);
        title('No face detected');
    else
        %Find the face, left eye and right eye and mouth box
        face_box1=Bbox(1,1:4);
        left_eye1=Bbox(1,5:8);
        right_eye1=Bbox(1,9:12);
        mouth_box1=Bbox(1,13:16);
        nose_box1=Bbox(1,17:20);

        %Increment the counter
        idx = (find(Bbox == 0));
        Bbox(idx) = 1:length(idx);
        face_box=Bbox(1,1:4);
        left_eye=Bbox(1,5:8);
        right_eye=Bbox(1,9:12);
        mouth_box=Bbox(1,13:16);
        nose_box=Bbox(1,17:20);

        axes(handles.axes8);
        imshow(I),title(' Pre-Processed Image');

        axes(handles.axes3);
        imshow(I),title('Detected Face Parts');
        hold on
        rectangle('position',face_box);
        hold on
        rectangle('position',left_eye);
        hold on
        rectangle('position',right_eye);
        hold on
        rectangle('position',mouth_box);
        hold on
        rectangle('position',nose_box);

        eye_width = (left_eye(3) + right_eye(3))/2;
        eye_height = (left_eye(4) + right_eye(4))/2;
        nose_width = nose_box(3);
        nose_height = nose_box(4);
        mouth_width = mouth_box(3);
        mouth_height = mouth_box(4);
        e2e_dist = pdist([left_eye(1) left_eye(2);right_eye(1) right_eye(2)]);
        le2n_dist = pdist([left_eye(1) left_eye(2);nose_box(1) nose_box(2)]);
        re2n_dist = pdist([right_eye(1) right_eye(2);nose_box(1) nose_box(2)]);
        le2m_dist = pdist([left_eye(1) left_eye(2);mouth_box(1) mouth_box(2)]);
        re2m_dist = pdist([right_eye(1) right_eye(2);mouth_box(1) mouth_box(2)]);
        n2m_dist = pdist([nose_box(1) nose_box(2);mouth_box(1) mouth_box(2)]);

        face_feature=[eye_width,eye_height,nose_width,nose_height,mouth_width,mouth_height,e2e_dist,le2n_dist,re2n_dist,le2m_dist,re2m_dist,n2m_dist];
        str = sprintf('Eye Width:%0.02f, Eye Height:%0.02f\nNose Width:%0.02f, Nose Height:%0.02f\nMouth Width:%0.02f, Mouth Height:%0.02f\n,Eye to eye Distance:%0.02f\nLeft Eye to Nose Distance:%0.02f\nRight Eye to Nose Distance:%0.02f\nLeft Eye to Mouth Distance:%0.02f\nRight Eye to Mouth Distance:%0.02f\nNose to Mouth Distance:%0.02f',eye_width,eye_height,nose_width,nose_height,mouth_width,mouth_height,e2e_dist,le2n_dist,re2n_dist,le2m_dist,re2m_dist,n2m_dist);

        set(handles.lblFeatures,'String',str);
        save('state');
        tic;
        class1 = evaluatekSOM(face_feature,features',emotions);
        delay1 = toc;
        delay_som = delay_som + delay1;

        tic;
        class2 = evaluateAdvSOM(face_feature,features',emotions);
        delay2 = toc;
        delay_ksom = delay_ksom + delay2;

        emotion_som = emotion_str{class1};
        emotion_ksom = emotion_str{class2};
        out_classes(i) = class2;
        out_str = sprintf('%s\nFrame %d, %s',out_str,i,emotion_ksom);
        
        set(handles.lblEmotion,'String',sprintf('Adv. SOM Emotion:%s\n',emotion_ksom));
        set(handles.lblDelay,'String',sprintf('Adv. SOM:%0.04f s',delay2));

        tot_count = tot_count + 1;
    end
    pause(0.1);
end
menu(sprintf('Mean Delay Adv. SOM:%0.04f s',delay_ksom/tot_count),'Ok');
final_class = mode(out_classes);
emotion_ksom = emotion_str{final_class};
set(handles.lblEmotion,'String',sprintf('Most probable emotion:%s\n',emotion_ksom));
fid = fopen('result.csv','w');
fprintf(fid,out_str);
fclose(fid);
menu('Results saved as results.csv','Ok');