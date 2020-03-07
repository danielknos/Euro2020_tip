fill1Final <- function(schedule, results){
  rowGold <- which(schedule$Group==51)
  
  gameID <- results$Group[1]
  winnerID <- paste("W",gameID,sep="")
  loserID <- paste("L",gameID,sep="")
  
  
  if(results$Home[1] >= results$Away[1]){
    winner_home <- results$Home_Team[1]
    
  }else{
    winner_home <- results$Away_Team[1]
    
  }

  if(results$Home[2] >= results$Away[2]){
    winner_away <- results$Home_Team[2]
    
  }else{
    winner_away <- results$Away_Team[2]
    
  }

  
  schedule$Home_Team <- winner_home
  schedule$Away_Team <- winner_away
  
  
  schedule$Round_Number[rowGold] <- "Final match"
  return(schedule) 
  
}