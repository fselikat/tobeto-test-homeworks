sayi1=int(input("Lütfen bir sayı giriniz: "))
sayi2=int(input("Lütfen bir sayı giriniz: "))
sayi3=int(input("Lütfen bir sayı giriniz: "))
if(sayi1>=sayi2):
    if(sayi1>=sayi3):
        print("En büyük sayı: "+ str(sayi1))
elif(sayi2>=sayi3):
    if(sayi2>=sayi1):
        print("En büyük sayı: "+ str(sayi2))
else:
    print("En büyük sayı: "+ str(sayi3))