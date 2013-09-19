require 'rubygems'
require 'nokogiri'
require 'open-uri'

BASE_URL = 'http://avaxhome.ws'
PAGE_COUNT =731

# 1 to 731
# preface: 1 -> 16
# intro 17 -> 26
# present_value 27-> 54
# stock_and_bond -> 55 -> 74
# budgeting -> 75 -> 98
# time_varying_rates 99 -> 130
#uncertainity_default_risk = 131 -> 166
#first_look_at_investment => 177 -> 192
# investor_choice_risk_reward => 193 -> 222
# capital_asset_pricing_model => 223 -. 258
# market_imperfections => 259 -> 298
# perfect_efficient_market => 299 -> 322
# capital_budgeting_pitfalls => 323 -> 384
# financial_statement_to_cash_flow -> 385 -> 428
# valuation_from_comparables => 429 -> 476
# corporate_claims => 477 -> 506
# capital_structure_in_perfect_market => 507 -> 538
# tax_and_capital_structure => 539 -> 584
# more_imperfect_capital_structure => 585 -> 626
# equity_payouts => 627 -> 656
# pro_forma_fin_statement =>  657- 700
# epilogue  701 - 710
# math appendix =>  711-731

chapter_array = [
    [ "1_preface", 1, 16],
    [ "2_intro", 17, 26],
    [ "3_present_value", 27, 54],
    [ "4_stock_and_bond", 55, 74],
    [ "5_budgeting", 75, 98],
    [ "6_time_varying_rates", 99 , 130],
    [ "7_uncertainity_default_risk", 131, 166],
    [ "8_first_look_at_investment", 177, 192],
    [ "9_investor_choice_risk_reward", 193, 222],
    [ "10_capital_asset_pricing_model", 223, 258],
    [ "11_market_imperfections", 259, 298],
    [ "12_perfect_efficient_market", 299, 322],
    [ "13_capital_budgeting_pitfalls", 323, 384],
    [ "14_financial_statement_to_cashflow", 385, 428],
    [ "15_valuation_from_comparables", 429, 476],
    [ "16_corporate_claims", 477, 506],
    [ "17_capital_structure_in_perfect_market", 507, 538],
    [ "18_tax_and_capital_structure", 539, 584],
    [ "19_more_imperfect_capital_structure", 585, 626],
    [ "20_equity_payouts", 627, 656],
    [ "21_pro_forma_fin_statement", 547, 700],
    [ "21_epilogue", 701, 710],
    [ "22_math_appendix", 711,731]
  ]

chapter_array.each do |chapter|
  dir_name = chapter[0]
  new_dir_location = "./download/#{dir_name}"
  Dir.mkdir new_dir_location
end
  

chapter_array.each do |chapter|
  dir_name = chapter[0]
  first_page = chapter[1]
  last_page = chapter[2]
  
  (first_page..last_page).each do |page_number|
    url = "http://book.ivo-welch.info/fcgi-bin/ed2b.fpl?PPage#{page_number}"
    page = Nokogiri::HTML(open(  url     ))  
    result = page.css("img")
    first_result = result.first
    
    new_dir_location = "./download/#{dir_name}"
    # Dir.mkdir new_dir_location
    
    image_url = first_result.attributes['src'].value
    if not image_url.nil?
      `wget -P '#{new_dir_location}' -O '#{new_dir_location}/#{page_number}' '#{image_url}' `
    end
  end
end

# 
# page = Nokogiri::HTML(open(  url     ))  
# result = page.css("img")
# first_result = result.first 
# 
# # new_dir = title.gsub(/\s+/,'')
# # new_dir_location = "#{Rails.root}/app/assets/imagess/download/#{new_dir}"
# new_dir_location = "./download"
# page_number = 731
# 
# 
# image_url = first_result.attributes['src'].value
# `wget -P '#{new_dir_location}' -O '#{new_dir_location}/#{page_number}' '#{image_url}' `
# 
# Dir.mkdir new_dir_location
# 
# self.pages.each do |page|
#   `wget -P '#{new_dir_location}' -O '#{new_dir_location}/#{page_number}' '#{image_url}' `
#   page.local_image_url =  "download/#{new_dir}/#{page.page_number}"    
#   page.save
# end
# 
# 
# 
# (1..PAGE_COUNT).each do |page_count|
#   page = Nokogiri::HTML(open(  url     ))  
# 
#   results = page.css("div.news h1 a")
#   results.each do |result|
#     title = result.text
#     link  = "#{BASE_URL}#{result.attributes['href'].value}"
#     file_content  << "#{counter}.  #{title}\r\n" 
#     file_content << "#{link}\r\n\r\n"
# 
#     counter += 1 
#   end
#   
#   next_page = page.css("a.next_page").first 
#   break if next_page.nil?
#   url = "#{BASE_URL}#{next_page.attributes['href'].value}" 
# end
# 
# File.open( FILENAME , 'w') {|f| f.write(file_content) }