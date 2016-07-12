#Name of directory where all data tables are kept
pc <- "S:/Users/Emily/Longitudinal Study/DATA/Eye Tracker Raw Data/ET_fixations/Tadpole Fixations/explicit retrieval/"

#Read in data table
trans <- read.csv(paste(pc,"027-Event-Data.csv",sep=""), header=T) 
head(fos)

counter <- 0
trialcount <- 1
shifts <- 0
prev_trial <- "NA"

shifts_count <- matrix(c(999:999),ncol=20,nrow=1,byrow=T)
shifts_count[1,1] <- data_table[2,1] #Set the first column to ID number

for (i in 1:nrow(data_table)) {
  
   #data_table[row, column] (change column number, x, accordingly)
  if(data_table[i,x] == "ImageStart") {
    
    counter <- i
    
    while(data_table[counter,x] != "ImageEnd"){
      
      cur_trial <- data_table[counter,x] #This should set cur_trial equal to "new" or "old"
      
      if (cur_trial == prev_trial){
        shifts <- shifts + 1
      }
      
      prev_trial <- cur_trial
      counter <- counter + 1
    }
    
    shifts_count[1,trialcount] <- shifts
    trialcount <- trialcount + 1
    
  }
  
 
  
}

