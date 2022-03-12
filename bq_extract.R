# store the project id
projectid = "source-data-314320"

# set your query
sql <- "SELECT *
        FROM `source-data-314320.Store_Data.All_Data`
        ORDER BY Date desc
        "

# Run the query and store the data in a tibble
All_Data <- bq_project_query(projectid, sql)

BQ_Table <- bq_table_download(All_Data)

# Print first rows of the data
BQ_Table



# analyse the monthly sales trends by owner
# transform the data set by aggregating by month.
sales_monthly <- BQ_Table %>%
  mutate(month = month(date, label = TRUE),
         year  = year(date),
         owner,
         tienda) %>%
  group_by(year, month, owner, tienda) %>%
  summarise(total_sales = sum(sales))

sales_monthly