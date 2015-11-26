require 'watir-webdriver'
require_relative 'read_excel'
require_relative 'login'
require_relative 'create_new_user'
require_relative 'reset_password'

user = get_user_data
info = get_file_spec('../test_data/info.txt')

case info["browser"]
when 'chrome' then @browser = Watir::Browser.new :chrome
when 'ie' then @browser = Watir::Browser.new :ie
else @browser = Watir::Browser.new
end

@browser.goto info["URI"]
@log = File.new('../test_report/log.txt','w')

user.length.times do |num|

next unless login(loginName: info["loginName"], password: info["password"], providerCode: info["provideCode"])

@browser.span(:text => 'User').parent.parent.link(:text => 'New').click


@log.write Time.now

@log.write " loginName: #{info["loginName"]} " 

flag = create_new_user(user[num])
if num != user.length-1
@browser.link(:text => 'Logout').click
@browser.link(:text => 'Login Again').click
end
if flag
  @browser.link(:text => 'Logout').click
  @browser.link(:text => 'Login Again').click
  login(get_loginName(user[num]),get_password(user[num]),info["providerCode"])
  reset_password(get_password(user[num]),'therap','therap')
  
end

@log.write "\n"
end
@browser.close
@log.close