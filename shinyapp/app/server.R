tab_js <- "
function(table) {
  table.on('click.dt', 'tr', function() {
    table.$('tr.selected').removeClass('selected');
    $(this).toggleClass('selected');            
    Shiny.onInputChange('rows',
                        table.rows('.selected').data()[0][0]);
  });
}
"

server <- function(input, output, session) {
  output$map <- renderLeaflet({
    leaflet(data = data) %>%
      addProviderTiles("Esri.WorldStreetMap") %>%
      addMarkers(~lon, ~lat, popup = ~paste("<h3>", result_string,
                                            "</h3><img src ='", filename, "' width='50' height='100'/>"),
                 clusterOptions = markerClusterOptions()) %>%
      setView(lng = 20, lat = 50, zoom = 3.5)
  })
  
  observe({
    click <- input$map_marker_click
    req(click)
    output$info <- renderText({
      unlist(click)
    })
    
    leafletProxy(mapId = "map") %>%
      addCircleMarkers(lat = click$lat + 0.1, lng = click$lat - 0.1)
  })
  
  output$tab_trash <- DT::renderDataTable({
    head(data)
  }, server = FALSE, selection = 'single')
  
  observeEvent(input$tab_trash_rows_selected, {
    sel_row <- input$tab_trash_rows_selected
    req(sel_row)
    print(sel_row)
    output$image <- renderUI({
      imgurl <- head(data)$filename[[sel_row]]
      print("img")
      tags$img(src = imgurl, width = "200px")
    })
    
  })
  
}
