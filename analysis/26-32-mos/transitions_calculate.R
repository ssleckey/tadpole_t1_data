rm(list=ls())
library(tidyverse)

read_in <- '~/Desktop/tadpole_t1_data/analysis/26-32-mos/transitions/'
setwd("~/Desktop/tadpole_t1_data/analysis/26-32-mos/")

transition_bytrial <- 999
parts <- dir("transitions/")
transitions <- data.frame()

for (p in parts) {
  transitions_id <- data.frame()
  subject <-read.table(paste(read_in,p,sep=""),header=TRUE, fill= TRUE)
  subject$todelete <- 999
  SID <- stringr::str_replace(p, "-Transitions-Data.tsv", "")

#removing early non-useful trials before images start appearing#
  imagecount <- 0

  for (i in 1:nrow(subject)){
    if (subject$Event[i] == 'ImageStart'){
      imagecount <- imagecount +1
    }
    if (imagecount < 2){
      subject$todelete[i]=1
    }
    else {subject$todelete[i]=0}
    }
  
removedspaces <- subject[which(subject$todelete==0),]

##Removing all other extraneous image or video info  
for (i in 1:nrow(removedspaces)){
  if (removedspaces$Descriptor[i] == 'blacksquare.bmp' | removedspaces$Descriptor[i] == 'MutedBallie.avi'
      | removedspaces$Descriptor[i] == 'Escape' | removedspaces$Descriptor[i] == 'fixation.png'
      | removedspaces$Descriptor [i] == 'Space' | removedspaces$Descriptor[i] == 'Left' 
      | removedspaces$Descriptor[i] == 'Right' | removedspaces$Event[i] == 'Content')

    removedspaces$todelete[i]=1
  
  else{
    removedspaces$todelete[i]=0
   }
  }

removedclean <- removedspaces[which(removedspaces$todelete==0),]

imagecount <- 1

for (i in 1:(nrow(removedclean)-1)){
  if (removedclean$Event[i] == 'ImageStart'){
    imagecount <- imagecount -1
  }
  if (removedclean$Event[i] == 'ImageEnd'){
    imagecount <- imagecount +1
  }
  if (imagecount == 1){
    removedclean$todelete[i+1]=1
  }
  else{removedclean$todelete[i]=0}
}

removedclean$todelete[nrow(removedclean)] <- 0
removedmid <- removedclean[which(removedclean$todelete==0),]

transitioncount <- 0
trialcount <- 0

for (i in 2:(nrow(removedmid)-1)){
  if (removedmid$Event[i] == 'correct' & removedmid$Event[i+1] == 'incorrect'){
    transitioncount <- transitioncount + 1
  }
  if (removedmid$Event[i] == 'incorrect' & removedmid$Event[i+1] == 'correct'){
    transitioncount <- transitioncount + 1
  }
  if (removedmid$Event[i] == 'ImageEnd'){
    trialcount <- trialcount + 1
    trial_transition <- trialcount
    temp_transition <- transitioncount
    transitioncount <- 0
    trans <- data.frame(trial = trialcount,
                        transitions = temp_transition,
                        SID = SID)
    transitions_id <- bind_rows(transitions_id, trans)
   }
}

#get first fixation of each trial
first_fixation <- removedmid %>%
  filter(lag(Event == "ImageStart"))%>%
  mutate(trial = c(1:20))%>%
  mutate(SID = SID)%>%
  mutate(first_fix = Event)%>%
  select(SID, trial, first_fix)

first_fixation$first_fix[first_fixation$first_fix != "correct" & first_fixation$first_fix !="incorrect"] <- NA 

#join first fixation data with transitions data
transitions_id <- left_join(first_fixation, transitions_id)

#bind subject data with group data
transitions <- bind_rows(transitions, transitions_id)
}

#save to R data file.
save(transitions, file = "et_trans.RData")

