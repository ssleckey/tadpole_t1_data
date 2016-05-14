rm(list=ls(all=TRUE))

setwd("S:/Users/Sarah/Data/Tadpole/T1/Touchscreen Raw Data/retrieval/")

pc <- "S:/Users/Sarah/Data/Tadpole/T1/Touchscreen Raw Data/retrieval/"

subj=1

for (subj in 1:118) {
  if(subj==2) {next} #this is if need to skip some data
  if(subj==5) {next}
  if(subj==6) {next}
  if(subj==8) {next}
  if(subj==10) {next}
  if(subj==11) {next}
  if(subj==25) {next}
  if(subj==27) {next}
  if(subj==29) {next}
  if(subj==30) {next}
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
  if(subj==96) {next}
  if(subj==99) {next}
  if(subj==100) {next}
  if(subj==104) {next}
  if(subj==105) {next}
  if(subj==107) {next}
  if(subj==108) {next}
  if(subj==109) {next}
  if(subj==115) {next}
  if(subj==117) {next}
  
  #Read in data table
  memoryT1 <- read.csv(paste(pc,subj,"_log.csv",sep=""), header=T) 
  head(memoryT1)
  
  accuracycol <-2
  RTcol <-3
  choicecol <-4
  
  
  #creates matrix of 1 row and 41 columns for output data.
  memory <- as.data.frame(matrix(c(999:999),ncol=61,nrow=1,byrow=T))
  names(memory)=c("Subject_ID","acc1","RT1","response1","acc2","RT2","response2","acc3","RT3","response3","acc4","RT4","response4","acc5","RT5","response5","acc6","RT6","response6",
                  "acc7","RT7","response7","acc8","RT8","response8","acc9","RT9","response9","acc10","RT10","response10","acc11","RT11","response11","acc12","response12","RT12","acc13","RT13","response13",
                  "acc14","RT14","response14","acc15","RT15","response15","acc16","RT16","response16","acc17","RT17","response17","acc18","RT18","response18","acc19","RT19","response19","acc20","RT20","response20")
  
  memory[1,1] <- memoryT1[1,4] #Sets the first column to ID number
  
  trialcounter <- 1
  
  #for each row, if beginning of trial...
  for (i in 1:nrow(memoryT1)) {
    
    if(memoryT1[i,12] != "press spacebar to start retrieval task" & 
       memoryT1[i,12] != "blacksquare.bmp" &
       memoryT1[i,12] != "whiteborder.bmp" &
       memoryT1[i,12] != "MutedBallie.avi (174x144)" &
       memoryT1[i,12] != "press spacebar to start perceptual task"
    ) {
      
      if(memoryT1[i,11] != "SPACE"){
        if(memoryT1[i, 14]=="True" | memoryT1[i, 14]==TRUE){
          correct <- 1
        } 
        if(memoryT1[i, 14]=="False" | memoryT1[i, 14]==FALSE){
          correct <- 0
        }
        
        #correct <- memoryT1[i,14]
      }else { 
        correct <- 999
      }
      
      RT <- memoryT1[i,13]
      choice <- memoryT1[i,10]
      
      memory[1,accuracycol] <- correct
      memory[1,RTcol] <- RT
      memory[1,choicecol] <- choice
      
      accuracycol <- accuracycol + 3
      RTcol <- RTcol + 3
      choicecol <- choicecol + 3
      
      trialcounter <- trialcounter + 1
    }
    
    
    
    
    
    #Will write data table to csv format
    write.table(memory,paste(pc,'processed data/',"sub",subj,".txt",sep=""))
  }#end for loop for each participant
  }

#Merging subject files
#Let's say all the files that you reformat and write above are in folder "processed data"
#Then you can have R read in each file at a time and add it to another spreadsheet

dir <- paste(pc,'processed data/',sep="")
files <- list.files(dir) #lists all the names of the files within the directory

AllSubs <- read.table(paste(dir,files[1],sep=""),header=T) #Set new data table to first file in directory
names(AllSubs)=c("Subject_ID","acc1","RT1","response1","acc2","RT2","response2","acc3","RT3","response3","acc4","RT4","response4","acc5","RT5","response5","acc6","RT6","response6",
                 "acc7","RT7","response7","acc8","RT8","response8","acc9","RT9","response9","acc10","RT10","response10","acc11","RT11","response11","acc12","response12","RT12","acc13","RT13","response13",
                 "acc14","RT14","response14","acc15","RT15","response15","acc16","RT16","response16","acc17","RT17","response17","acc18","RT18","response18","acc19","RT19","response19","acc20","RT20","response20")

#Loop through all other files and add them to new data table
for(i in 2:length(files)){
  temp <- read.table(paste(dir,files[i],sep=""),header=T)
  AllSubs <- rbind(AllSubs,temp)
}

