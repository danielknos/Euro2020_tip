fill8Final <- function(schedule, positions, third_place_pairing){
  

  thirds_table <- positions[position == 3][order(-points, -goal_diff, -goals_for, -won)]
  groups_keep <-thirds_table[1:4, 'group']
  groups_keep <- paste(sort(groups_keep$group), collapse = '')

  third_place_option <- third_place_pairing[group_pairs == groups_keep]
  
  
  schedule[Away_Team == 'WB']$Away_Team <- paste0(third_place_option$WB,'3')
  schedule[Away_Team == 'WC']$Away_Team <- paste0(third_place_option$WC,'3')
  schedule[Away_Team == 'WF']$Away_Team <- paste0(third_place_option$WE,'3')
  schedule[Away_Team == 'WE']$Away_Team <- paste0(third_place_option$WF,'3')

  positions$group_pos <- paste0(positions$group, positions$position)
  for(i in 1:nrow(schedule)){
    schedule$Home_Team[i] <- ifelse(nrow(positions[group_pos == schedule$Home_Team[i],'country']) == 0,'',positions[group_pos == schedule$Home_Team[i],'country']) #positions[group_pos == schedule$Home_Team[i],'country']
    schedule$Away_Team[i] <- ifelse(nrow(positions[group_pos == schedule$Away_Team[i],'country']) == 0,'',positions[group_pos == schedule$Away_Team[i],'country']) #positions[group_pos == schedule$Away_Team[i],'country']
  }
  

  return(schedule)
}