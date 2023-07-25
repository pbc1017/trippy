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
    name = element.find_element(By.CSS_SELECTOR, 'div.tit a').text
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
      operating= tmp['이용시간']
      dayoff = tmp['휴일']
    except:
      operating = ""
      dayoff = ""

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

    driver.close()  
    driver.switch_to.window(driver.window_handles[0])
    
    num += 1
    
    # 원소에 대한 정보를 리스트에 추가합니다.
    data.append({
        'id': f"travel_부산_{num:05d}",
        'name': name,
        'type': "",
        'price': "",
        'time': operating,
        'dayoff':	dayoff,
        'address': address,	
        'location': location,
        'img': img,	
        'call': call,	
        'url': detail_url,
        'homepage':	homepage,
        'oneliner':	oneliner,
        'detail': detail,
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
  df.to_csv(f'./DB/travel_부산_{num:05d}.csv')
  return df

def dongScroll():
  global num
  data = pd.DataFrame()
  options = webdriver.ChromeOptions()
  # options.add_argument("headless")
  options.add_argument('window-size=1920x1080') 
  driver = webdriver.Chrome(options)
  for i in range(47):
    url = f"https://korean.visitkorea.or.kr/list/travelinfo.do?service=ms#ms^0^6^All^e6875575-2cc2-43ba-9651-28d31a7b3e23,651c5b95-a5b3-11e8-8165-020027310001,d3fd4d9f-fbd4-430f-b5d5-291b4d9920be,c24d515f-3202-45e5-834e-1a091901aeff,23bc02b8-da01-41bf-8118-af882436cd3c,3f36ca4b-6f45-45cb-9042-265c96a4868c,2d4f4e06-2d37-4e54-ad5c-172add6e6680,640d3489-8fc3-11e8-8165-020027310001,9668f0f1-8afe-4526-8007-503bd02fd6d8,1601b0a3-144e-40b7-95b4-b946e537a25b,1c981ad4-7834-11e8-82c8-020027310001,266bf7a0-cbab-4bb4-b800-d7edd5642180^{i+1}^^1^#%EB%A0%88%ED%8F%AC%EC%B8%A0#%EB%AC%B8%ED%99%94%EC%8B%9C%EC%84%A4#%EC%97%AD%EC%82%AC#%EC%9E%90%EC%97%B0#%EC%B2%B4%ED%97%98#%EA%B4%80%EA%B4%91%EC%A7%80#%EC%8B%A4%EB%82%B4%EC%97%AC%ED%96%89%EC%A7%80#%ED%8A%B8%EB%A0%88%ED%82%B9#%EC%9D%B4%EC%83%89%EC%B2%B4%ED%97%98#%EB%93%9C%EB%9D%BC%EC%9D%B4%EB%B8%8C%EC%BD%94%EC%8A%A4#%EB%B4%84%EA%BD%83%EB%82%98%EB%93%A4%EC%9D%B4#%EB%B4%84%EB%82%98%EB%93%A4%EC%9D%B4"
    driver.get(url)
    driver.refresh()
    time.sleep(2)
    data = pd.concat([data, pageScroll(driver)])
  data.to_csv(f'./DB/travel_부산.csv')
  driver.quit()
dongScroll()
