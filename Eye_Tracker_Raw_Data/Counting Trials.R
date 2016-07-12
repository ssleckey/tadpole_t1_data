#Name of directory where all data tables are kept
setwd("S:/Users/Emily/Longitudinal Study/DATA/Eye Tracker Raw Data/ET_fixations/Tadpole Fixations/explicit retrieval")

pc <- "S:/Users/Emily/Longitudinal Study/DATA/Eye Tracker Raw Data/ET_fixations/Tadpole Fixations/explicit retrieval/"

#Read in data table
trans <- read.csv(paste(pc,"027-Event-Data.csv",sep=""), header=T) 
head(trans)

counter <- 0
trialcount <- 1
shifts <- 0
prev_trial <- "NA"

shifts_count <- matrix(c(999:999),ncol=50,nrow=1,byrow=T)
shifts_count[1,1] <- trans[2,1] #Set the first column to ID number

for (i in 1:nrow(trans)) {
  
  if(trans[i,2] == "ImageStart" & trans[i,3] != "blacksquare.bmp" & trans[i,3] != "arrow_crown.BMP" & 
     trans[i,3] != "heart_moon.BMP" & trans[i,3] != "Slide1.JPG" & trans[i,3] != "Slide2.JPG") {
    
    counter <- i
    
    while(trans[counter,2] != "ImageEnd"){
      
      cur_trial <- trans[counter,4] #This should set cur_trial equal to "new" or "old" or "Content"
      
      if (cur_trial != prev_trial & prev_trial != "NA" & cur_trial != "Content"){
        shifts <- shifts + 1
      }
      
      prev_trial <- cur_trial
      
      counter <- counter + 1
    }
    
    
    shifts_count[1,trialcount] <- shifts
    trialcount <- trialcount + 1
  }
    
    
    shifts <- 0   
    
}
  
 



#Merging subject files
#Let's say all the files that you reformat and write above are in folder "Subject Data"
#Then you can have R read in each file at a time and add it to another spreadsheet

dir <- paste(pc,'Subject Data/',sep="")
files <- list.files(dir) #lists all the names of the files within the directory

AllSubs <- read.table(paste(dir,files[1],sep=""),header=T) #Set new data table to first file in directory

#Loop through all other files and add them to new data table
for(i in 2:length(files)){
  temp <- read.table(paste(dir,files[i],sep=""),header=T)
  AllSubs <- rbind(AllSubs,temp)
}

#Write new data set to a txt file 
write.table(AllSubs,paste(pc,'Subject Data/AllSubs.txt',sep=""))

