check_answers <- function(data_in){
  
  
  return_table <- data.table('Check' = c('Group A','Group B','Group C','Group D','Group E','Group F'), 'Done' = 'No')
  
  # data_in <- fread('C:/Users/danie/Downloads/fdfdfdf.csv')
  
  no_of_results_per_group <- data_in[Group %in% c('A','B','C','D','E','F'),.(.N), by = 'Group']
  no_of_results_per_group <- no_of_results_per_group[order(Group)]
  no_of_results_per_group$code <- paste('Group',no_of_results_per_group$Group)
  completed_groups <- no_of_results_per_group[N==6]$code
  return_table[return_table$Check %in% completed_groups]$Done <- 'Yes'
  
  
  return_table_knockout <- data.table('Check' = c('8th final','Quarter final','Semi final','Final','Topscorer','Yellow cards', 'Competitor', 'Email'), 'Done' = 'No')
  
  no_of_results_per_stage <- data_in[Round_Number %in% c(4,5,6, 'Final match'),.(.N), by = 'Round_Number']

  if('4' %in% no_of_results_per_stage$Round_Number){
    if(no_of_results_per_stage[Round_Number == 4,N] == 8){
      return_table_knockout[Check == '8th final']$Done <- 'Yes'
    }  
  }
  
  if('5' %in% no_of_results_per_stage$Round_Number){
    if(no_of_results_per_stage[Round_Number == 5,N] == 4){
      return_table_knockout[Check == 'Quarter final']$Done <- 'Yes'
    }
  }
  if('6' %in% no_of_results_per_stage$Round_Number){
    if(no_of_results_per_stage[Round_Number == 6,N] == 2){
      return_table_knockout[Check == 'Semi final']$Done <- 'Yes'
    }
  }
  if('Final match' %in% no_of_results_per_stage$Round_Number){
    if(no_of_results_per_stage[Round_Number == 'Final match',N] == 1){
      return_table_knockout[Check == 'Final']$Done <- 'Yes'
    }
  }
  
  if(data_in[Location == 'TopScorer']$Home_Team != ''){
    return_table_knockout[Check == 'Topscorer']$Done <- 'Yes'  
  }
  if(data_in[Location == 'Yellow Cards']$Home_Team != 0){
    return_table_knockout[Check == 'Yellow cards']$Done <- 'Yes'  
  }
  if(data_in[Location == 'Competitor']$Home_Team != ''){
    return_table_knockout[Check == 'Competitor']$Done <- 'Yes'  
  }
  if(grepl('@',data_in[Location == 'Email']$Home_Team)){
    return_table_knockout[Check == 'Email']$Done <- 'Yes'  
  }  

  return_table <- rbind(return_table, return_table_knockout)
  return(return_table)
}