####----- Plotly for interactive plots with 2015.csv -----####
install.packages("plotly")
library(plotly)
library(tidyverse)

# Load the data
df <- read.csv("C:/Users/RAMESH/Downloads/2015.csv")  # Make sure the file is in your working directory
# Or use the full path: df <- read.csv("C:/path/to/your/2015.csv")

# Check column names
colnames(df)

# View the structure of the data
str(df)
head(df)

# 1. Scatter plot - Happiness Score vs Economy (GDP per Capita)
plot_ly(df, x = ~Economy..GDP.per.Capita., y = ~Happiness.Score, 
        color = ~Region, type = "scatter", mode = "markers",
        text = ~paste("Country:", Country, "<br>Happiness:", Happiness.Score),
        hoverinfo = "text")

# 2. Scatter plot with size based on Health (Life Expectancy)
plot_ly(df, x = ~Economy..GDP.per.Capita., y = ~Happiness.Score, 
        color = ~Region, type = "scatter", mode = "markers",
        size = ~Health..Life.Expectancy.,
        text = ~paste("Country:", Country, "<br>Region:", Region),
        hoverinfo = "text")

# 3. Bar plot - Average Happiness Score by Region
region_avg <- df %>% 
  group_by(Region) %>% 
  summarise(Avg_Happiness = mean(Happiness.Score))

plot_ly(region_avg, x = ~Region, y = ~Avg_Happiness, 
        type = "bar", color = ~Region) %>%
  layout(title = "Average Happiness Score by Region")

# 4. Histogram - Distribution of Happiness Scores
plot_ly(df, x = ~Happiness.Score, type = "histogram",
        nbinsx = 20) %>%
  layout(title = "Distribution of Happiness Scores")

# 5. Boxplot - Happiness Score by Region
plot_ly(df, x = ~Region, y = ~Happiness.Score, 
        color = ~Region, type = "box") %>%
  layout(title = "Happiness Score Distribution by Region")

# 6. Heatmap - Correlation between different factors
# First create a correlation matrix
cor_matrix <- df %>% 
  select(Happiness.Score, Economy..GDP.per.Capita., Family, 
         Health..Life.Expectancy., Freedom, 
         Trust..Government.Corruption., Generosity) %>%
  cor(use = "complete.obs")

plot_ly(x = colnames(cor_matrix), y = colnames(cor_matrix), 
        z = cor_matrix, type = "heatmap") %>%
  layout(title = "Correlation Matrix of Happiness Factors")

# 7. Pie chart - Number of Countries by Region
region_count <- df %>% 
  group_by(Region) %>% 
  summarise(Count = n())

plot_ly(region_count, labels = ~Region, values = ~Count, 
        type = "pie") %>%
  layout(title = "Number of Countries by Region")

# 8. Bubble chart - Happiness vs Economy with Health as bubble size
plot_ly(df, x = ~Economy..GDP.per.Capita., y = ~Happiness.Score,
        color = ~Region, type = "scatter", mode = "markers",
        size = ~Health..Life.Expectancy.,
        text = ~paste("Country:", Country, 
                      "<br>GDP:", round(Economy..GDP.per.Capita., 2),
                      "<br>Happiness:", round(Happiness.Score, 2)),
        hoverinfo = "text") %>%
  layout(title = "Happiness vs GDP per Capita (Bubble size = Life Expectancy)")

# 9. Violin plot - Distribution of Freedom by Region
plot_ly(df, x = ~Region, y = ~Freedom, 
        color = ~Region, type = "violin") %>%
  layout(title = "Freedom Distribution by Region")

# 10. 3D scatter plot - Happiness vs Economy vs Health
plot_ly(df, x = ~Economy..GDP.per.Capita., 
        y = ~Health..Life.Expectancy., 
        z = ~Happiness.Score, 
        color = ~Region, 
        type = "scatter3d", 
        mode = "markers",
        text = ~Country,
        hoverinfo = "text") %>%
  layout(title = "3D: Happiness vs GDP vs Life Expectancy")

# 11. Line plot - Top 10 happiest countries
top_10 <- df %>% 
  arrange(desc(Happiness.Score)) %>% 
  head(10)

plot_ly(top_10, x = ~Country, y = ~Happiness.Score, 
        type = "scatter", mode = "lines+markers",
        color = ~Region) %>%
  layout(title = "Top 10 Happiest Countries")

# 12. Multiple subplots - Compare different factors
# Create individual plots
p1 <- plot_ly(df, x = ~Economy..GDP.per.Capita., y = ~Happiness.Score, 
              type = "scatter", mode = "markers", name = "GDP") %>%
  layout(xaxis = list(title = "GDP per Capita"))

p2 <- plot_ly(df, x = ~Health..Life.Expectancy., y = ~Happiness.Score, 
              type = "scatter", mode = "markers", name = "Health") %>%
  layout(xaxis = list(title = "Life Expectancy"))

p3 <- plot_ly(df, x = ~Freedom, y = ~Happiness.Score, 
              type = "scatter", mode = "markers", name = "Freedom") %>%
  layout(xaxis = list(title = "Freedom"))

p4 <- plot_ly(df, x = ~Generosity, y = ~Happiness.Score, 
              type = "scatter", mode = "markers", name = "Generosity") %>%
  layout(xaxis = list(title = "Generosity"))

# Combine into subplots
subplot(p1, p2, p3, p4, nrows = 2, shareY = TRUE) %>%
  layout(title = "Happiness Score vs Various Factors")

# 13. Interactive map (if you have country coordinates)
# Note: This requires additional packages and country coordinates
# install.packages("countrycode")
library(countrycode)

# Add country codes
df$iso3 <- countrycode(df$Country, "country.name", "iso3c")

plot_ly(df, type = 'choropleth', 
        locations = ~iso3,
        z = ~Happiness.Score,
        text = ~paste(Country, "<br>Happiness:", Happiness.Score),
        colorscale = "Viridis",
        colorbar = list(title = "Happiness Score")) %>%
  layout(title = "World Happiness Map 2015")

# 14. Customized scatter plot with regression line
plot_ly(df, x = ~Economy..GDP.per.Capita., y = ~Happiness.Score,
        color = ~Region, type = "scatter", mode = "markers",
        text = ~Country) %>%
  add_trace(x = ~Economy..GDP.per.Capita., y = ~fitted(lm(Happiness.Score ~ Economy..GDP.per.Capita., data = df)),
            mode = "lines", line = list(color = "black"), name = "Trend line") %>%
  layout(title = "Happiness vs GDP with Trend Line")

# 15. Interactive table with plotly (alternative to View)
plot_ly(type = 'table',
        header = list(values = c("Country", "Region", "Happiness Score", "GDP")),
        cells = list(values = rbind(df$Country, df$Region, 
                                    round(df$Happiness.Score, 2), 
                                    
          
                                    round(df$Economy..GDP.per.Capita., 2))))





