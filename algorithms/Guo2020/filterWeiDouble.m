function flag = filterWeiDouble(link,number_weight,length_weight)
link_num = numel(link);
flag = zeros(link_num,1);
combineMa=sortrows([number_weight',length_weight]);
temp = unique(combineMa(:,1));
number_threshold = (temp(1)>0)*temp(1) + (temp(1)==0)*temp(2);
% number_threshold = 2;% for delta
locNumber = combineMa(:,1)<=number_threshold;
length_threshold = median(combineMa(locNumber,2));
parfor i = 1:link_num
    if number_weight(i)<=number_threshold && length_weight(i)<length_threshold
        flag(i) = 1;
    end
end
