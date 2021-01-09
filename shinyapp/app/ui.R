fluidPage(
  title = "Dumpings detector",
  h1("My map"),
  column(width = 8,
   leafletOutput("map", height = 600)
  ),
  column(width = 4,
    p("Press the point on the map to get more info"),
    verbatimTextOutput("info"),
    uiOutput("image"),
    dataTableOutput("tab_trash")
  )
)
