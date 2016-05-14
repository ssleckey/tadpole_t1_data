rm(list=ls(all=TRUE))

setwd("S:/Users/Emily/Longitudinal Study/T1/DATA/Touchscreen Raw Data/retrieval/")

pc <- "S:/Users/Emily/Longitudinal Study/T1/DATA/Touchscreen Raw Data/retrieval/"

subj=1

for (subj in 1:96) {
  if(subj==2) {next} #this is if need to skip some data
  if(subj==5) {next}
  if(subj==6) {next}
  if(subj==8) {next}
  if(subj==10) {next}
  if(subj==11) {next}
  if(subj==25) {next}
  if(subj==27) {next}
  if(subj==29) {next}
  if(subj==32) {next}
  if(subj==58) {next}
  if(subj==72) {next}
  if(subj==79) {next}
  if(subj==80) {next}
  if(subj==82) {next}
  if(subj==84) {next}
  if(subj==85) {next}
  if(subj==88) {next}
  if(subj==92) {next}
  if(subj==94) {next}

  
#Read in data table
memoryT1 <- read.csv(paste(pc,subj,"_log.csv",sep=""), header=T) 
head(memoryT1)

choicecol <-2
RTcol <-3

#creates matrix of 1 row and 41 columns for output data.
memory <- matrix(c(999:999),ncol=41,nrow=1,byrow=T)
memory[1,1] <- memoryT1[1,4] #Sets the first column to ID number

trialcounter <- 1

#for each row, if beginning of trial...
for (i in 1:nrow(memoryT1)) {
  
  if(memoryT1[i,12] != "press spacebar to start retrieval task" & 
     memoryT1[i,12] != "blacksquare.bmp" &
     memoryT1[i,12] != "whiteborder.bmp"
     ) {
    
    if(memoryT1[i,11] != "SPACE"){
      correct <- memoryT1[i,14]
      } else { 
        correct <- 999
    }
    
    RT <- memoryT1[i,13]
  
    memory[1,choicecol] <- correct
    memory[1,RTcol] <- RT
  
    choicecol <- choicecol + 2
    RTcol <- RTcol + 2
  
    trialcounter <- trialcounter + 1
  }
  
  
}



#merging files!


#Will write data table to csv format
write.table(memory,paste(pc,'processed data/',"sub",subj,".txt",sep=""))
}

#Merging subject files
#Let's say all the files that you reformat and write above are in folder "processed data"
#Then you can have R read in each file at a time and add it to another spreadsheet

dir <- paste(pc,'processed data/',sep="")
files <- list.files(dir) #lists all the names of the files within the directory

AllSubs <- read.table(paste(dir,files[1],sep=""),header=T) #Set new data table to first file in directory

#Loop through all other files and add them to new data table
for(i in 2:length(files)){
  temp <- read.table(paste(dir,files[i],sep=""),header=T)
  AllSubs <- rbind(AllSubs,temp)
}

#Write new data set to a txt file 
write.table(AllSubs,paste(pc,'processed data/AllSubs.txt',sep=""))





