fluidPage(title = "Kropla",
navbarPage(
  title = div(
      img(
        src = "images/logo.png",
        height = 70,
        width = 70,
        style = "margin:0px 20px"
      ),
      "KROPLA"
    ),
  tabPanel("Mapa śmieci",
    column(width = 8,
     leafletOutput("map", height = 600),
     br(),
     div(class = "form boxes", uiOutput("form")),
     br(),br()
    ),
    column(width = 4,
      div(class= "boxes right-col",
        p(tags$b("Kliknij na marker aby wyswietlic więcej informacji!")),
        uiOutput("put_button"),
        br(),
        dataTableOutput("tab_trash"),
        uiOutput("thrashimage"),
        plotlyOutput("barplot", height = "250px")
      )
    )
  ),
  tabPanel("Posprzątane",
           div(class = 'wall',
               p(paste0("Posprzątane? Świetnie! teraz wystarczy wypełnić formularz poniżej i załadować zdjecia ",
                        "posprzątanego terenu. Administrator serwisu zweryfikuje twoją pracę i potwierdzi ",
                        "twoje punkty rankingowe mailem.")),
               h2("Formularz"),
               textInput("name2", "Imię", width = "80%"),
               textInput("name22", "Nazwisko", width = "80%"),
               textInput("email2", "E-mail", width = "80%"),
               textInput("cluster2", "Numer identyfikacyjny wysypiska", width = "80%"),
               fileInput("file1", "Wybierz zdjęcie posprzątanego terenu", accept = ".png"),
               actionButton("submit2", "Wyślij do weryfikacji", icon = icon("reply"))
           )
  ),
  tabPanel("Ściana chwały",
   div(class = 'wall',
     reactableOutput("tab_fame")
   )
  ),
  tabPanel("Ściana płaczu",
   div(class = 'wall',
     reactableOutput("tab_shame")
   )
  ),
  tabPanel("Informacje",
   div(class = 'wall',
     h2("Informacje"),
     p("Ten dashboard został zbudowany przez Dominika Krzemińskiego i Jędrzeja Świeżewskiego"),
     p("w trakcie hackathonu ", tags$b("Hack4Environment"), ", 2020."),
     img(src = "images/hack4env_logo.png", width = "300px"),
     br(),
     img(src = "https://avatars0.githubusercontent.com/u/6096772?s=200&v=4", width = "200px")
   )
  ),
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "css/style.css"),
    tags$title("Anti-Śmieć")
  )
),
shiny.info::powered_by(div("Appsilon", img(src = "https://avatars0.githubusercontent.com/u/6096772?s=200&v=4", width = "30px")),
                       link = "https://appsilon.com",
                       position = "bottom right")
)
