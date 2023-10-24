maas= float(input("Lütfen maaşınızı giriniz:"))
zamOrani= float(input("Lütfen zam oranını  yüzdesel olarak giriniz:"))

zamliMaas=maas*((100+zamOrani)/100)
print("Yeni maaşınız:"+str(zamliMaas))