#RVest using another page.
#Set directory. This will be where you save results.  
#setwd("Z:\\jrg363\\Workshops Sp24\\WSR")

#Install and load packages. RVest for web scraping. 
#install.packages("rvest")

library(rvest)

#https://webscraper.io/test-sites/e-commerce/static

tech <- read_html("https://webscraper.io/test-sites/e-commerce/static")

#Extract price, item name, item description
title <- tech %>% html_nodes(xpath = "//*[@class='title']") %>% 
  html_text2() 
price <- tech %>% html_nodes(xpath = "//*[@class='price float-end card-title pull-right']")%>% 
  html_text2() 
desc <- tech %>% html_nodes(xpath = "//*[@class='description card-text']")%>% 
  html_text2() 

#Now create dataframe. 
products <- data.frame( 
  title, 
  price, 
  desc 
)

#Export dataframe
write.csv(products, "tech_products.csv")

#Now more advanced going through multiple pages.
urlbase = "https://webscraper.io/test-sites/e-commerce/static/computers/laptops?page="
page = 1

urls_list <- list()
title_list <- list()
price_list <- list()
desc_list <- list()

while(page < 20){
  url = paste(urlbase, as.character(page), sep = "")
  tech <- read_html(url)
  page = page + 1
  
  #Extract price, item name, item description
  title <- tech %>% html_nodes(xpath = "//*[@class='title']") %>% 
    html_text2() 
  price <- tech %>% html_nodes(xpath = "//*[@class='price float-end card-title pull-right']")%>% 
    html_text2() 
  desc <- tech %>% html_nodes(xpath = "//*[@class='description card-text']")%>% 
    html_text2() 
  
  length = length(price)
  urls_vect = rep(url, times = length)
  urls_list = append(urls_list, list(urls_vect))
  title_list = append(title_list, list(title))
  price_list = append(price_list, list(price))
  desc_list = append(desc_list, list(desc))
  
}

urls_list = unlist(urls_list, recursive=FALSE)
title_list = unlist(title_list, recursive=FALSE)
price_list = unlist(price_list, recursive=FALSE)
desc_list = unlist(desc_list, recursive=FALSE)

#Create dataframe from group of vectors. 
laptop_data <- data.frame(urls_list, title_list, price_list, desc_list)

#Export data as csv
write.csv(laptop_data, file = "laptop_data.csv")