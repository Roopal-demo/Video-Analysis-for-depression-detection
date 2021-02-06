function [xpoint ypoint xpoint1 ypoint1 xpoint2 ypoint2]=pointer_process(cord_val)


x1=cord_val(1);
y1=cord_val(2);
x2=x1+cord_val(3);
y2=y1;x3=x1;
y3=y1+cord_val(4);
x4=x1+cord_val(3);
y4=y1+cord_val(4);


xpoint=[x1 x2 x4 x3 x1];
ypoint=[y1 y2 y4 y3 y1];


x11=(x1+x2)/2;
y11=(y1+y2)/2;

x22=(x3+x4)/2;
y22=(y3+y4)/2;

xpoint1=randsrc(1,100,x11:x22);
ypoint1=randsrc(1,100,y11:y22);

x11=x1;
y11=y1+((y1+y4)*0.2);

x22=x2;
y22=y2+((y3+y2)*0.2);
xpoint2=randsrc(1,100,x11:x22);
ypoint2=randsrc(1,100,y11:y22);


