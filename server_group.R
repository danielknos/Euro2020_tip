server <- function(session, input, output) {
  
  schedule <- fread("./Data/fixture_schedule.csv", sep=";")
  scoring <- fread("./Data/scoring.csv", sep=";")
  third_place_pairing <- fread('./Data/third_place_pairing.csv', sep = ';')
  
  startScore <- data.table(Home=as.integer(array(1,dim=nrow(schedule))), Away=as.integer(array(0,dim=nrow(schedule))))
  startScore <- data.table(Home=sample(0:3,nrow(schedule), replace = T), Away=sample(0:3,nrow(schedule), replace = T))
  schedule <- cbind(schedule, startScore)
  allTables <- NULL
  
  output$scoring <- renderTable(scoring)
  
  ################ Group A ######################
  group_A_Data <- schedule[which(schedule$Group == "A"),]
  output$group_A <- renderRHandsontable({rhandsontable(group_A_Data,rowHeaders = NULL, width = 1500, height = 200)%>%
      hot_col(c(1:7), readOnly = TRUE)
  })
  tab_A <- reactive({if(!is.null(input$group_A)){hot_to_r(input$group_A)}})
  observeEvent(tab_A(), {output$table_A <- renderTable(calcTable2(tab_A()), bordered = TRUE)})
  
  ################ Group B ######################
  group_B_Data <- schedule[which(schedule$Group == "B"),]
  output$group_B <- renderRHandsontable({rhandsontable(group_B_Data,rowHeaders = NULL, width = 1500, height = 200)%>%
      hot_col(c(1:7), readOnly = TRUE)
  })
  tab_B <- reactive({if(!is.null(input$group_B)){hot_to_r(input$group_B)}})
  observeEvent(tab_B(), {output$table_B <- renderTable(calcTable2(tab_B()), bordered = TRUE)})
  
  ################ Group C ######################
  group_C_Data <- schedule[which(schedule$Group == "C"),]
  output$group_C <- renderRHandsontable({rhandsontable(group_C_Data,rowHeaders = NULL, width = 1500, height = 200)%>%
      hot_col(c(1:7), readOnly = TRUE)
  })
  tab_C <- reactive({if(!is.null(input$group_C)){hot_to_r(input$group_C)}})
  observeEvent(tab_C(), {output$table_C <- renderTable(calcTable2(tab_C()), bordered = TRUE)})
  
  ################ Group D ######################
    group_D_Data <- schedule[which(schedule$Group == "D"),]
    output$group_D <- renderRHandsontable({rhandsontable(group_D_Data,rowHeaders = NULL, width = 1500, height = 200)%>%
      hot_col(c(1:7), readOnly = TRUE)
  })
  tab_D <- reactive({if(!is.null(input$group_D)){hot_to_r(input$group_D)}})
  observeEvent(tab_D(), {output$table_D <- renderTable(calcTable2(tab_D()), bordered = TRUE)})
  
  ################ Group E ######################
  group_E_Data <- schedule[which(schedule$Group == "E"),]
  output$group_E <- renderRHandsontable({rhandsontable(group_E_Data,rowHeaders = NULL, width = 1500, height = 200)%>%
      hot_col(c(1:7), readOnly = TRUE)
  })
  tab_E <- reactive({if(!is.null(input$group_E)){hot_to_r(input$group_E)}})
  observeEvent(tab_E(), {output$table_E <- renderTable(calcTable2(tab_E()), bordered = TRUE)})
  
  ################ Group F ######################
  group_F_Data <- schedule[which(schedule$Group == "F"),]
  output$group_F <- renderRHandsontable({rhandsontable(group_F_Data,rowHeaders = NULL, width = 1500, height = 200)%>%
      hot_col(c(1:7), readOnly = TRUE)
  })
  tab_F <- reactive({if(!is.null(input$group_F)){hot_to_r(input$group_F)}})
  observeEvent(tab_F(), {output$table_F <- renderTable(calcTable2(tab_F()), bordered = TRUE)})
  
  eight_final_update <<-  0
  quarter_final_update <<-  0
  semi_final_update <<-  0
  final_update <<-  0
  
  observeEvent(input$tabs,{
    
    
    a_pos <- reactive({if(is.null(calcTable2(tab_A()))) { NULL} else {cbind('group' = 'A',calcTable2(tab_A()))}})
    b_pos <- reactive({if(is.null(calcTable2(tab_B()))) { NULL} else {cbind('group' = 'B',calcTable2(tab_B()))}})
    c_pos <- reactive({if(is.null(calcTable2(tab_C()))) { NULL} else {cbind('group' = 'C',calcTable2(tab_C()))}})
    d_pos <- reactive({if(is.null(calcTable2(tab_D()))) { NULL} else {cbind('group' = 'D',calcTable2(tab_D()))}})
    e_pos <- reactive({if(is.null(calcTable2(tab_E()))) { NULL} else {cbind('group' = 'E',calcTable2(tab_E()))}})
    f_pos <- reactive({if(is.null(calcTable2(tab_F()))) { NULL} else {cbind('group' = 'F',calcTable2(tab_F()))}})

    all_pos <- reactive(rbind(a_pos(),b_pos(),c_pos(),d_pos(), e_pos(),f_pos()))
    

  if(eight_final_update == 0){
    final_8_Data <- schedule[which(schedule$Round_Number ==4),]
    final_8_schedule <- reactive({fill8Final(final_8_Data, all_pos(), third_place_pairing)})
    
    output$eight_final <- renderRHandsontable({rhandsontable(final_8_schedule()[,c('Game_No', 'Group', 'Round_Number','Date','Location','Home_Team', 'Away_Team', 'Home','Away')], 
                                                             rowHeader = NULL, width = 2000, height = 800)%>%
        hot_col(c(1:7), readOnly = TRUE) %>%
        hot_cols(renderer = "
                 function (instance, td, row, col, prop, value, cellProperties) {
                 Handsontable.renderers.NumericRenderer.apply(this, arguments);
                 if (col >= 8) {
                 td.style.background = 'lightgrey';
                 }
                 }")
    })
    eight_final_update <<- 1
  }
  
    # Updating the quarter finals
    if(quarter_final_update == 0){
      final_8_schedule_done <- reactive({if(!is.null(input$eight_final)){hot_to_r(input$eight_final)}})
      final_4_Data <- schedule[which(schedule$Round_Number==5),]
      final_4_schedule <- reactive({fill4Final(final_4_Data, final_8_schedule_done())})
      output$quarter_final <- renderRHandsontable({rhandsontable(final_4_schedule()[,c('Game_No', 'Group','Round_Number','Date','Location','Home_Team', 'Away_Team', 'Home','Away')]
                                                                 , rowHeader = NULL, width = 1500, height = 800)%>%
          hot_col(c(1:7), readOnly = TRUE) %>%
          hot_cols(renderer = "
                   function (instance, td, row, col, prop, value, cellProperties) {
                   Handsontable.renderers.NumericRenderer.apply(this, arguments);
                   if (col >= 8) {
                   td.style.background = 'lightgrey';
                   }
                   }")
      })
      quarter_final_update <<- 1
    }
    # Updating the semi finals
    if(semi_final_update == 0){
      final_4_schedule_done <- reactive({if(!is.null(input$quarter_final)){hot_to_r(input$quarter_final)}})
      final_2_Data <- schedule[which(schedule$Round_Number==6),]
      final_2_schedule <- reactive({fill4Final(final_2_Data, final_4_schedule_done())})
      output$semi_final <- renderRHandsontable({rhandsontable(final_2_schedule()[,c('Game_No', 'Group','Round_Number','Date','Location','Home_Team', 'Away_Team', 'Home','Away')],
                                                              rowHeaders = NULL, width = 1500, height = 800)%>%
          hot_col(c(1:7), readOnly = TRUE) %>%
          hot_cols(renderer = "
                   function (instance, td, row, col, prop, value, cellProperties) {
                   Handsontable.renderers.NumericRenderer.apply(this, arguments);
                   if (col >= 8) {
                   td.style.background = 'lightgrey';
                   }
                   }")
      })
      semi_final_update <<- 1
    }
    #Updating the medal macthes
    if(final_update == 0){
      final_2_schedule_done <- reactive({if(!is.null(input$semi_final)){hot_to_r(input$semi_final)}})
      final_1_Data <- schedule[which(schedule$Round_Number==7),]
      final_1_schedule <- reactive({fill1Final(final_1_Data, final_2_schedule_done())})
      output$final <- renderRHandsontable({rhandsontable(final_1_schedule()[,c('Game_No','Group', 'Round_Number','Date','Location','Home_Team', 'Away_Team', 'Home','Away')],
                                                         rowHeaders = NULL, width = 1500, height = 800)%>%
          hot_col(c(1:7), readOnly = TRUE) %>%
          hot_cols(renderer = "
                   function (instance, td, row, col, prop, value, cellProperties) {
                   Handsontable.renderers.NumericRenderer.apply(this, arguments);
                   if (col >= 8) {
                   td.style.background = 'lightgrey';
                   }
                   }")
      })
      final_update <<- 1
    }
  })
  
  topScorerInfo <- reactive(data.table(Game_No = '',Round_Number="", Date = "", Location="TopScorer", Home_Team=input$topScorer, Away_Team="", Group="", Home="", Away=""))
  yellowCardInfo <- reactive(data.table(Game_No = '',Round_Number="", Date = "", Location="Yellow Cards", Home_Team=input$yellowCards, Away_Team="", Group="", Home="", Away=""))
  competitorInfo <- reactive(data.table(Game_No = '',Round_Number="", Date = "", Location="Competitor", Home_Team=input$name, Away_Team="", Group="", Home="", Away=""))
  competitorEmail <- reactive(data.table(Game_No = '',Round_Number="", Date = "", Location="Email", Home_Team=input$email, Away_Team="", Group="", Home="", Away=""))
  tab_A <- reactive({if(!is.null(input$group_A)){hot_to_r(input$group_A)}})
  tab_B <- reactive({if(!is.null(input$group_B)){hot_to_r(input$group_B)}})
  tab_C <- reactive({if(!is.null(input$group_C)){hot_to_r(input$group_C)}})
  tab_D <- reactive({if(!is.null(input$group_D)){hot_to_r(input$group_D)}})
  tab_E <- reactive({if(!is.null(input$group_E)){hot_to_r(input$group_E)}})
  tab_F <- reactive({if(!is.null(input$group_F)){hot_to_r(input$group_F)}})
  
  final_8_schedule <- reactive({if(!is.null(input$eight_final)){hot_to_r(input$eight_final)}})
  final_4_schedule <- reactive({if(!is.null(input$quarter_final)){hot_to_r(input$quarter_final)}})
  final_2_schedule <- reactive({if(!is.null(input$semi_final)){hot_to_r(input$semi_final)}})
  final_1_schedule <- reactive({if(!is.null(input$final)){hot_to_r(input$final)}})
  
  observe({
  
    allData_in <- rbind(tab_A(),tab_B(),tab_C(),tab_D(),tab_E(),tab_F(), final_8_schedule(), final_4_schedule(), final_2_schedule(), final_1_schedule(), topScorerInfo(), yellowCardInfo(),competitorInfo(),competitorEmail())
    output$all_results <- renderTable(allData_in)
    
  })
  
  allData <- reactive(rbind(tab_A(),tab_B(), tab_C(), tab_D(), tab_E(), tab_F(),
                            if(!is.null(input$eight_final)){hot_to_r(input$eight_final)},
                            if(!is.null(input$quarter_final)){hot_to_r(input$quarter_final)},
                            if(!is.null(input$semi_final)){hot_to_r(input$semi_final)},
                            if(!is.null(input$final)){hot_to_r(input$final)},
                            topScorerInfo(), yellowCardInfo(), competitorInfo(), competitorEmail()))
  
  answer_check <- reactive({check_answers(allData())})
  observe({
    output$answer_check <- renderTable(answer_check())
  })
  
  observeEvent(input$upload,{
    if(any(answer_check()$Done != 'Yes')){
      shinyalert("Nope", "Something's missing. Make sure you complete all the steps in the table on top", type = "error")
      return(NULL)
    }
    
    fileName <- paste0(input$name,'_',gsub(pattern = ':',replacement = '_',Sys.time()),'.csv')
    # Write the data to a temporary file locally
    filePath <- file.path(tempdir(), fileName)
    fwrite(allData(), filePath, row.names = FALSE)
    
    drop_upload(filePath, path = 'Euro2020_tip', mode = 'add', dtoken = readRDS('droptoken.rds'))
    shinyalert("Upload complete", "Click the 'save local copy' button to save a copy of your scores", type = "success")
    
  })

  output$export <- downloadHandler(

    filename = function() {
      paste(input$name, ".csv", sep = "")
    },
    content = function(fname){
      print(fname)
      fwrite(allData(), fname, row.names = FALSE)

    },
    contentType = "text/csv")
  
}

