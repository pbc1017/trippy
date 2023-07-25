import pandas as pd
from sklearn.metrics.pairwise import haversine_distances
from pymongo import MongoClient
from travel import load_data_from_mongodb as load_data

# Define a function to calculate weights for random selection
def calculate_weights_food(row):
    return row['reviewNum'] + 0.001 * row['reviewRate'] - 0.01 * row['distance_to_nearest_center']

def hotel(df_cluster):
    df_food = load_data('hotel')

    # Calculate cluster centers
    centers = df_cluster.groupby('cluster')[['center_latitude', 'center_longitude']].first()

    # Exclude rows with missing location
    df_food = df_food[df_food['location'].apply(lambda x: isinstance(x, str))]

    # Extract latitude and longitude from the 'location' column
    df_food['latitude'], df_food['longitude'] = zip(*df_food['location'].apply(lambda loc: map(float, loc.strip('()').split(','))))

    # Calculate haversine distances between each food place and each cluster center
    distances = haversine_distances(df_food[['latitude', 'longitude']], centers)*6371000/1000

    # Assign each food place to the nearest cluster
    df_food['nearest_cluster'] = distances.argmin(axis=1)

    # We can also calculate the distance to the nearest cluster center for each food place
    df_food['distance_to_nearest_center'] = distances.min(axis=1)

    # Calculate haversine distances between each travel place and its cluster center
    df_cluster['calculated_distance_to_center'] = df_cluster.apply(
        lambda row: haversine_distances(
            [[row['latitude'], row['longitude']]],
            [[row['center_latitude'], row['center_longitude']]]
        )[0][0]*6371000/1000, axis=1
    )

    # Calculate the maximum distance to the center for each cluster using the corrected distances
    max_distances_corrected = df_cluster.groupby('cluster')['calculated_distance_to_center'].max()

    # Filter out food places that are farther from the center than the farthest travel place in the same cluster
    df_food_filtered_corrected = df_food[df_food.apply(lambda row: row['distance_to_nearest_center'] <= max_distances_corrected[row['nearest_cluster']], axis=1)]

    # Calculate weights
    df_food_filtered_corrected['weight'] = df_food_filtered_corrected.apply(calculate_weights_food, axis=1)
    df_food_filtered_corrected['weight'] = df_food_filtered_corrected['weight'].clip(lower=0)

    # Create a dictionary to store the selected food places for each cluster
    selected_food_places = {cluster: [] for cluster in df_food_filtered_corrected['nearest_cluster'].unique()}

    # Iterate over each cluster
    for cluster in selected_food_places.keys():
        # Filter food places in this cluster
        df_cluster_food = df_food_filtered_corrected[df_food_filtered_corrected['nearest_cluster'] == cluster]
        
        # Normalize weights so that they can be used as probabilities
        df_cluster_food['weight'] = df_cluster_food['weight'] / df_cluster_food['weight'].sum()
        
        # Keep track of selected types to avoid duplicates
        # selected_types = set()
        
        # Select two food places
        while len(selected_food_places[cluster]) < 1:
            # Select a food place randomly, using weights as probabilities
            selected = df_cluster_food.sample(n=1, weights='weight').iloc[0]
            
            # If this type of food place has not been selected before, add it to the list
            # if selected['type'] not in selected_types:
            selected_food_places[cluster].append(selected['id'])
                # selected_types.add(selected['type'])

    # Prepare the final dataframe
    selected_df = pd.DataFrame()
    for cluster, ids in selected_food_places.items():
        selected_df = pd.concat([selected_df, df_food[df_food['id'].isin(ids)]])
    selected_df.loc[selected_df['nearest_cluster'] == 1, 'cluster'] = 0
    selected_df.loc[selected_df['nearest_cluster'] == 2, 'cluster'] = 1
    selected_df = selected_df[selected_df['nearest_cluster'] != 0]
    selected_df['cluster'] = selected_df['cluster'].astype(int)

    return selected_df