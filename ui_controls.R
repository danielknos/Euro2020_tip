header <- dashboardHeader(title = ' Euro 2020')



sidebar <- dashboardSidebar(
  useShinyalert(),
  tags$img(src='https://www.initialvip.com/wp-content/uploads/2019/06/Euro-2020.png', height = 180, width = 180),
  sidebarMenu(
    id = 'tabs',
    menuItem('Instructions', tabName = 'instructions'),
    menuItem("Group stage", icon = icon("table"),
      menuSubItem('Group A', tabName = 'group_A'),
      menuSubItem('Group B', tabName = 'group_B'),
      menuSubItem('Group C', tabName = 'group_C'),
      menuSubItem('Group D', tabName = 'group_D'),
      menuSubItem('Group E', tabName = 'group_E'),
      menuSubItem('Group F', tabName = 'group_F')
    ),
    menuItem("Knock out stage", icon = icon("balance-scale"),
             menuSubItem('8th final', tabName = 'eight_final'),
             menuSubItem('Quarter final', tabName = 'quarter_final'),
             menuSubItem('Semi final', tabName = 'semi_final'),
             menuSubItem('Final', tabName = 'final')
             ),
    menuItem('Summary & export', icon = icon("download"),
            menuSubItem('Questions', tabName = 'questions'),
            menuSubItem('Export', tabName = 'export')
             )
  )
)

