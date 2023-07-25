import pandas as pd
import numpy as np
from travel import travel
from food import food
from merge import get_travel_order

travel_df = travel(3, 9, 5, 2, 8, 3, 9, 4)
food_df = food(travel_df)
travel_df = travel_df[['id','name','latitude','longitude','cluster']]
travel_df=travel_df.set_index('id')
food_df = food_df.set_index('id')
merge_df = pd.concat([travel_df,food_df])

final_df=pd.DataFrame()
for cluster in merge_df['cluster'].unique():
  # Get the travel and food data for this cluster
  df_travel_cluster = travel_df[travel_df['cluster'] == cluster]
  df_food_cluster = food_df[food_df['cluster'] == cluster]
  # Get the travel order for this cluster
  df_order = get_travel_order(df_travel_cluster, df_food_cluster)
  final_df=pd.concat([final_df,df_order])
print(final_df)
final_df.to_csv('output.csv')