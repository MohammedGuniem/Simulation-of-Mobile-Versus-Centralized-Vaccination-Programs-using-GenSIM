clear all; 
clc;

fileName = 'Stavanger_Street_Data.json';
str = fileread(fileName);
data = jsondecode(str);

%res = data.features.properties;

streets = string(missing);

number_of_streets_in_dataset = 0; 
number_of_streets_in_stavanger = 0; 

for k=1:numel(data.features)
   street = data.features(k).properties.Gatenavn;
   number_of_streets_in_dataset = number_of_streets_in_dataset +1;
   if ~any(strcmp(streets, street))
       streets(k) = street;
       number_of_streets_in_stavanger = number_of_streets_in_stavanger +1;
   end
end

number_of_streets_in_dataset
number_of_streets_in_stavanger

residents_of_stavanger = 141000;

average_per_street = residents_of_stavanger/number_of_streets_in_stavanger