"""1- İlk iki elemanı 1'e eşit olan, en az 20 elemanlı 
bir fibonacci serisini liste halinde oluşturan döngü yazalım."""
# 1 1 2 3 5 8 13 21 34
fibanocciSeri =[1,1]
sayi=1
sonrakiSAyi=1
#for i in range(18):

while len(fibanocciSeri)<20:
    yeniSayi= fibanocciSeri[-1]+fibanocciSeri[-2]
    fibanocciSeri.append(yeniSayi)
print(fibanocciSeri)