body <- dashboardBody(
  
  # tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "cursom.css")),
  tags$head(includeCSS("./www/custom.css")),
  
  # tags$link(tags$style(HTML('.skin-blue .main-header .navbar {background-color: #f4b943;}'))),  

  tabItems(
    tabItem(tabName = 'instructions',
            widgetUserBox(
              title = 'Instructions',
              color = 'navy',
              type = 2,
              collapsible = FALSE,
              boxToolSize = 'xs',
              tags$div(
                tags$ol(
                  tags$li("Fill in results in all the group matches. Initially all results are randomized between 0 and 3 so if you're lazy you can use those results."),
                  tags$li("Fill in the results in the knockout games. Here the result doesnt matter, its only about getting a winner in each match. If its a draw, the home team wins"),
                  tags$li("Fill in your name in the Name field in the summary tab"),
                  tags$li("Fill in your predicted top scorer in the topscorer field in the summary tab"),
                  tags$li("Fill in your guess for the number of yellow cards during all the 51 matches (last time the number was 205)"),
                  tags$li("Click the 'upload results' button which uploads your results to my dropbox. To be safe please also save a local copy in case it gets lost somehow"),
                  tags$li("The results needs to be uploaded on my dropbox no later than 11/6 at 20.00")
                )
              )
            ),
            widgetUserBox(
              title = 'Scoring',
              color = 'navy',
              type = 2,
              collapsible = FALSE,
              boxToolSize = 'xs',
              tags$div(
                tags$ul(
                  tags$li('Correct sign (1X2) - 2 points'),
                  tags$li('Group stage: correct goal diff (i.e. 2-0 when the game ends 3-1) - 3 points (total, combined with correct sign)'),
                  tags$li('Group stage: correct score - 5 points (total, combined with previous)'),
                  tags$li('8th final - 4 points per correct team'),
                  tags$li('Quarter final- 6 points per correct team'),
                  tags$li('Semi final - 8 points per correct team'),
                  tags$li('Final - 10 points per correct team'),
                  tags$li('Correct winner - 15 points'),
                  tags$li('Correct top scorer - 15 points'),
                  tags$li('If its a tie the person closest to the number of yellow cards wins')
                )
              ) 
            )
            ),
    tabItem(tabName = "group_stage",h2("Dashboard tab content")),
    tabItem(tabName = "group_A",
            widgetUserBox(
              title = 'Group A',
              color = 'navy',
              type = 2,
              collapsible = FALSE,
              boxToolSize = 'xs',
              box(width = 12, 
                img(src="https://image.flaticon.com/icons/svg/197/197518.svg", width=150),
                img(src="https://image.flaticon.com/icons/svg/197/197620.svg", width=150),
                img(src="https://image.flaticon.com/icons/svg/323/323325.svg", width=150),
                img(src="https://image.flaticon.com/icons/svg/323/323306.svg", width=150)
              ),
              box(width = 12, 
                h3('Results'),
                rHandsontableOutput("group_A"), 
                h3('Table'),
                tableOutput("table_A")  
              )
              
            )
            ),
    tabItem(tabName = "group_B",
            widgetUserBox(
              title = 'Group B',
              color = 'navy',
              type = 2,
              collapsible = FALSE,
              boxToolSize = 'xs',
              box(width = 12, 
                img(src="https://image.flaticon.com/icons/svg/323/323291.svg", width=150),
                img(src="https://image.flaticon.com/icons/svg/323/323300.svg", width=150),
                img(src="https://image.flaticon.com/icons/svg/323/323320.svg", width=150),
                img(src="https://image.flaticon.com/icons/svg/323/323359.svg", width=150)
              ),
              box(width = 12, 
                h3('Results'),
                rHandsontableOutput("group_B"), 
                h3('Table'),
                tableOutput("table_B")  
              )  
            )
            ),
    tabItem(tabName = "group_C",
            widgetUserBox(
              title = 'Group C',
              color = 'navy',
              type = 2,
              collapsible = FALSE,
              boxToolSize = 'xs',
              box(width = 12,
                img(src="https://image.flaticon.com/icons/svg/323/323275.svg", width=150),
                img(src="https://image.flaticon.com/icons/svg/323/323323.svg", width=150),
                img(src="https://image.flaticon.com/icons/svg/323/323321.svg", width=150),
                img(src="https://image.flaticon.com/icons/svg/323/323354.svg", width=150)
              ),
              box(width = 12,
                h3('Results'),
                rHandsontableOutput("group_C"), 
                h3('Table'),
                tableOutput("table_C")  
              ) 
            ) 
            ),
    tabItem(tabName = "group_D",
            widgetUserBox(
              title = 'Group D',
              color = 'navy',
              type = 2,
              collapsible = FALSE,
              boxToolSize = 'xs',
              box(width = 12,
                img(src="https://image.flaticon.com/icons/svg/323/323270.svg", width=150),
                img(src="https://image.flaticon.com/icons/svg/197/197503.svg", width=150),
                img(src="https://image.flaticon.com/icons/svg/323/323285.svg", width=150),
                img(src="https://image.flaticon.com/icons/svg/197/197601.svg", width=150)
              ),
              box(
                h3('Results'),
                rHandsontableOutput("group_D"), 
                h3('Table'),
                tableOutput("table_D")  
              )  
            )
            ),
    tabItem(tabName = "group_E",
            widgetUserBox(
              title = 'Group E',
              color = 'navy',
              type = 2,
              collapsible = FALSE,
              boxToolSize = 'xs',
              box(width = 12,
                img(src="https://image.flaticon.com/icons/svg/323/323365.svg", width=150),
                img(src="https://image.flaticon.com/icons/svg/323/323364.svg", width=150),
                img(src="https://image.flaticon.com/icons/svg/323/323338.svg", width=150),
                img(src="https://image.flaticon.com/icons/svg/197/197592.svg", width=150)
              ),
              box(width = 12,
                h3('Results'),
                rHandsontableOutput("group_E"), 
                h3('Table'),
                tableOutput("table_E")  
              )
            )
            
              
            ),
    tabItem(tabName = "group_F",
            widgetUserBox(
              title = 'Group F',
              color = 'navy',
              type = 2,
              collapsible = FALSE,
              boxToolSize = 'xs',
              box(width = 12,
                img(src="https://image.flaticon.com/icons/svg/323/323315.svg", width=150),
                img(src="https://image.flaticon.com/icons/svg/323/323332.svg", width=150),
                img(src="https://image.flaticon.com/icons/svg/1795/1795606.svg", width=150),
                img(src="https://image.flaticon.com/icons/svg/323/323287.svg", width=150)
              ),
              box(width = 12,
                h3('Results'),
                rHandsontableOutput("group_F"), 
                h3('Table'),
                tableOutput("table_F")  
              )
              
            )
            ),
      tabItem(tabName = "knockout",h2("Knockout stage")),
      tabItem(tabName = "eight_final",
            widgetUserBox(
              title = '8th final',
              color = 'navy',
              type = 2,
              collapsible = FALSE,
              boxToolSize = 'xs',
              width = 12,
              h3('Results'),
              rHandsontableOutput("eight_final")
            )),
      tabItem(tabName = "quarter_final",
            widgetUserBox(
              title = 'Quarter final',
              color = 'navy',
              type = 2,
              collapsible = FALSE,
              boxToolSize = 'xs',
              h3('Results'),
              rHandsontableOutput("quarter_final")
            )),
    tabItem(tabName = "semi_final",
            widgetUserBox(
              title = 'Semi final',
              color = 'navy',
              type = 2,
              collapsible = FALSE,
              boxToolSize = 'xs',
              h3('Results'),
              rHandsontableOutput("semi_final")
            )),
    tabItem(tabName = "final",
            widgetUserBox(
              title = 'Final',
              color = 'navy',
              type = 2,
              collapsible = FALSE,
              boxToolSize = 'xs',
              h3('Results'),
              rHandsontableOutput("final")
            )),
    tabItem(tabName = 'questions',
            widgetUserBox(
              title = 'Additional Questions',
              color = 'navy',
              type = 2,
              collapsible = FALSE,
              boxToolSize = 'xs',
              textInput("name", "Your Name", value = 'Write your name here'),
              textInput("email", "Email adress", value = 'Write your email here'),
              textInput("topScorer", "Top scorer", value = 'Write your predicted top scorer here'),
              numericInput("yellowCards", "No of yellow cards in all games", value = 0)
        )),
    tabItem(tabName = 'export',
            widgetUserBox(
              title = 'Checks',
              color = 'navy',
              type = 2,
              width = 2,
              collapsible = FALSE,
              boxToolSize = 'xs',
              tableOutput('answer_check')
              
            ),
            widgetUserBox(
              title = 'Export',
              color = 'navy',
              type = 2,
              width = 4,
              collapsible = FALSE,
              boxToolSize = 'xs',
              actionBttn(
                inputId = 'upload',
                label = 'Upload results',
                icon = icon('dropbox'),
                style = "fill",
                color = "default",
                size = "md",
                block = FALSE,
                no_outline = TRUE
              ),
              downloadBttn(
                outputId = 'export',
                label = 'Save a local copy',
                style = "fill",
                color = "warning",
                size = "md",
                block = FALSE,
                no_outline = TRUE
              )
            ),
            widgetUserBox(
              title = 'Summary',
              color = 'navy',
              type = 2,
              width = 6,
              collapsible = FALSE,
              boxToolSize = 'xs',
              tableOutput("all_results")
            )
          )
  )
)