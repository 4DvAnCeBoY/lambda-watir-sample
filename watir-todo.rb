require 'watir'
require 'selenium-webdriver'
require "test-unit"



class LAMBDA_Example < Test::Unit::TestCase
	def test_todos
		begin
			username = 'asad360logica'
		authkey = '4b140c78-2f70-4e2b-a733-e556e02ecde9'
			
			caps = Selenium::WebDriver::Remote::Capabilities.new

			caps["name"] = "Lambda Watir Example"
			caps["build"] = "1.0"
			caps["browserName"] = "Firefox" 	# Pulls latest version by default
			caps["platform"] = "Windows 7"		# To specify a version, add caps["version"] = "desired version"
			caps["screen_resolution"] = "1024x768"
			caps["record_video"] = "true"
			caps["record_network"] = "true"

			browser = Watir::Browser.new(
				:remote,
				:url => "https://#{username}:#{authkey}@ondemand.saucelabs.com:443/wd/hub",
				:desired_capabilities => caps) 

			session_id = browser.driver.session_id

		    
		    # maximize the window - DESKTOPS ONLY
		    # driver.manage.window.maximize
		    puts "Loading URL"
		    browser.goto ("https://4dvanceboy.github.io/lambdatest/todo.html")

		    puts "Clicking Checkbox"
		    # driver.find_element(:name, "todo-4").click
		    browser.checkbox(:name, "todo-4").set
		    puts "Clicking Checkbox"
		    # driver.find_element(:name, "todo-5").click
		    browser.checkbox(:name, "todo-5").set

		    # elems = driver.find_elements(:class, "done-true")
		    elems = browser.elements(:class, "done-true")
		    assert_equal(2, elems.length)

		    puts "Entering Text"
		    browser.text_field(:id => 'todotext').set("Get Taste of Lambda and Stick to It")
		    # driver.find_element(:id, "todotext").send_keys("run your first selenium test")
		    browser.element(:id, 'addbutton').click
		    # driver.find_element(:id, "addbutton").click

		    # spanText = driver.find_element(:xpath, "/html/body/div/div/div/ul/li[6]/span").text
		    spanText = browser.element(:xpath, "/html/body/div/div/div/ul/li[6]/span").text
		    assert_equal("Get Taste of Lambda and Stick to It", spanText, "Error in adding list item")

		    
		    puts "Taking Snapshot"
		    rescue Exception => ex
		    puts ("#{ex.class}: #{ex.message}")
		    
		ensure     
		    # driver.quit
		    browser.close
		end
	end
end
