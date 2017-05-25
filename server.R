


# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(REmap)

thc_center <- c(120.324632,36.072374)

##read the data
lonlat_thc <- read.csv(file="data/dzhi.csv",header=T)                           
names(lonlat_thc)<-c('lon','lat','origin','x','lon','lat','destination')

#前三列为源点及经纬度，后三列为目标点及经纬度
head(lonlat_thc)
gdata1 <- lonlat_thc[,1:3]
names(gdata1) <- c("lon","lat","city")
gdata2 <- lonlat_thc[,5:7]
names(gdata2) <- c("lon","lat","city")
gdata <- rbind(gdata1,gdata2)
head(gdata)


markLine_data <- data.frame(origin=gdata1[,3],
                            destination=gdata2[,3],
                            color=c(rep("red",72),rep("blue",56),rep("green",42),
                                    rep("gold",41),rep("lime",61),rep("cyan",53),rep("Maroon",58)))


#gdata
wfxl<-substr(gdata[,3],1,1)
wfbh<-ifelse(wfxl=='a','qdwf01',ifelse(wfxl=='b','qdwf02',ifelse(wfxl=='c','qdwf03',
                                                                 ifelse(wfxl=="d","qdwf04",
                                                                        ifelse(wfxl=='e','qdwf05',
                                                                               ifelse(wfxl=='f','qdwf06','qdwf07'))))))
#line


wfbhline<-ifelse(markLine_data[,3]=='green','qdwf01',ifelse(markLine_data[,3]=='blue','qdwf02',ifelse(markLine_data[,3]=="red",'qdwf03',
                                                                             ifelse(markLine_data[,3]=="gold","qdwf04",
                                                                                    ifelse(markLine_data[,3]=='lime','qdwf05',
                                                                                           ifelse(markLine_data[,3]=='cyan','qdwf06','qdwf07'))))))

#point
pointdata<-c('c73','b57','g59','a43','d42','e62','f54')
pointdataxl<-substr(pointdata,1,1)
pointdatabh<-ifelse(pointdataxl=="a","qdwf01",
                    ifelse(pointdataxl=='b','qdwf02',
                           ifelse(pointdataxl=='c','qdwf03',
                                  ifelse(pointdataxl=='d','qdwf04',
                                         ifelse(pointdataxl=='e','qdwf05',
                                                ifelse(pointdataxl=='f','qdwf06','qdwf07'))))))



markLine_Control <- markLineControl(symbolSize=c(0,0.01),
                                    smoothness=0,
                                    effect=T,
                                    lineWidth=2,
                                    lineType="solid"
)

markPoint_Control<-markPointControl(symbol='image://http://www.inter-credit.net/imges/logo1.png' ,  
                                    symbolSize = 20,  
                                    effect = F)

#---------------------------------------------------------

shinyServer(function(input, output) {
  
  output$remap <- renderREmap({
    
    if(length(input$waifang)==0){
      remapB(center=thc_center,
             zoom = input$zoom,
             color = input$color,
             markLineData=markLine_data,
             markLineTheme=markLine_Control,
             markPointData =pointdata, 
             markPointTheme=markPoint_Control,
             geoData= gdata   #三列，第一列为经纬，第二维度，第三对应的点名
      )
      
    }
    
    else
    {
      gdataout<-gdata[which(wfbh %in% input$waifang),]
      markLine_dataout<- markLine_data[which(wfbhline %in% input$waifang),]
      
      remapB(center=thc_center,
             zoom = input$zoom,
             color = input$color,
             markLineData=markLine_dataout,
             markLineTheme=markLine_Control,
             markPointData =pointdata[which(pointdatabh %in% input$waifang)], 
             markPointTheme=markPoint_Control,
             geoData= gdataout   #三列，第一列为经纬，第二维度，第三对应的点名
      )
    }
   
    
    
    
  },height='900px')
  
  #加入平均时速
  #有效及外访户数
})
