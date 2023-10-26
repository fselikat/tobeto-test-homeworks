"""4- Kullanıcıdan girilen sayının asal sayı olup olmadığını söyleyen bir program yazınız."""

sayi= int(input("Lütfen bir sayı giriniz: "))
def asalSayıBul(sayi):
    asalMi=True
    if sayi<=1:
        print("Sayı asal değildir")
    elif sayi==2:
        print("Girdiğiniz sayı asaldır.")
    else:
        for i in range(2,sayi):
            if sayi%i==0:
                print("Sayı asal değildir")
                asalMi=False
                break
        if asalMi==True:
            print("Girdiğiniz sayı asaldır.")
            
asalSayıBul(sayi)
