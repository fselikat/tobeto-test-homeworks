"""2- Kullanıcıdan aldığı sayının mükemmel olup olmadığını söyleyen 
bir program yazınız.(Arş. Mükemmel sayı?)"""

sayi=int(input("Lütfen bir sayı giriniz: "))

toplam=0
for i in range(1,sayi):
    if (sayi%(i))==0:
        toplam += i

if sayi==toplam:
    print("Girdiğiniz sayı mükemmel sayıdır")
else:
    print("Girdiğiniz sayı mükemmel sayı değildir.")