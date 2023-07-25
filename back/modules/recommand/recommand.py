import pandas as pd
import numpy as np
from travel import travel
from food import food
from hotel import hotel
from merge import get_travel_order
import sys

def recommand(_M,_U,_O,_A,_B,_1,_2,_3):
  # _M,_U,_O,_A,_B,_1,_2,_3 = map(int, input().split())
  _M,_U,_O,_A,_B,_1,_2,_3 = map(int, [_M,_U,_O,_A,_B,_1,_2,_3])
  travel_df = travel(_M,_U,_O,_A,_B,_1,_2,_3)
  food_df = food(travel_df)
  hotel_df = hotel(travel_df)
  needs = ['id','name','cluster','latitude','longitude','img','call','oneliner','detail','isPark']
  travel_df = travel_df[needs]
  food_df = food_df[needs]
  hotel_df = hotel_df[needs]
  merge_df = pd.concat([travel_df,food_df,hotel_df])

  final_df=pd.DataFrame()
  for cluster in merge_df['cluster'].unique():
    # Get the travel and food data for this cluster
    df_travel_cluster = travel_df[travel_df['cluster'] == cluster]
    df_food_cluster = food_df[food_df['cluster'] == cluster]
    df_hotel_cluster = hotel_df[hotel_df['cluster'] == cluster]
    # Get the travel order for this cluster
    df_order = get_travel_order(df_travel_cluster, df_food_cluster,df_hotel_cluster)
    final_df=pd.concat([final_df,df_order])
  print(final_df.to_json(orient='records'))
  final_df.to_csv('output.csv')
  return final_df.to_json(orient='records')

try:
  recommand(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4], sys.argv[5], sys.argv[6], sys.argv[7], sys.argv[8])
except:
  print("error")

# recommand(0,0,0,0,0,0,0,0)