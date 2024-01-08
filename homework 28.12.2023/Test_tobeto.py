from selenium import webdriver
from selenium.webdriver.common.by import By
from webdriver_manager.chrome import ChromeDriverManager
from time import sleep
from selenium.webdriver.support.wait import WebDriverWait #ilgili driverı bekleten yapı
from selenium.webdriver.support import expected_conditions as ec #beklenen koşullar
import pytest

class Test_tobeto:
    def setup_method(self): #her test başlangıcında çalışacak fonk
        self.driver = webdriver.Chrome()
        self.driver.get("https://tobeto.com/giris")
        self.driver.maximize_window()

    def teardown_method(self): # her testinin bitiminde çalışacak fonk
        self.driver.quit()

    
    def test_usernameRequired(self):
        usernameInput = WebDriverWait(self.driver,5).until(ec.visibility_of_element_located((By.NAME,"email")))
        usernameInput.send_keys("")
        passwordInput = WebDriverWait(self.driver,5).until(ec.visibility_of_element_located((By.NAME,"password")))
        passwordInput.send_keys("")
        loginButton = self.driver.find_element(By.XPATH,"//*[@id='__next']/div/main/section/div/div/div[1]/div/form/button")
        loginButton.click() 
        errorMessage = self.driver.find_element(By.XPATH,"//*[@id='__next']/div/main/section/div/div/div[1]/div/form/p[1]")
        assert errorMessage.text == "Doldurulması zorunlu alan*"

    
        