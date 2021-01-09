fluidPage(title = "Anti-Śmieć",
navbarPage(
  title = div(
      img(
        src = "https://venturebeat.com/wp-content/uploads/2018/09/natural-language-processing-e1572968977211.jpg",
        height = 50,
        width = 100,
        style = "margin:10px 10px"
      )
    ),
  tabPanel("Mapa śmieci",
    column(width = 8,
     leafletOutput("map", height = 600)
    ),
    column(width = 4,
      p("Press the point on the map to get more info"),
      verbatimTextOutput("info"),
      uiOutput("thrashimage"),
      dataTableOutput("tab_trash")
    )
  ),
  tabPanel("Ściana chwały",
   dataTableOutput("tab_shame")
  ),
  tabPanel("Ściana płaczu",
   dataTableOutput("tab_fame")
  ),
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "css/style.css"),
    tags$title("Anti-Śmieć")
  )
)
)
