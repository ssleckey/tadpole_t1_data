rm(list=ls(all=TRUE))

setwd("S:/Users/Sarah/Data/Tadpole/T1/tadpole_t1_data/Touchscreen Raw Data/perceptual/")

pc <- "S:/Users/Sarah/Data/Tadpole/T1/tadpole_t1_data/Touchscreen Raw Data/perceptual/"

subj=15

for (subj in 15:171) {
  if(subj==25) {next} #this is if need to skip some data
  if(subj==27) {next}
  if(subj==29) {next}
  if(subj==30) {next}
  if(subj==32) {next}
  if(subj==42) {next}
  if(subj==55) {next}
  if(subj==61) {next}
  if(subj==72) {next}
  if(subj==82) {next}
  if(subj==85) {next}
  if(subj==92) {next}
  if(subj==94) {next}
  if(subj==96) {next}
  if(subj==99) {next}
  if(subj==100) {next}
  if(subj==104) {next}
  if(subj==105) {next}
  if(subj==115) {next}
  if(subj==119) {next}
  if(subj==120) {next}
  if(subj==122) {next}
  if(subj==125) {next}
  if(subj==126) {next}
  if(subj==128) {next}
  if(subj==132) {next}
  if(subj==140) {next}
  if(subj==148) {next}
  if(subj==152) {next}
  if(subj==154) {next}
  if(subj==155) {next}
  if(subj==156) {next}
  if(subj==163) {next}
  if(subj==164) {next}
  if(subj==168) {next}
  
  
  #Read in data table
perceptualT1 <- read.csv(paste(pc,subj,"_log.csv",sep=""), header=T) 
head(perceptualT1)

choicecol <-2
RTcol <-3

#creates matrix of 1 row and 41 columns for output data.
perceptual <- as.data.frame(matrix(c(999:999),ncol=41,nrow=1,byrow=T))
names(perceptual)=c("Subject_ID","acc1","RT1","acc2","RT2","acc3","RT3","acc4","RT4","acc5","RT5","acc6","RT6",
                 "acc7","RT7","acc8","RT8","acc9","RT9","acc10","RT10","acc11","RT11","acc12","RT12","acc13","RT13",
                 "acc14","RT14","acc15","RT15","acc16","RT16","acc17","RT17","acc18","RT18","acc19","RT19","acc20","RT20")

perceptual[1,1] <- perceptualT1[1,4] #Sets the first column to ID number
           
trialcounter <- 1

#for each row, if beginning of trial...
for (i in 1:nrow(perceptualT1)) {
  
  if(perceptualT1[i,12] != "press spacebar to start perceptual task" & 
     perceptualT1[i,12] != "blacksquare.bmp" &
     perceptualT1[i,12] != "whiteborder.bmp" &
     perceptualT1[i,12] != "MutedBallie.avi (174x144)" 
  ) {
    
    if(perceptualT1[i,11] != "SPACE"){
      if(perceptualT1[i, 14] == "True" | perceptualT1[i, 14] == TRUE){
        correct <- 1
      } else {
        correct <- 0
      }
      
      #correct <- perceptualT1[i,14]
    } else { 
      correct <- 999
    }
    
    RT <- perceptualT1[i,13]
    
    perceptual[1,choicecol] <- correct
    perceptual[1,RTcol] <- RT
    
    choicecol <- choicecol + 2
    RTcol <- RTcol + 2
    
    trialcounter <- trialcounter + 1
  }
  
  



#Will write data table to csv format
write.table(perceptual,paste(pc,'processed data/',"sub",subj,".txt",sep=""))
}#end for loop for each participant

}

#Merging subject files
#Let's say all the files that you reformat and write above are in folder "processed data"
#Then you can have R read in each file at a time and add it to another spreadsheet

dir <- paste(pc,'processed data/',sep="")
files <- list.files(dir) #lists all the names of the files within the directory

AllSubs <- read.table(paste(dir,files[1],sep=""),header=T) #Set new data table to first file in directory
names(AllSubs)=c("Subject_ID","acc1","RT1","acc2","RT2","acc3","RT3","acc4","RT4","acc5","RT5","acc6","RT6",
                 "acc7","RT7","acc8","RT8","acc9","RT9","acc10","RT10","acc11","RT11","acc12","RT12","acc13","RT13",
                 "acc14","RT14","acc15","RT15","acc16","RT16","acc17","RT17","acc18","RT18","acc19","RT19","acc20","RT20")


#Loop through all other files and add them to new data table
for(i in 2:length(files)){
  temp <- read.table(paste(dir,files[i],sep=""),header=T)
  AllSubs <- rbind(AllSubs,temp)
}

#Write new data set to a txt file 
write.table(AllSubs,paste(pc,'processed data/AllSubs.txt',sep=""),row.names=FALSE)





