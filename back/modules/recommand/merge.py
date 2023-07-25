from sklearn.metrics.pairwise import haversine_distances
import pandas as pd
import numpy as np

def get_next_location(current_location, candidates):
    # Calculate distances to the next locations
    distances = haversine_distances([current_location], candidates)*6371000/1000
    # Get the index of the closest location
    closest_index = distances.argmin()
    # Get the closest location
    closest_location = candidates[closest_index]
    # Remove the selected location from the candidates
    candidates = np.delete(candidates, closest_index, axis=0)
    return closest_location, candidates, closest_index

def get_travel_order(df_travel, df_food):
    # Initialize the travel order
    travel_order = []
    # Get the initial location (the first travel place)
    current_location = df_travel.iloc[0, 2:4].values
    travel_order.append(df_travel.iloc[0])
    df_travel = df_travel.drop(df_travel.index[0])
    # Get the next location (the first food place)
    current_location, df_food_locations, closest_index = get_next_location(current_location, df_food[['latitude', 'longitude']].values)
    travel_order.append(df_food.iloc[closest_index])
    df_food = df_food.drop(df_food.index[closest_index])
    # Get the next two locations (the next two travel places)
    for _ in range(2):
        current_location, df_travel_locations, closest_index = get_next_location(current_location, df_travel[['latitude', 'longitude']].values)
        travel_order.append(df_travel.iloc[closest_index])
        df_travel = df_travel.drop(df_travel.index[closest_index])
    # Get the next location (the second food place)
    current_location, df_food_locations, closest_index = get_next_location(current_location, df_food[['latitude', 'longitude']].values)
    travel_order.append(df_food.iloc[closest_index])
    df_food = df_food.drop(df_food.index[closest_index])
    # Get the final location (the last travel place)
    current_location, df_travel_locations, closest_index = get_next_location(current_location, df_travel[['latitude', 'longitude']].values)
    travel_order.append(df_travel.iloc[closest_index])
    df_travel = df_travel.drop(df_travel.index[closest_index])
    # Return the travel order as a DataFrame
    return pd.DataFrame(travel_order)