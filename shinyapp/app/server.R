pal <- colorFactor(c("blue", "red"), domain = c("True", "False"))


server <- function(input, output, session) {
  
  selected_cluster <- reactiveVal()
  
  output$map <- renderLeaflet({
    leaflet(data = data_cluster) %>%
      addProviderTiles("Esri.WorldStreetMap") %>%
      addCircleMarkers(~center_lon, ~center_lat,
                 popup = ~paste("Pojedyncze śmieci", singular, "<br/>Wiele śmieci",plural),
                 color = ~pal(is_dump),
                 clusterOptions = markerClusterOptions()) %>%
      setView(lng = 20, lat = 50, zoom = 3.5) %>%
      addLegend(pal = pal, values = ~is_dump,
                title = "Wysypiska", opacity = 0.7)
  })
  
  observe({
    click <- input$map_marker_click
    req(click)
    sel_row <- find_row_in_data(data_cluster, click$lng, click$lat)
    selected_cluster(sel_row)
    output$put_button <- renderUI({
      actionButton("put", "Pokaż śmieci z klastra", icon = icon("map-pin"), width = "200px")
    })
  })
  
  selected_data <- reactive({
    req(selected_cluster())
    data %>% filter(cluster_uuid == selected_cluster()$cluster_uuid)
  })
  
  output$tab_trash <- DT::renderDataTable({
    req(selected_data())
    selected_data() %>% select(Pojedyncze = singular, Wiele = plural, Kategorie = result_string)
  }, server = FALSE, selection = 'single')
  
  output$barplot <- renderPlotly({
    req(selected_cluster())
    df <- combined_string_to_df(selected_cluster()$combined_string[[1]])
    plot_ly(x = df$rodzaj, y = df$ilosc, color = df$rodzaj) %>% layout(showlegend = FALSE)
  })
  
  observeEvent(input$tab_trash_rows_selected, {
    sel_row <- input$tab_trash_rows_selected
    req(sel_row)
    output$thrashimage <- renderUI({
      req(length(selected_data()$filename) >= sel_row)
      imgurl <- selected_data()$filename[[sel_row]]
      tags$img(src = imgurl, width = "200px")
    })
  })
  
  observeEvent(input$put, {
    leafletProxy(mapId = "map") %>%
      addMarkers(data = selected_data(), lat = ~lat, lng = ~lon,
                 options = markerOptions(clickable = FALSE))
  })
  
  output$tab_fame <- renderReactable({
    reactable(mock_data_people, columns = list(
      Foto = colDef(cell = function(value, index) {
        tags$img(src = value, height = "50px")
      })
    )
    )
  })

  output$tab_shame <- renderReactable({
    reactable(
      mock_data_companies
    )
  })

  observeEvent(selected_cluster(), {
    output$form <- renderUI({
      tagList(
        h2("Chcę pomóc!"),
        textInput("name", "Imię", width = "80%"),
        textInput("name2", "Nazwisko", width = "80%"),
        textInput("email", "E-mail", width = "80%"),
        textInput("cluster", "Wysypisko", value = selected_cluster()$cluster_uuid, width = "80%"),
        actionButton("submit", "Zgłoś chęć posprzątania", icon = icon("people-carry"))
      )
    })
  })
  
  observeEvent(input$submit, {
    showModal(modalDialog(
      title = "Zgłoszenie przyjęte",
      "Dziękujemy! Teraz wystarczy posprzątać zgłoszony teren i wysłać zdjęcie z potwierdzeniem.",
      footer = NULL,
      easyClose = TRUE,
      )
    )
  })

  observeEvent(input$submit2, {
    showModal(modalDialog(
      title = "Zgłoszenie wysłane do weryfikacji",
      "Jesteś SUPER! Administrator sprawdzi poprawność danych i przyzna Ci punkty rankingowe!",
      footer = NULL,
      easyClose = TRUE,
    )
    )
  })
}
