function [CP Face]=detect_control_points(I,B1,B2,B3,B4)

Th=70;
if(ndims(I)==3)
    Face=rgb2gray(I);
else
    Face=I;
end;



sz=size(I);
left_eye_center(1)=B2(1)+round(B2(3)/2);
left_eye_center(2)=B2(2)+round(B2(4)/2);


right_eye_center(1)=B3(1)+round(B3(3)/2);
right_eye_center(2)=B3(2)+round(B3(4)/2);

CP1(1)=round(median([left_eye_center(1) right_eye_center(1) ]));
CP1(2)=round(median(([left_eye_center(2) right_eye_center(2) ])));

CP2(1)=B4(1)+round(B4(3)/2);
CP2(2)=B4(2)+round(B4(4)/2);


CP3(1)=B2(1);
CP3(2)=B2(2)+round(B2(4)/2);

CP4(1)=B3(1)+B3(3);
CP4(2)=B3(2)+round(B3(4)/2);


for i=CP3(2):-1:2
    d1=abs(I(i,CP3(1))-I(i-1,CP3(1)));
    P=I(i,CP3(1));
    
    if(P<Th)
        
        break;
    end;
end;

CP5(1)=CP3(1);
CP5(2)=i;

    
for i=CP4(2):-1:2
    d1=abs(I(i,CP4(1))-I(i-1,CP4(1)));
    P=I(i,CP4(1));
    
    if(P<Th)
        break;
    end;
end;

CP6(1)=CP4(1);
CP6(2)=i;

for i=CP1(2):-1:2
    d1=abs(I(i,CP1(1))-I(i-1,CP1(1)));
    P=I(i,CP1(1));
    
    if(P<Th)
    
        
        break;
    end;
end;

CP7(1)=CP1(1);
CP7(2)=i;


for i=CP3(2):sz(1)-2;
    d1=abs(I(i,CP3(1))-I(i+1,CP3(1)));
    
    if(d1>10)
        
        break;
    end;
end;

CP8(1)=CP3(1);
CP8(2)=i;

for i=CP4(2):sz(1)-2;
    d1=abs(I(i,CP4(1))-I(i+1,CP4(1)));
    
    if(d1>10)
        
        break;
    end;
end;

CP9(1)=CP4(1);
CP9(2)=i;

CP{1}=CP1;
CP{2}=CP2;
CP{3}=CP3;
CP{4}=CP4;
CP{5}=CP5;
CP{6}=CP6;
CP{7}=CP7;
%CP{8}=CP8;
%CP{9}=CP9;


