"""3- Kullanıcıdan girilen sayının EBOB ve EKOK'unu bulan programı yazınız."""

sayi1= int(input("1. sayıyı giriniz: "))
sayi2= int(input("2. sayıyı giriniz: "))
def ebobEkokBul(sayi1,sayi2):
    if sayi1>=sayi2:
        kucukSayi=sayi2
    else:
        kucukSayi=sayi1
    for i in range(1,kucukSayi+1):
        if(sayi1%i==0 & sayi2%i==0):
            ebob=i
    print("EBOB: ", ebob)
    ekok=(sayi1*sayi2)//ebob
    print("EKOK: ", ekok)
ebobEkokBul(sayi1,sayi2)

