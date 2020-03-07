
calcTable2 <- function(tabIn, group = NULL){
  # schedule <- read.csv("C:/Users/danie/Documents/VM-tips/fifa-world-cup-2018-RussianStandardTime.csv", sep=";", row.names = NULL, stringsAsFactors = FALSE)
  # group_A_Data <- schedule[which(schedule$Group == "A"),]
  # startScore <- data.frame(Home=array(1,dim=6), Away=array(2,dim=6))
  # tabIn <- cbind(group_A_Data, startScore)
  if(is.null(tabIn)){
    return(NULL)
  }
  noOfGames <- nrow(tabIn)
  
  teamA <- tabIn$Home_Team[1]
  teamB <- tabIn$Away_Team[1]
  teamC <- tabIn$Home_Team[2]
  teamD <- tabIn$Away_Team[2]
  
  
  teamPerm <- data.table("A"=teamA, "B"=teamB, "C"=teamC, "D"=teamD, stringsAsFactors = FALSE)
  teamPerm <- rbind(teamPerm,data.table('A' = teamA, 'B' = teamB, 'C' = teamC, 'D' = " "))
  teamPerm <- rbind(teamPerm,data.table('A' = teamA, 'B' = teamB, 'C' = teamD, 'D' = " "))
  teamPerm <- rbind(teamPerm,data.table('A' = teamA, 'B' = teamC, 'C' = teamD, 'D' = " "))
  teamPerm <- rbind(teamPerm,data.table('A' = teamB, 'B' = teamC, 'C' = teamD, 'D' = " "))
  teamPerm <- rbind(teamPerm,data.table('A' = teamA, 'B' = teamB, 'C' = '', 'D' = " "))
  teamPerm <- rbind(teamPerm,data.table('A' = teamA, 'B' = teamC, 'C' = '', 'D' = " "))
  teamPerm <- rbind(teamPerm,data.table('A' = teamA, 'B' = teamD, 'C' = '', 'D' = " "))
  teamPerm <- rbind(teamPerm,data.table('A' = teamB, 'B' = teamC, 'C' = '', 'D' = " "))
  teamPerm <- rbind(teamPerm,data.table('A' = teamB, 'B' = teamD, 'C' = '', 'D' = " "))
  teamPerm <- rbind(teamPerm,data.table('A' = teamC, 'B' = teamD, 'C' = '', 'D' = " "))
  
  
  tableOut <- data.table("country"=c(teamA, teamB, teamC, teamD))
  tableOut2 <- data.table("country"=c(teamA, teamB, teamC, teamD))
  tableOut$ABCD <- 0
  tableOut$ABC <- 0
  tableOut$ABD <- 0
  tableOut$ACD <- 0
  tableOut$BCD <- 0
  tableOut$AB <- 0
  tableOut$AC <- 0
  tableOut$AD <- 0
  tableOut$BC <- 0
  tableOut$BD <- 0
  tableOut$CD <- 0
  tableOut2$points <- 0
  tableOut2$goals_for <- 0
  tableOut2$goals_against <- 0
  tableOut2$goal_diff <- 0
  tableOut2$won <- 0
  tableOut2$draw <- 0
  tableOut2$lost <- 0
  
  for(i in 1:noOfGames){
    
    Home.Team <- tabIn$Home_Team[i]
    Away.Team <- tabIn$Away_Team[i]
    home_gf <- tabIn$Home[i]
    home_gdiff <- tabIn$Home[i] - tabIn$Away[i]
    home_points <- if(home_gdiff>0){3}else if(home_gdiff<0){0}else{1}
    home_score <- 10000*home_points + 100*home_gdiff + home_gf
    away_gf <- tabIn$Away[i]
    away_gdiff <- tabIn$Away[i] - tabIn$Home[i]
    away_points <- if(away_gdiff>0){3}else if(away_gdiff<0){0}else{1}
    away_score <- (10000*away_points + 100*away_gdiff + away_gf)
    countries <- c(Home.Team, Away.Team)
    permutationColInds <- which(rowSums(teamPerm==countries[1] | teamPerm ==countries[2], na.rm = TRUE) ==2)
    startcolInd <- which(colnames(tableOut)=="ABCD")
    
    Home.TeamInd <- which(tableOut$country == Home.Team)
    Away.TeamInd <- which(tableOut$country == Away.Team)
    
    if(home_gf>away_gf){
      tableOut2$won[Home.TeamInd] <- tableOut2$won[Home.TeamInd] + 1
      tableOut2$points[Home.TeamInd] <- tableOut2$points[Home.TeamInd] + 3
      tableOut2$lost[Away.TeamInd] <- tableOut2$lost[Away.TeamInd] + 1
    }else if(away_gf>home_gf){
      tableOut2$won[Away.TeamInd] <- tableOut2$won[Away.TeamInd] + 1
      tableOut2$points[Away.TeamInd] <- tableOut2$points[Away.TeamInd] + 3
      tableOut2$lost[Home.TeamInd] <- tableOut2$lost[Home.TeamInd] + 1
    }else{
      tableOut2$draw[Home.TeamInd] <- tableOut2$draw[Home.TeamInd] + 1
      tableOut2$draw[Away.TeamInd] <- tableOut2$draw[Away.TeamInd] + 1
      tableOut2$points[Home.TeamInd] <- tableOut2$points[Home.TeamInd] + 1
      tableOut2$points[Away.TeamInd] <- tableOut2$points[Away.TeamInd] + 1
    }
    tableOut2$goals_for[Home.TeamInd] <- tableOut2$goals_for[Home.TeamInd] + home_gf
    tableOut2$goals_for[Away.TeamInd] <- tableOut2$goals_for[Away.TeamInd] + away_gf
    tableOut2$goals_against[Away.TeamInd] <- tableOut2$goals_against[Away.TeamInd] + home_gf
    tableOut2$goals_against[Home.TeamInd] <- tableOut2$goals_against[Home.TeamInd] + away_gf
    
    
    update_cols <- c(startcolInd-1+permutationColInds)
    for(i in update_cols){
      new_home <-as.numeric(tableOut[Home.TeamInd, ..i] + home_score)
      new_away <- as.numeric(tableOut[Away.TeamInd, ..i] + away_score)
      tableOut[Home.TeamInd, i] <- new_home
      tableOut[Away.TeamInd, i] <- new_away
  
    }
    
    
  }
 row.names(tableOut) <-NULL
 uniqueScores <- unique(tableOut$ABCD)
 tableOut$rank <- tableOut$ABCD
 
 if(length(uniqueScores)<4 & length(uniqueScores)>1){
   for(i in 1:length(uniqueScores)){
     thisScore <- uniqueScores[i]
     thisScoreInd <- rowSums(tableOut==thisScore)
     if(sum(thisScoreInd)>1){
       excludedCountries <- which(thisScoreInd == 0)
       if(length(excludedCountries)==1){
         colInd <- which(tableOut[excludedCountries[1],]==0)
       }else if(length(excludedCountries==2)){
         colInd <- which(tableOut[excludedCountries[1],]==0 & tableOut[excludedCountries[2],]==0)
       }
       tableOut$rank <- tableOut$rank + tableOut[,..colInd]
     }
   }
 }
 tableOut2$goal_diff <- tableOut2$goals_for - tableOut2$goals_against
 tableOut <- merge(tableOut, tableOut2)
 tableOut <- tableOut[order(-ABCD, -rank)]
 
 tableOut <- tableOut[,.(ABCD,rank,country,won,draw,lost,goals_for, goals_against,goal_diff,points)]
 
 tableOut$points <- sprintf("%s",tableOut$points)
  tableOut$goals_for <- sprintf("%s",tableOut$goals_for)
  tableOut$goals_against <- sprintf("%s",tableOut$goals_against)
  tableOut$goal_diff <- sprintf("%s",tableOut$goal_diff)
  tableOut$won <- sprintf("%s",tableOut$won)
  tableOut$draw <- sprintf("%s",tableOut$draw)
  tableOut$lost <- sprintf("%s",tableOut$lost)
  tableOut$position <- 1:nrow(tableOut)
  tableOut$ABCD <- NULL
  tableOut$rank <- NULL
  
  
  tableOut <- tableOut[,c("position","country","won","draw","lost","goals_for", "goals_against","goal_diff","points")]
  
  
 
  return(tableOut) 
}
 
 
 
  