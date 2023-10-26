"""5- Kullanıcıdan girilen sayının asal çarpanlarını bulan bir program yazınız. """
sayi = int(input("Lütfen bir sayı giriniz: "))
def asalCarpanBul(sayi):
    asalCarpanlar=[]
    carpan=2
    while carpan<=sayi:
        if sayi%carpan==0:
            asalCarpanlar.append(carpan)
            sayi //=carpan
        else:
            carpan +=1
    return asalCarpanlar
print(asalCarpanBul(sayi))