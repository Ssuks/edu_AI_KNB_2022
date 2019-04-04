# 1. "bike.csv" 데이터를 read.csv() 함수로 불러와서 df 객체에 저장하시오.
# (단, stringsAsFactors 인자의 값은 FALSE로 한다)
df = read.csv("bike.csv", stringsAsFactors = FALSE)

# 2. df 객체의 상위 6개 row를 출력하시오.
head(df)

# (lubridate 패키지의 함수를 활용하여 다음 문제를 풀이하는 것을 권장.)
library("lubridate")

# 3. [datetime] 변수에서 연도를 추출하여 [year] 변수를 df 객체에 새로 생성하시오.
df[, "year"] = year(df$datetime)
head(df)

# 4. [datetime] 변수에서 월을 추출하여 [month] 변수를 df 객체에 새로 생성하시오.
df[, "month"] = month(df$datetime)

# 5. [datetime] 변수에서 시간을 추출하여 [hour] 변수를 df 객체에 새로 생성하시오.
df[, "hour"] = hour(df$datetime)

# 6. [datetime] 변수에서 일자를 추출하여 [date] 변수를 df 객체에 새로 생성하시오.
df[, "date"] = date(df$datetime)
head(df, 2)

# 7. [date] 변수에서 요일 정보를 추출하여 [wday] 변수를 df 객체에 새로 생성하시오.
df[, "wday"] = wday(df$date, week_start = 1)

# 8. [season] 변수와 [weather] 변수를 활용하여 그 조합의 빈도를 확인하시오
# (table() 함수 활용 권장)
table(df$season, df$weather)
tb = table(df[, c("season", "weather")])
round(prop.table(tb), 3)
round(prop.table(tb, margin = 1), 3)

# 9. [temp] 변수와, [atemp] 변수의 상관계수를 확인하시오.
cor(df$temp, df$atemp)

library("ggplot2")
ggplot(data = df,
       aes(x = temp, y = atemp)) + 
  geom_point(size = 3, alpha = 0.2)

# 10. 시간[hour]별 [casual] 변수의 평균을 구하여 df_cnt_mean 객체에 저장하시오.
head(df, 2)
df_cnt_mean = aggregate(data = df, casual ~ hour, FUN = "mean")
agg_test = aggregate(data = df, casual ~ wday + hour, FUN = "mean")
head(agg_test)

# 11. 시간[hour]별 [registered] 변수의 평균을 구하여 df_reg_mean 객체에 저장하시오.
df_reg_mean = aggregate(data = df, registered ~ hour, FUN = "mean")

# 12. 10번의 결과와 11번의 결과를 시각화 하시오.
ggplot() + 
  geom_col(data = df_cnt_mean,
           aes(x = hour, y = casual, fill = casual)) + 
  geom_point(data = df_reg_mean, aes(x = hour, y = registered),
             size = 3) + 
  geom_line(data = df_reg_mean, aes(x = hour, y = registered),
            size = 1.2) +
  theme_bw() + 
  theme(legend.position = "none")
