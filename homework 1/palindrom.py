print("Palinddrom bulucuya hoş geldiniz")
sayi=str(input("Lütfen bir sayı  giriniz: "))
sayi2=sayi[::-1]
if(sayi==sayi2):
    print("Girdiğiniz sayı polindromdur.")
else:
    print("Girdiğiniz sayı polindrom değildir.")
