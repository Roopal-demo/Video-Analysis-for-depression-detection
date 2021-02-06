load abc
finaltt=zeros(5,length(finaltestval));
for i=1:length(r)
if (r(i)==finaltestval1) 
    for j=1:length(finaltestval1)
        z=finaltestval1+1;
    FINAL_RESULT_SOM{j}=result_class{z};
    
    end
end
end
finaltt(z,1)=1;

set(handles.text5,'String',FINAL_RESULT_SOM{1});
figure;plotconfusion(finaltt,train_class);







                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        