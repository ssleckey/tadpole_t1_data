#Name of directory where all data tables are kept
pc <- "C:/Users/jprabhak/Desktop/R for Emily/"

#Read in data table
data_table <- read.csv(paste(pc,"036-Event-Data.csv",sep=""), header=T) 
head(data_table)

counter <- 0
trialcount <- 2
shifts <- 0
prev_trial <- "NA"

#How many trials? That should be set to ncol below
shifts_count <- matrix(c(999:999),ncol=50,nrow=1,byrow=T)

shifts_count[1,1] <- 1 #Subject Number

for (i in 1:nrow(data_table)) {
  
  #I'm forgetting what your start and end trials are named as
  #data_table[row, column] (change column number, x, accordingly)
  if(data_table[i,2] == "ImageStart") {
    
    counter <- i
    
    while(data_table[counter,2] != "ImageEnd"){
      
      #Ignores rows with "Content"
      if(data_table[counter,4] == "new" | data_table[counter,4] == "old") {
        
        cur_trial <- data_table[counter,4] #This should set cur_trial equal to "new" or "old"
        
        if (cur_trial == prev_trial){
          shifts <- shifts + 1
        }
        
        prev_trial <- cur_trial
        
      }
      

      counter <- counter + 1
      
    }
    
    shifts_count[1,trialcount] <- shifts
    trialcount <- trialcount + 1
    shifts <- 0
    
  }
  
  
}

#Will write data table to csv format
write.table(shifts_count,paste(pc,'Subject Data/Sub036.txt',sep=""))


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

