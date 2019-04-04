# 1. 'population_country.csv' 파일을 data.table 패키지의 fread() 함수를 
# 사용하여 읽어오고 df 객체에 저장하시오.
# (단, data.table 인자의 값은 FALSE로 한다.)
library("data.table")
df = fread("population_country.csv", data.table = FALSE)
# 2. df의 row 개수는 몇 개 인가?
nrow(df)

head(df)
# 3. 한 국가당 하나의 row를 가지고 있는지 국가명[Country_Name] 변수를
#    활용하여 계산하시오.
table(df$`Country Name`)
nrow(df) == length(unique(df$`Country Name`))

# 4. "Arab World"와 "World" 국가 데이터를 제외한 나머지 국가의
#    데이터를 df_sub 객체에 저장하시오.
# 1)
df_sub = df[df$`Country Name` != "Arab World", ]
df_sub = df_sub[df_sub$`Country Name` != "World", ]

# 2)
df_sub = df[!df$`Country Name` %in% c("Arab World", "World"),]

# 5. df_sub 객체의 row 개수는 몇 개 인가?
nrow(df_sub)

# 6. df_sub 객체의 결측치 개수는 총 몇 개 인가?
# 1)
summary(df_sub)

# 2)
for(n in 1:ncol(df_sub)){
  na_cnt = sum(is.na(df_sub[, n]))
  print(paste0(n, "(", colnames(df_sub)[n], "): ", na_cnt))
}

na_sum = c()
for(n in 1:ncol(df_sub)){
  na_sum[n] = sum(is.na(df_sub[, n]))
}
sum(na_sum)

# 3
na_cnt = function(x){
  sum(is.na(x))
}
apply(df_sub, MARGIN = 2, FUN = "na_cnt")
sum(apply(df_sub, MARGIN = 2, FUN = "na_cnt"))

# 4
sum(is.na(df_sub))

# 7. df_sub 객체의 결측치를 전부 0으로 치환하시오.
df_sub[is.na(df_sub$y1960), "y1960"] = 0

df_sub[is.na(df_sub[, 1]), 1] = 0

for(n_col in 1:ncol(df_sub)){
  df_sub[is.na(df_sub[, n]), n] = 0  
}

# 8. df_sub 객체의 속성을 data.frame에서 data.table 속성으로 변환하고 이를 확인하시오.
df_sub = as.data.table(df_sub)
class(df_sub)

# 9. df_sub 객체를 data.table 패키지의 melt() 함수를 사용하여 
#    국가명[Country_Name], 연도[year], 인구수[pop] 정보를 담고있는
# df_melt 객체를 생성하시오.
# (data.table 패키지의 melt() 함수는 data.frame의 melt() 함수 용례와 같다.)
df_melt = data.table::melt(data = df_sub, id.vars = "Country Name",
                           variable.name = "year", value.name = "pop")
head(df_melt)
?melt

