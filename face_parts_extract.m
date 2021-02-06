function [faceimg,eyeimg,mouthimg,front_face_img,...
                lefteye_img,righteye_img,nose_img,final_fe_pt]=face_parts_extract(img,eyepairxpoint,...
                                                      eyepairypoint,mouthxpoint,mouthypoint,...
                                                      facexpoint,faceypoint,...
                                                      frontfacexpoint,frontfaceypoint,...
                                                      lefteyexpoint,lefteyeypoint,...
                                                      righteyexpoint,righteyeypoint,...
                                                      nosexpoint,noseypoint);


                            
a1=[frontfacexpoint(1) frontfaceypoint(1)];
        a2=[frontfacexpoint(2) frontfaceypoint(2)];
        a3=[frontfacexpoint(3) frontfaceypoint(3)];
        a4=[frontfacexpoint(4) frontfaceypoint(4)];
        
        
        b1=[lefteyexpoint(1) lefteyeypoint(1)];
        b2=[lefteyexpoint(2) lefteyeypoint(2)];
        b3=[lefteyexpoint(3) lefteyeypoint(3)];
        b4=[lefteyexpoint(4) lefteyeypoint(4)];
        
        
        c1=[righteyexpoint(1) righteyeypoint(1)];
        c2=[righteyexpoint(2) righteyeypoint(2)];
        c3=[righteyexpoint(3) righteyeypoint(3)];
        c4=[righteyexpoint(4) righteyeypoint(4)];
        
        
        d1=[nosexpoint(1) noseypoint(1)];
        d2=[nosexpoint(2) noseypoint(2)];
        d3=[nosexpoint(3) noseypoint(3)];
        d4=[nosexpoint(4) noseypoint(4)];
        
        
        e1=[mouthxpoint(1) mouthypoint(1)];
        e2=[mouthxpoint(2) mouthypoint(2)];
        e3=[mouthxpoint(3) mouthypoint(3)];
        e4=[mouthxpoint(4) mouthypoint(4)];
        
        
        
        f1=[eyepairxpoint(1) eyepairypoint(1)];
        f2=[eyepairxpoint(2) eyepairypoint(2)];
        f3=[eyepairxpoint(3) eyepairypoint(3)];
        f4=[eyepairxpoint(4) eyepairypoint(4)];
        
        
        fe_pt1=abs(a2(1)-a1(1))/2;
        fe_pt2=abs(a4(2)-a1(2))/2;
        fe_pt3=abs(b2(1)-b1(1))/2;
        fe_pt4=abs(b4(2)-b1(2))/2;
        fe_pt5=abs(b4(2)-b1(2))/2;
        fe_pt6=abs(b2(1)-c1(1))/2;
        fe_pt7=abs(b1(1)-c2(1))/2;
        fe_pt8=abs(d3(1)-d4(1))/2;
        fe_pt9=abs(fe_pt1-fe_pt8);
        fe_pt10=abs(e1(1)-e2(1))/2;
        fe_pt11=abs(fe_pt1-fe_pt10);
        fe_pt12=abs(e1(2)-e4(2))/2;
        fe_pt13=abs(b4(1)-b3(1))/2;
        fe_pt14=abs(c1(1)-c2(1))/2;
        fe_pt15=abs(c4(1)-c3(1))/2;
        fe_pt16=abs(fe_pt8-fe_pt10);
        
        fe_pt17=abs(f2(1)-f1(1))/2;
        fe_pt18=abs(f1(2)-f2(2))/2;
        fe_pt19=abs(f2(1)-f3(1))/2;
        fe_pt20=abs(f3(2)-f2(2))/2;
        fe_pt21=abs(f4(2)-f1(2))/2;
        fe_pt22=abs(f2(1)-f1(1))/2;
        
        fe_pt23=abs(a2(1)-a1(1))/2;
        fe_pt24=abs(a4(2)-a1(2))/2;
        fe_pt25=abs(b2(1)-b1(1))/2;
        fe_pt26=abs(b4(2)-b1(2))/2;
        
        
        
        
        
        
        
  final_fe_pt=[fe_pt1  fe_pt2 fe_pt3 fe_pt4 fe_pt5 fe_pt6 fe_pt7 fe_pt8 fe_pt9 fe_pt10... 
                fe_pt11 fe_pt12 fe_pt13 fe_pt14 fe_pt15 fe_pt16 fe_pt17 fe_pt18 fe_pt19 fe_pt20... 
                fe_pt21 fe_pt22 fe_pt23 fe_pt24 fe_pt25 fe_pt26];
        
            
 imgdata=img(:,:,1);
faceimg=imgdata(faceypoint(1):faceypoint(3),facexpoint(1):facexpoint(2));



eyeimg=imgdata(eyepairypoint(1):eyepairypoint(3),eyepairxpoint(1):eyepairxpoint(2));


mouthimg=imgdata(mouthypoint(1):mouthypoint(3),mouthxpoint(1):mouthxpoint(2));



front_face_img=imgdata(frontfaceypoint(1):frontfaceypoint(3),frontfacexpoint(1):frontfacexpoint(2));



lefteye_img=imgdata(lefteyeypoint(1):lefteyeypoint(3),lefteyexpoint(1):lefteyexpoint(2));


righteye_img=imgdata(righteyeypoint(1):righteyeypoint(3),righteyexpoint(1):righteyexpoint(2));


nose_img=imgdata(noseypoint(1):noseypoint(3),nosexpoint(1):nosexpoint(2));
