import pandas as pd
import numpy as np
from sklearn.cluster import KMeans
from pymongo import MongoClient

def load_data_from_mongodb(collection_name):
    db_name = "trippy"
    uri = "mongodb+srv://knsol2:1017@cluster0.9vu4wen.mongodb.net/"
    client = MongoClient(uri)
    db = client[db_name]
    collection = db[collection_name]
    data = collection.find()
    df = pd.DataFrame(list(data))
    return df

def get_preference(M_pref, U_pref, O_pref, A_pref, B_pref, _1_pref, _2_pref, _3_pref):
    preferences = {'M': M_pref, 'U': U_pref, 'O': O_pref, 'A': A_pref, 'B': B_pref, '1': _1_pref, '2': _2_pref, '3': _3_pref}
    return preferences

def set_weights(data, travel_type, review_num, review_rate, preferences):
    weight = 0
    for i in range(0, len(travel_type), 3):
        type_ = travel_type[i:i+3]
        for char in type_:
            weight += preferences[char]

    review_weight = add_review_weights(data, review_num, review_rate)
    weight += review_weight

    return weight

def add_review_weights(data, review_num, review_rate):
    if review_num == 0 and review_rate == 0:
      normalized_review_num = data['reviewNum'].mean() / data['reviewNum'].max()
      normalized_review_rate = data['reviewRate'].mean() / 5
    else:
      normalized_review_num = review_num / data['reviewNum'].max()
      normalized_review_rate = review_rate / 5
    review_weight = normalized_review_num + normalized_review_rate
    return review_weight * 10

def calculate_weights(data, preferences):
    weights = data.apply(lambda row: set_weights(data, row['type'], row['reviewNum'], row['reviewRate'], preferences), axis=1)
    data['weight'] = weights
    average_review_weight = data[data['reviewNum'] > 0]['weight'].mean()
    data.loc[data['reviewNum'] == 0, 'weight'] = average_review_weight

    return data

def recommend_destinations(data, num_recommendations):
    probabilities = data['weight'] / data['weight'].sum()
    recommended_destinations = data.sample(n=num_recommendations, replace=False, weights=probabilities)
    return recommended_destinations

def safe_eval(cell):
    try:
        return eval(cell)
    except (SyntaxError, TypeError, NameError):
        return np.nan

def clustering(df):
  df["location"] = df["location"].apply(safe_eval)  # convert string to tuple
  df = df.dropna(subset=['location'])
  df[["latitude", "longitude"]] = pd.DataFrame(df["location"].tolist(), index=df.index)  # split tuple to new columns
  df = df.drop(columns=["location"])  # drop the original location column

  # number of clusters
  n_clusters = 3

  # perform K-means clustering
  kmeans = KMeans(n_clusters=n_clusters, n_init=10, random_state=0).fit(df[["latitude", "longitude"]])

  # assign cluster labels
  df["cluster"] = kmeans.labels_

  # calculate distance of each point to its cluster center
  distances = kmeans.transform(df[["latitude", "longitude"]])

  # calculate distance to cluster center for each point
  df["distance_to_center"] = [distances[i][kmeans.labels_[i]] for i in range(len(distances))]

  # sort points in each cluster by distance to center
  df_sorted = df.sort_values(["cluster", "distance_to_center"])

  # select top 4 points in each cluster
  df_filtered = df_sorted.groupby("cluster").head(4).reset_index(drop=True)

  # calculate cluster centers
  cluster_centers = pd.DataFrame(kmeans.cluster_centers_, columns=["center_latitude", "center_longitude"])
  cluster_centers["cluster"] = range(n_clusters)

  # merge cluster centers with the main DataFrame
  df_filtered = pd.merge(df_filtered, cluster_centers, on="cluster")

  return df_filtered

def recommend_until_sufficient(data, min_per_cluster):
    recommendations = pd.DataFrame(columns=data.columns)
    while True:
        new_recommendations = recommend_destinations(data, 20)
        recommendations = pd.concat([recommendations, new_recommendations])
        clustered_recommendations = clustering(recommendations)
        cluster_counts = clustered_recommendations['cluster'].value_counts()
        if all(count >= min_per_cluster for count in cluster_counts):
            break
    # clustered_recommendations= clustered_recommendations.dropna(axis=1, how='all')
    return clustered_recommendations

def travel(_M, _U, _O, _A, _B, _1, _2, _3):
  data = load_data_from_mongodb('travel')
  preferences = get_preference(_M, _U, _O, _A, _B, _1, _2, _3)
  data = calculate_weights(data, preferences)
  clustered_recommendations = recommend_until_sufficient(data, 4)
  return clustered_recommendations