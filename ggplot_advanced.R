#### __ [01] 고급 그래프 ####
#### ____ ● 제품 평가 ####
library("dplyr")
library("tidyr")
library("ggplot2")

df = read.csv("prods_scores.csv", stringsAsFactors = FALSE)
df[, "score_phrase"] = factor(df$score_phrase,
                              levels = c("Disaster", "Unbearable", "Painful", "Awful", "Bad",
                                         "Mediocre",
                                         "Okay", "Good", "Great", "Amazing", "Masterpiece"))

Microsoft = paste0("Xbox", c(" One", "", " 360"))
Sony = paste0("PlayStation", c(" Portable", " 4", " 2", " 3", " Vita", ""))
PC = c("Linux", "Macintosh", "SteamOS", "PC")
Nintendo = c(paste0("Nintendo ", c("3DS", 64, "64DD", "DS", "DSi")),
             "New Nintendo 3DS",
             paste0("Game Boy", c("", " Color", " Advance")),
             "Wii",
             "Wii U",
             "NES",
             "GameCube",
             "Super NES")

df[, "company"] = ifelse(df$platform %in% Microsoft, "Microsoft",
                         ifelse(df$platform %in% Sony, "Sony",
                                ifelse(df$platform %in% PC, "PC",
                                       ifelse(df$platform %in% Nintendo,
                                              "Nintendo", "Other"))))

my.palette = c("Sony"      = "#EDC951",
               "Nintendo"  = "#EB6841",
               "PC"        = "#CC2A36",
               "Microsoft" = "#4F372D",
               "Other"     = "#00A0B0")

ggplot(data = df, 
       aes(x = score_phrase,
           y = company,
           color = company)) +
  # geom_point(size = 10, alpha = 0.1) +
  geom_jitter(alpha = 0.2) +
  scale_color_manual(values = my.palette) +
  labs(x = "Score category", y = NULL, title = "Reviews by Score categories") +
  theme_bw() +
  theme(legend.position = "none")

#### ____ ● 월별 기온 분포 ####
library("lubridate")
library("viridis")
library("ggridges")

df_weather = read.csv("nebraska_2016.csv", stringsAsFactors = FALSE)
df_weather[, "Month"] = month(df_weather$CST)
df_weather[, "Month_order"] = factor(month.name[df_weather$Month],
                                     levels = month.name)

ggplot(df_weather, 
       aes(x = Mean.TemperatureF, 
           y = Month_order, 
           fill = ..x..)) +
  geom_density_ridges_gradient(scale = 3, 
                               rel_min_height = 0.01, 
                               gradient_lwd = 1) +
  scale_x_continuous(expand = c(0.01, 0.01)) +
  scale_y_discrete(  expand = c(0.01, 0.01)) +
  scale_fill_viridis(name = "Temp. [F]", option = "C") +
  labs(title = 'Temperatures in Lincoln NE') +
  theme_ridges(font_size = 13, grid = TRUE) + 
  theme(axis.title.y = element_blank())
