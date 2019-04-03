df = data.frame(xx = 1:10,
                yy = 1:10)
ggplot(data = df, 
       aes(x = xx, y = yy)) +
  geom_hline(yintercept = 5, size = 1.5, color = "red") +
  geom_line(size = 2) +
  geom_point(size = 8) + 
  geom_point(size = 6, color = "#FFFFFF") + 
  geom_text(aes(label = LETTERS[1:10],
                y = yy - 1)) +
  scale_y_continuous(breaks = 1:10, labels = 1:10) + 
  theme_bw()
