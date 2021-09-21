%%% Data_Cleaning %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Read 47 raw data files from the Raw_Data folder 
%%% Clean using similar procedures to Gao et. al
%%%  - Ages 96+are omitted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

max_age = 95 % ages 96+ are omitted
n_years = 45 % there are 45 total years of data 

% Get files relative to project root folder ------------------------------
proj = matlab.project.rootProject; %gets all wav files in struct
raw_data_path = proj.RootFolder+"\Raw_Data";
files = dir(raw_data_path)

% initialize table and fill in Year and Age variables and first prefecture's data -
mortality_rates = cell2table(cell((max_age+1)*n_years,0)) 
first_file = 3 % we skip the first two files in the folder, '.' and '..'

file_path = string(files(first_file).folder)+"\"+files(first_file).name;
file_table = readtable(file_path);

length(file_table.Female);

year = file_table.Year(file_table.Age <= max_age)
age =  file_table.Age(file_table.Age <= max_age)

mortality_rates.Year =  file_table.Year(file_table.Age <= max_age)
mortality_rates.Age = file_table.Age(file_table.Age <= max_age)
mortality_rates.(files(first_file).name(1:(end-4))) = file_table.Female(file_table.Age <= max_age)

% fill in remaining 46 prefectures of data -------------------------------
for j = (first_file+1):length(files)   

    file_path = string(files(j).folder)+"\"+files(j).name;
    file_table = readtable(file_path);
    
    length(file_table.Female);
    
    mortality_rates.(files(j).name(1:(end-4))) = file_table.Female(file_table.Age <= max_age);
    
end

%save('mortality_rates','mortality_rates')

mortality_rates_array = mortality_rates{1:96,3:end}

for j = 2:45
   mortality_rates_array(:,:,j) =   mortality_rates{((j-1)*96+1):j*96,3:end}
end

%save('mortality_rates_array','mortality_rates_array')
