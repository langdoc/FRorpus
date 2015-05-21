library(shiny)
library(ggvis)
library(dplyr)

source('helper_functions.R', local = TRUE)

shinyServer(function(input, output) {

###########################################################################
###### DATA TABLE #########################################################
###########################################################################
   

        # Filter data based on selections
        output$table <- renderDataTable({
                
                data <- filtering(input$language, input$text1, input$text2, input$text3, input$text4)
                if (input$Sex != "Both"){
                        data <- data[data$Sex == input$Sex,]
                }
                if (input$Modus != "All"){
                        data <- data[data$Modus == input$Modus,]
                }
                if (input$Genre != "All"){
                        data <- data[data$Genre == input$Genre,]
                }
                if (nrow(data) == nrow(corpus_saami)  || nrow(data) == nrow(corpus_kpv)){
                        regex_eng
                } else {
                        data %>% arrange(Token) %>% select(Before, Token, After)
                }
                
        }, options = list(
                                        aoColumnDefs = list(
                                                                 list(targets = c(0, 1, 2), searchable = FALSE),
                                                                 list(sClass="alignRight", aTargets=c(0)),
                                                                 list(sClass="alignCenter", aTargets=c(1)),
                                                                 list(sClass="alignLeft", aTargets=c(2)),
                                                                 list(sWidth=c("200px"), aTargets=c(0)),
                                                                 list(sWidth=c("100px"), aTargets=c(1)),
                                                                 list(sWidth=c("200px"), aTargets=c(2))
                                                                 ),
                                        searching = 0,  # global search box on/off
                                        lengthMenu = c(10, 50, 100),
                                        pageLength = 100)
#         ,
#                                         callback = "function(table) {
#                                                     table.on('click.dt', 'tr', function() {
#                                                     $(this).toggleClass('selected');
#                                                     Shiny.onInputChange('rows',
#                                                     table.rows('.selected').indexes().toArray());
#                                                     });
#                                                 }"
#         )
#         output$rows_out <- renderText({
#                 paste(c('Selected:', input$rows),
#                       collapse = ' ')}
#        )
        )

# ref_eaf <- reactive({
#         
#         data <- filtering(input$text1, input$text2, input$text3, input$text4)
#         if (input$Sex != "Both"){
#                 data <- data[data$Sex == input$Sex,]
#         }
#         if (input$Variant != "All"){
#                 data <- data[data$Variant == input$Variant,]
#         }
#         if (input$Modus != "All"){
#                 data <- data[data$Modus == input$Modus,]
#         }
#         if (input$Genre != "All"){
#                 data <- data[data$Genre == input$Genre,]
#         }
#         data %>% select(Session_name) %>% .$Session_name -> Session_name_id
#         data %>% select(Time_start_hms) %>% .$Time_start_hms -> Time_start
#         data %>% select(Time_end_hms) %>% .$Time_end_hms -> Time_end
#         paste0(Session_name_id[input$rows], ": ", Time_start[input$rows], " - ", Time_end[input$rows])
# })
# 
#         output$rows_out <- renderText({
#                 paste(c('Selected:', ref_eaf()),
#                       collapse = ' ')}
#         )
        
        



###########################################################################
## barplot ################################################################
###########################################################################

filtered <- reactive({corpus <- filtering(input$language, input$text1, input$text2, input$text3, input$text4)})

filtered %>% ggvis(~Modus) %>%
                        layer_bars() %>%
                        bind_shiny("ggvis5")

filtered %>% ggvis(~Variant) %>%
                        layer_bars() %>%
                        bind_shiny("ggvis6")

filtered %>% ggvis(~Sex) %>%
                        layer_bars() %>%
                        bind_shiny("ggvis7")

filtered %>% ggvis(~Genre) %>%
                        layer_bars() %>%
                        bind_shiny("ggvis8")

})
