#Set directory. This will be where you save results.  
#setwd("Z:\\jrg363\\Workshops Sp24\\WSR")

#Install and load packages. RVest for web scraping. 
#install.packages("rvest")

library(rvest)

#scrape the following webpages
#https://webscraper.io/test-sites/e-commerce/static
#https://scrapeme.live/shop/

#pokemon example
#Load page. 
poke <- read_html("https://scrapeme.live/shop/page/1")

#Talk about inspect feature. How to copy xpath. 

#Find each list item. Using xpath. 
html_products <- poke %>% html_nodes(xpath = "//*[@id='main']/ul/li")

#Could go by class too. Or any attribute. Then get sub elements for list items. 
html_products1 <- poke %>% html_nodes(xpath = "//*[@class='products columns-4']")
html_products1 <- html_products1 %>% html_elements("li")
  

#Extract html sub-elements. Link, title, price
# selecting the "a" HTML element storing the product URL 
a_element <- html_products %>% html_element("a") 
h2_element <- html_products %>% html_element("h2") 
span_element <- html_products %>% html_element("span")

#Extract data from html elements. 
#Extract attribute of element. 
product_urls <- html_products %>% 
  html_element("a") %>% 
  html_attr("href") 

#Extract text of element. 
product_names <- html_products %>% 
  html_element("h2") %>% 
  html_text2() 
product_prices <- html_products %>% 
  html_element("span") %>% 
  html_text2()


#Create dataframe
products <- data.frame( 
  product_urls, 
  product_names, 
  product_prices 
)

# changing the column names of the data frame before exporting it into CSV 
names(products) <- c("url", "name", "price")

#View dataset
View(products)

# export the data frame containing the scraped data to a CSV file 
write.csv(products, file = "products.csv", fileEncoding = "UTF-8")



#Following link as tutorial for above example. Sources
#https://www.zenrows.com/blog/web-scraping-r#instal-rvest
