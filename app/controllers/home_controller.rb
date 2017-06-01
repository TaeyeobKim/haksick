class HomeController < ApplicationController
  require 'nokogiri'
  require 'open-uri'
  def index
    @mon = Haksick.where(day: "월").last
    @tue = Haksick.where(day: "화").last
    @wed = Haksick.where(day: "수").last
    @thu = Haksick.where(day: "목").last
    @fri = Haksick.where(day: "금").last
    @sat = Haksick.where(day: "토").last
  end
  def get_bob
    doc = Nokogiri::HTML(open("https://www.korea.ac.kr/user/restaurantMenuAllList.do?siteId=university&id=university_050402000000"))
    for i in [3,5,7,9,11,13]
      bob = Haksick.new
      if i==11 || i==13
        day = doc.css(".ku_restaurant//ul//li:nth-child(1)//ol:nth-child(#{i})//span.day").inner_text
        bob.day = day
        date = doc.css(".ku_restaurant//ul//li:nth-child(1)//ol:nth-child(#{i})//span.date//span")[0].inner_text + "/" + doc.css(".ku_restaurant//ul//li:nth-child(1)//ol:nth-child(#{i})//span.date//span")[1].inner_text
        bob.date = date
        breakfast_c = doc.css(".ku_restaurant//ul//li:nth-child(1)//ol:nth-child(#{i})//li//p.menulist//span")[0].inner_text.split("-")[1]
        bob.breakfast_c = breakfast_c
        lunch = doc.css(".ku_restaurant//ul//li:nth-child(1)//ol:nth-child(#{i})//li//div:nth-child(5)")[0].inner_text.split("-")[1]
        bob.lunch = lunch
        dinner = doc.css(".ku_restaurant//ul//li:nth-child(1)//ol:nth-child(#{i})//li//div:nth-child(5)")[0].inner_text.split("-")[1]
        bob.dinner = dinner
      else
        day = doc.css(".ku_restaurant//ul//li:nth-child(1)//ol:nth-child(#{i})//span.day").inner_text
        bob.day = day
        date = doc.css(".ku_restaurant//ul//li:nth-child(1)//ol:nth-child(#{i})//li//span.date//span")[0].inner_text + "/" + doc.css(".ku_restaurant//ul//li:nth-child(1)//ol:nth-child(#{i})//li//span.date//span")[1].inner_text
        bob.date = date
        breakfast_a = doc.css(".ku_restaurant//ul//li:nth-child(1)//ol:nth-child(#{i})//li//p.menulist")[0].inner_text.split("-")[1]
        bob.breakfast_a = breakfast_a
        breakfast_b = doc.css(".ku_restaurant//ul//li:nth-child(1)//ol:nth-child(#{i})//li//div:nth-child(4)")[0].inner_text.split("-")[1]
        bob.breakfast_b = breakfast_b
        lunch = doc.css(".ku_restaurant//ul//li:nth-child(1)//ol:nth-child(#{i})//li//div:nth-child(5)")[0].inner_text.split("-")[1]
        bob.lunch = lunch
        dinner = doc.css(".ku_restaurant//ul//li:nth-child(1)//ol:nth-child(3)//li//div:nth-child(6)")[0].inner_text.split("-")[1]
        bob.dinner = dinner
      end
      bob.save end
      redirect_to "/"
    end
end
