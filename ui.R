library(shiny)
library(REmap)
library(readxl)

# source("ui-helpers.R")

fluidPage(
  title = "外访大屏 - 轨迹监测",
  tags$head(
    tags$link(href = "style.css", rel = "stylesheet")

    # Favicon
    #tags$link(rel = "shortcut icon", type="image/x-icon", href="http://daattali.com/shiny/img/favicon.ico")

  #   # Facebook OpenGraph tags
  #   tags$meta(property = "og:title", content = share$title),
  #   tags$meta(property = "og:type", content = "website"),
  #   tags$meta(property = "og:url", content = share$url),
  #   tags$meta(property = "og:image", content = share$image),
  #   tags$meta(property = "og:description", content = share$description),
  # 
  #   # Twitter summary cards
  #   tags$meta(name = "twitter:card", content = "summary"),
  #   tags$meta(name = "twitter:site", content = paste0("@", share$twitter_user)),
  #   tags$meta(name = "twitter:creator", content = paste0("@", share$twitter_user)),
  #   tags$meta(name = "twitter:title", content = share$title),
  #   tags$meta(name = "twitter:description", content = share$description),
  #   tags$meta(name = "twitter:image", content = share$image)
  # ),
  # tags$a(
  #   href="https://github.com/daattali/timevis",
  #   tags$img(style="position: absolute; top: 0; right: 0; border: 0;",
  #            src="github-orange-right.png",
  #            alt="Fork me on GitHub")
  ),
  div(id = "header",
    div(id = "title",
      "外访数据大屏"
    ),
    div(id = "subtitle",
        "轨迹监测"),
    div(id = "subsubtitle",
        "By",
        tags$a(href = "http://www.inter-credit.net/", "联信"),
        HTML("&bull;"),"数据研发"
        
        
    )
  ),
  
  
  bootstrapPage(
    tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
    
    REmapOutput("remap"),
    #id = "controls", class = "panel panel-default", 
    absolutePanel(fixed = T,
                  draggable = TRUE, top = 300, left = "auto", right = 20, bottom = "auto",
                  width = 230, height = "auto",
                  
                  selectInput("color", "地图样式", 
                              c("googlelite", "dark", "light","Blue"), selected = "googlelite"),
                  numericInput("zoom",
                               "地图缩放:",10,min = 1, max = 12),
                  selectInput("waifang","请选择外访员",choices=c("qdwf01","qdwf02","qdwf03","qdwf04","qdwf05","qdwf06","qdwf07"),
                              multiple=T),
                  
                  submitButton(text = "更新大屏", icon = NULL, width = NULL)
                  
    )
    
    
    )
)
