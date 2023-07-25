from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
import json
import requests
import pandas as pd
import time
import os

def geocoding(address):
  api_key = "65fcfd0ba2283e69daf84cbd73c74b57"
  url = 'https://dapi.kakao.com/v2/local/search/address.json?query={address}'.format(address=address)
  headers = {"Authorization": "KakaoAK " + api_key}
  result = json.loads(str(requests.get(url, headers=headers).text))
  match_first = result['documents'][0]['address']
  return float(match_first['y']), float(match_first['x'])

num = 0
def pageScroll(driver):
  global num
  # original_window = driver.current_window_handle
  data = []
  elements = driver.find_elements(By.CSS_SELECTOR, 'ul.list_thumType.place li.bdr_nor, ul.list_thumType.place li:not([class])')

  for element in elements:
    # try:
    WebDriverWait(driver, 10).until(EC.presence_of_element_located((By.CSS_SELECTOR, 'img')))
    name = element.find_element(By.CSS_SELECTOR, 'div.tit a').text.split("[")[0]
    cotid = element.find_element(By.CSS_SELECTOR, 'div.tit a').get_attribute('onclick').split("'")[1]
    
    detail_url = f"https://korean.visitkorea.or.kr/detail/ms_detail.do?cotid={cotid}"
    driver.execute_script("window.open('');")
    driver.switch_to.window(driver.window_handles[1])
    driver.get(detail_url)
    WebDriverWait(driver, 10).until(EC.presence_of_element_located((By.CSS_SELECTOR, 'img.swiper-lazy.swiper-lazy-loaded')))

    info_list = driver.find_element(By.CSS_SELECTOR, 'div.area_txtView ul').find_elements(By.TAG_NAME, 'li')
    tmp = {}
    for li in info_list:
      key = li.find_element(By.TAG_NAME, 'strong').text
      value = li.find_element(By.TAG_NAME, 'span').text
      tmp[key] = value

    try:
      call = tmp['문의 및 안내']
    except:
      call = ""

    try:
      homepage = tmp['홈페이지']
    except:
      homepage = ""
      
    try:
      isPark = tmp['주차']
    except:
      isPark = ""

    try:
      inTime = tmp['입실시간']
    except:
      inTime = ""
      
    try:
      outTime = tmp['퇴실시간']
    except:
      outTime = ""
      
    try:
      size = tmp['수용인원']
    except:
      size = ""
      
    try:
      address	= tmp['주소']
      location = geocoding(tmp['주소'])
    except:
      address	= ""
      location = ""
    img	= driver.find_element(By.CSS_SELECTOR, 'img.swiper-lazy.swiper-lazy-loaded').get_attribute('src')
    oneliner = driver.find_element(By.CSS_SELECTOR, 'div.titTypeWrap').text
    detail = driver.find_element(By.CSS_SELECTOR, 'div.inr_wrap div.inr p').text

    driver.close()  
    driver.switch_to.window(driver.window_handles[0])

    driver.execute_script("window.open('');")
    driver.switch_to.window(driver.window_handles[1])
    driver.get(f"https://map.kakao.com/?q=부산 {name}")
    mapUrl=driver.current_url
    try:
      WebDriverWait(driver, 3).until(EC.presence_of_element_located((By.CSS_SELECTOR, 'li.PlaceItem.clickArea')))
      list = driver.find_elements(By.CSS_SELECTOR, "li.PlaceItem.clickArea")[0]
      reviewNum = list.find_element(By.CSS_SELECTOR, 'div.rating.clickArea a.numberofscore').text.split("건")[0]
      reviewRate = list.find_element(By.CSS_SELECTOR, 'div.rating.clickArea em.num').text
    except:
      reviewNum = 0
      reviewRate = 0.0

    try:
      type = list.find_element(By.CSS_SELECTOR, 'div.rating.clickArea span.subcategory.clickable').text
    except:
      type = ""

    driver.close()  
    driver.switch_to.window(driver.window_handles[0])
    
    num += 1
    
    # 원소에 대한 정보를 리스트에 추가합니다.
    data.append({
        'id': f"hotel_부산_{num:05d}",
        'name': name,
        'type': type,
        'price': "",
        'address': address,	
        'location': location,
        'img': img,	
        'call': call,	
        'url': detail_url,
        'homepage':	homepage,
        'oneliner':	oneliner,
        'detail': detail,
        'size': size,
        'inTime': inTime,
        'outTime': outTime,
        'isPark': isPark,
        'mapUrl': mapUrl,
        'reviewNum':reviewNum,
        'reviewRate':reviewRate,
    })
    print(data[-1])
    # except:
    #   print("err")

  df = pd.DataFrame(data)
  df = df.set_index("id")
  print(df)
  df.to_csv(f'./DB/hotel_부산_{num:05d}.csv')
  return df

def dongScroll():
  global num
  data = pd.DataFrame()
  options = webdriver.ChromeOptions()
  # options.add_argument("headless")
  options.add_argument('window-size=1920x1080') 
  driver = webdriver.Chrome(options)
  for i in range(12):
    url = f"https://korean.visitkorea.or.kr/list/travelinfo.do?service=ms#ms^0^6^All^b7023aff-8138-4a00-ae7f-e4fe7b13a61b^{i+1}^^1^#%EC%88%99%EB%B0%95"
    driver.get(url)
    driver.refresh()
    time.sleep(2)
    data = pd.concat([data, pageScroll(driver)])
  data.to_csv(f'./DB/hotel_부산.csv')
  driver.quit()
dongScroll()
