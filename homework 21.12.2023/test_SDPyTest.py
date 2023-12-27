from selenium import webdriver
from selenium.webdriver.common.by import By
from webdriver_manager.chrome import ChromeDriverManager
from time import sleep
from selenium.webdriver.support.wait import WebDriverWait #ilgili driverı bekleten yapı
from selenium.webdriver.support import expected_conditions as ec #beklenen koşullar
import pytest

class Test_DemoClass:
    #prefix => test_ 
    def setup_method(self): #her test başlangıcında çalışacak fonk
        self.driver = webdriver.Chrome()
        self.driver.get("https://www.saucedemo.com")
        self.driver.maximize_window() 

    def teardown_method(self): # her testinin bitiminde çalışacak fonk
        self.driver.quit()

    @pytest.mark.parametrize("add,remove",[("add-to-cart-sauce-labs-backpack","remove-sauce-labs-backpack"),("add-to-cart-sauce-labs-bike-light","remove-sauce-labs-bike-light"),("add-to-cart-sauce-labs-onesie","remove-sauce-labs-onesie")])
    def test_error_user(self,add,remove):
        usernameInput = WebDriverWait(self.driver,5).until(ec.visibility_of_element_located((By.ID,"user-name")))
        usernameInput.send_keys("error_user")
        passwordInput = WebDriverWait(self.driver,5).until(ec.visibility_of_element_located((By.ID,"password")))
        passwordInput.send_keys("secret_sauce")
        loginButton = self.driver.find_element(By.ID,"login-button")
        loginButton.click()
        addToCart = WebDriverWait(self.driver,5).until(ec.visibility_of_element_located((By.ID,add)))
        addToCart.click()
        removeFromCart = WebDriverWait(self.driver,5).until(ec.visibility_of_element_located((By.ID,remove)))
        removeFromCart.click()
        assert removeFromCart.text =="Remove"



    @pytest.mark.parametrize("username,password",[("standard_user","secret_sauce"),("performance_glitch_user","secret_sauce"),("visual_user","secret_sauce")])
    def test_valid_login(self,username, password):
        usernameInput = WebDriverWait(self.driver,5).until(ec.visibility_of_element_located((By.ID,"user-name")))
        usernameInput.send_keys(username)
        passwordInput = WebDriverWait(self.driver,5).until(ec.visibility_of_element_located((By.ID,"password")))
        passwordInput.send_keys(password)
        loginButton = self.driver.find_element(By.ID,"login-button")
        loginButton.click()
        menuButton = WebDriverWait(self.driver,5).until(ec.visibility_of_element_located((By.ID,"react-burger-menu-btn")))
        menuButton.click()
        logoutLink = WebDriverWait(self.driver,5).until(ec.visibility_of_element_located((By.XPATH, "//*[@id='logout_sidebar_link']")))
        logoutLink.click()
        sleep(5)
        acceptedUsername = WebDriverWait(self.driver,5).until(ec.visibility_of_element_located((By.XPATH,"//*[@id='login_credentials']/h4")))
        assert acceptedUsername.text == "Accepted usernames are:"
        

    @pytest.mark.parametrize("add",[("add-to-cart-sauce-labs-onesie"),("add-to-cart-test.allthethings()-t-shirt-(red)"),("add-to-cart-sauce-labs-fleece-jacket")])
    def test_addToCart(self,add):
        usernameInput = WebDriverWait(self.driver,5).until(ec.visibility_of_element_located((By.ID,"user-name")))
        usernameInput.send_keys("standard_user")
        passwordInput = WebDriverWait(self.driver,5).until(ec.visibility_of_element_located((By.ID,"password")))
        passwordInput.send_keys("secret_sauce")
        loginButton = self.driver.find_element(By.ID,"login-button")
        loginButton.click()
        self.driver.execute_script("window.scrollTo(0,500)") #penceremin scrolunu aşağıya indiriyor,verdiğim koordinatlarla birlikte
        addToCart = WebDriverWait(self.driver,5).until(ec.visibility_of_element_located((By.NAME, add)))
        addToCart.click()
        cartSize =WebDriverWait(self.driver,5).until(ec.visibility_of_element_located((By.XPATH, "//*[@id='shopping_cart_container']/a/span")))
        assert cartSize.text =="1"

        
        
        

       # self.driver.execute_script("window.scrollTo(0,500)") #penceremin scrolunu aşağıya indiriyor,verdiğim koordinatlarla birlikte
        
        #remove = WebDriverWait(self.driver,5).until(ec.visibility_of_element_located((By.XPATH,"//*[@id='remove-test.allthethings()-t-shirt-(red)']")))
        #assert remove.text == "Remove"