fill4Final <- function(schedule, results){
  
  noOfGames <- nrow(results)
  for(i in 1:noOfGames){
    gameID <- results$Game_No[i]
    scheduleID <- paste("W",gameID,sep="")
    if(results$Home[i] >= results$Away[i]){
      thisTeam <- results$Home_Team[i]
    }else{
      thisTeam <- results$Away_Team[i]
    }
    
    ind <- which(schedule$Home_Team == scheduleID)
    if(length(ind)==0){
      ind <- which(schedule$Away_Team == scheduleID)
      schedule$Away_Team[ind] <- thisTeam
      
    }else{
      schedule$Home_Team[ind] <- thisTeam
    }
      
    
  }
  return(schedule)
  
}