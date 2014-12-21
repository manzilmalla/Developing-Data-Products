library(shiny)

##Define Functions:

compound_amount<-function(principal,rate,start,end,interval,inflation){
  principal*(1+(rate/interval))^(interval*(end-start))*((1+inflation/100)^(end-start))
}

interval_ext<-function(compound_Int){
  if (compound_Int == "Daily") {365}
  else if (compound_Int=="Monthly"){12}
  else if (compound_Int=="Quarterly"){4}
  else if (compound_Int=="Half-Yearly"){2}
  else {1} 
}

inflation_rate<-function(check,inf_rate){
  if (check) {inf_rate}
  else {0}
}


final_text<-function(principal, start,end,interest_rate,freq,inc_inflation,inflation_rate){
  if (inc_inflation==T){
    text=paste("(Also includes inflation at the rate of ",inflation_rate,"%)",sep="")
  } else {
    text="(Does not include inflation.)"
  }
  
  text2=paste("The balance and interest in ",end, " on a base amount of $",principal," borrowed on ", start," at the rate of ",interest_rate,"%",", cumulated ",tolower(freq),":",sep="")
  
  text3<-paste(text2,text,sep="")
  text3
}


shinyServer(
  function(input, output) {
    
    output$finaltext<-renderPrint({  
        final_text(input$Principal,input$Period[1],input$Period[2],input$Interest_Rate,input$Compound_Int,input$inc_inflation,input$Inflation_Rate)
        })
    
    output$principal <- renderPrint({input$Principal})
    
    
    output$amount <- renderPrint({    
      compound_amount(input$Principal,(input$Interest_Rate/100),input$Period[1],input$Period[2],interval_ext(input$Compound_Int),inflation_rate(input$inc_inflation,input$Inflation_Rate))
        })
    
    output$interest<-renderPrint({
      compound_amount(input$Principal,(input$Interest_Rate/100),input$Period[1],input$Period[2],interval_ext(input$Compound_Int),inflation_rate(input$inc_inflation,input$Inflation_Rate))-input$Principal
        })
  }
)