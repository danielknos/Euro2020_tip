getGroupPositions <- function(group, tab_A){
  
  group_pos <-  as.integer(c(1,2,3))
  g_pos <- data.frame(group_pos)
  g_pos$group_pos <- paste(group, g_pos$group_pos, sep="")
  g_pos$country <- NULL
  ga <- calcTable2(tab_A)
  
  g_pos[1,2] <- ga[1,"country"]
  g_pos[2,2] <- ga[2,"country"]
  g_pos[3,2] <- ga[3,"country"]
  
  return(g_pos)
  
}