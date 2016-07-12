#Need to install this package so that you can use the match function
install.packages("reshape") #Once installed, you only need the following before using match
library(reshape)

#Name of directory where all data tables are kept
pc <- "C:/Users/jprabhak/Dropbox/JPrabhakar/UC Davis/Research/HIPPO/Time/HIPPOtime Data/Data Tables/"

#Read in first data table, header=T indicates that the first row are headers
dem <- read.csv(paste(mac,"Basic Info/T1S1Ages.csv",sep=""),header=T)
head(dem) #This outputs just the first couple of rows of your file 

#Read in second data table
fos <- read.csv(paste(mac,"Future Orientation/FOS.csv",sep=""), header=T) 
head(fos)

#Merge files
# <- in R is basically the same as =. You're saying the variable on the left should take on the contents on the right
#Start by creating a new data table (merged_files). I start by having it be the same as one of the datasets I read in (fos)
#Then add columns of interest from your other data tables (Age, Age2)
#Merge Syntax: 

#merged_files will be the same as fos data table. Now we can add columns to merged_files without changing fos in any way
merged_files <- fos 

#Notice on the left side, I named my new variable "Age1"
#On the right, I want it to give me all values in column named "Age" but match it with the new data table for ID number
merged_files$Age1 <- dem$Age[match(merged_files$ID,fos$ID)] 

#Now, Age1 is a new column in merged_files
#I can do the same for another column in dem that I want in my merged_file
merged_files$Age2 <- dem$Age2[match(merged_files$ID,fos$ID)] 

head(merged_files)