AllSubjects <- as.data.frame(matrix(c(999:999),ncol = 61, nrow = 100, byrow=TRUE))
names(AllSubjects)=c("ID","accuracy1","accuracy2","accuracy3","accuracy4","accuracy5","accuracy6","accuracy7","accuracy8",
                 "accuracy9","accuracy10","accuracy11","accuracy12","accuracy13","accuracy14","accuracy15","accuracy16","accuracy17",
                 "accuracy18","accuracy19","accuracy20","response1","response2","response3","response4","response5","response6",
                 "response7","response8","response9","response10","response11","response12","response13","response14","response15",
                 "response16","response17","response18","response19","response20","RT1","RT2","RT3","RT4","RT5","RT6","RT7","RT8",
                 "RT9","RT10","RT11","RT12","RT13","RT14","RT15","RT16","RT17","RT18","RT19","RT20")

for (i in 1:nrow(AllSubs)) {
  AllSubjects[i,1] <- AllSubs[i,1]
  AllSubjects[i,2] <- AllSubs[i,2]
  AllSubjects[i,3] <- AllSubs[i,5]
  AllSubjects[i,4] <- AllSubs[i,8]
  AllSubjects[i,5] <- AllSubs[i,11]
  AllSubjects[i,6] <- AllSubs[i,14]
  AllSubjects[i,7] <- AllSubs[i,17]
  AllSubjects[i,8] <- AllSubs[i,20]
  AllSubjects[i,9] <- AllSubs[i,23]
  AllSubjects[i,10] <- AllSubs[i,26]
  AllSubjects[i,11] <- AllSubs[i,29]
  AllSubjects[i,12] <- AllSubs[i,32]
  AllSubjects[i,13] <- AllSubs[i,35]
  AllSubjects[i,14] <- AllSubs[i,38]
  AllSubjects[i,15] <- AllSubs[i,41]
  AllSubjects[i,16] <- AllSubs[i,44]
  AllSubjects[i,17] <- AllSubs[i,47]
  AllSubjects[i,18] <- AllSubs[i,50]
  AllSubjects[i,19] <- AllSubs[i,53]
  AllSubjects[i,20] <- AllSubs[i,56]
  AllSubjects[i,21] <- AllSubs[i,59]
  AllSubjects[i,22] <- AllSubs[i,4]
  AllSubjects[i,23] <- AllSubs[i,7]
  AllSubjects[i,24] <- AllSubs[i,10]
  AllSubjects[i,25] <- AllSubs[i,13]
  AllSubjects[i,26] <- AllSubs[i,16]
  AllSubjects[i,27] <- AllSubs[i,19]
  AllSubjects[i,28] <- AllSubs[i,22]
  AllSubjects[i,29] <- AllSubs[i,25]
  AllSubjects[i,30] <- AllSubs[i,28]
  AllSubjects[i,31] <- AllSubs[i,31]
  AllSubjects[i,32] <- AllSubs[i,34]
  AllSubjects[i,33] <- AllSubs[i,37]
  AllSubjects[i,34] <- AllSubs[i,40]
  AllSubjects[i,35] <- AllSubs[i,43]
  AllSubjects[i,36] <- AllSubs[i,46]
  AllSubjects[i,37] <- AllSubs[i,49]
  AllSubjects[i,38] <- AllSubs[i,52]
  AllSubjects[i,39] <- AllSubs[i,55]
  AllSubjects[i,40] <- AllSubs[i,58]
  AllSubjects[i,41] <- AllSubs[i,61]
  AllSubjects[i,42] <- AllSubs[i,3]
  AllSubjects[i,43] <- AllSubs[i,6]
  AllSubjects[i,44] <- AllSubs[i,9]
  AllSubjects[i,45] <- AllSubs[i,12]
  AllSubjects[i,46] <- AllSubs[i,15]
  AllSubjects[i,47] <- AllSubs[i,18]
  AllSubjects[i,48] <- AllSubs[i,21]
  AllSubjects[i,49] <- AllSubs[i,24]
  AllSubjects[i,50] <- AllSubs[i,27]
  AllSubjects[i,51] <- AllSubs[i,30]
  AllSubjects[i,52] <- AllSubs[i,33]
  AllSubjects[i,53] <- AllSubs[i,36]
  AllSubjects[i,54] <- AllSubs[i,39]
  AllSubjects[i,55] <- AllSubs[i,42]
  AllSubjects[i,56] <- AllSubs[i,45]
  AllSubjects[i,57] <- AllSubs[i,48]
  AllSubjects[i,58] <- AllSubs[i,51]
  AllSubjects[i,59] <- AllSubs[i,54]
  AllSubjects[i,60] <- AllSubs[i,57]
  AllSubjects[i,61] <- AllSubs[i,60]
  
}
#Write new data set to a txt file 
write.table(AllSubs,paste(pc,'processed data/AllSubs.txt',sep=""),row.names=FALSE)
write.table(AllSubjects,"S:/Users/Sarah/Data/Tadpole/T1/Touchscreen Raw Data/retrieval/processed data/AllSubjects.csv",sep=",", row.names=FALSE)




