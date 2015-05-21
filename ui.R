
library(shiny)
library(ggvis)

# Define the overall UI
shinyUI(
        fluidPage(theme = "bootstrap.css",
                navbarPage(
                title = 'FRorpus (demo version - real tokens, random metadata)',

                tabPanel('Concordances',
                
                tags$head(tags$style(".table .alignRight {color: black; text-align:right;}")),
                tags$head(tags$style(".table .alignCenter {color: blue; text-align:center;}")),
                tags$head(tags$style(".table .alignLeft {color: black; text-align:left;}")),
                
                # Create a new Row in the UI for selectInputs
                fluidRow(
                        column(3,
                               textInput("text3", label = h4("Over left border:"), value = "^.+$")),
                        column(3,
                                textInput("text1", label = h4("Search tokens:"), value = "^.+$")),
                        column(3,
                                textInput("text2", label = h4("Over right border:"), value = "^.+$")),
                        column(3,
                                textInput("text4", label = h4("Ignore:"), value = "$nothing")),
                        column(2, 
                               selectInput("Sex", 
                                           label = h4("Gender:"), 
                                           c("Both", "F", "M"))),
                        column(3,
                               selectInput("language", label = h4("Language:"), c("Saami", "Komi"))
                        ),
                        column(2, 
                               selectInput("Modus", 
                                        label = h4("Modus:"), 
                                        c("All", "spoken", "written"))
                        ),
                        column(2, 
                               selectInput("Genre", 
                                        label = h4("Genre:"), 
                                        c("All", "narrative", "tale", "teaching", "idiom", "literature", "interview", "title", "facta", "advertisement", "science", "flyer", "preface", "menu", "song"))
                               ),
                        column(2,
                               label = '',
                               textOutput('rows_out'),
                               dataTableOutput('tbl')
                               )
                ),
                # Create a new row for the table.

                fluidRow(
                        dataTableOutput(outputId="table")
                )),
 
tabPanel('Visualize',
          fluidRow(
                 mainPanel(
                         ggvisOutput("ggvis"),
                         ggvisOutput("ggvis2"),
                         ggvisOutput("ggvis3"),
                         ggvisOutput("ggvis4"),
                         ggvisOutput("ggvis5"),
                         ggvisOutput("ggvis7"),
                         ggvisOutput("ggvis8"),
                         ggvisOutput("ggvis9"),
                         ggvisOutput("ggvis10"),
#                         ggvisOutput("ggvis11"),
                         ggvisOutput("ggvis6")
                 ))),

tabPanel('Information & Help',
(fluidPage(
                h1("FRorpus application"),
                p(paste0("This corpus contains currently data from Kola Saami languages. It is intensively under development, but will offer easy access to this data.")),
                p("The regular expressions have to be used in the searches. They are Perl compatible, so different ")
))),

tabPanel('Contact',
         (fluidPage(
                        h1("Freiburg Research Group in Saami Studies")
                 )))


         )
)
)
