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

disp(['Number of street addresses in Stavanger: ', num2str(number_of_streets_in_dataset)]);
disp(['Number of unique streets in Stavanger: ', num2str(number_of_streets_in_stavanger)]);

% According to central bureau of statistics in Norway
% https://www.ssb.no/kommunefakta/stavanger
% by the 3rd quarter of 2021
% there are 144515 residents in norway
residents_of_stavanger = 144515;

average_per_street = residents_of_stavanger/number_of_streets_in_stavanger;

disp(['Average number of residents per street: ', num2str(average_per_street)]);
