# PyTest Decorators
## Decorator nedir?
Decoratorlar, Python'da fonksiyonların davranışını genişletmek veya değiştirmek için kullanılan bir tasarım kalıbıdır(design pattern). Pytest gibi test frameworkleri, decoratorları test fonksiyonları üzerinde kullanarak testlerin davranışını özelleştirebilemizi sağlıyor.

Pytest'te yaygın olarak kullanılan decorator'lar şunlardır:

### @pytest.fixture:
Bu decorator, bir test fonksiyonuna bağlı olarak çalışan ve test durumunu paylaşan bir fixture tanımlar. Bu, testler arasında durumun paylaşılmasını ve tekrar kullanılabilirliği sağlar.

`import pytest`

`@pytest.fixture`
`def my_fixture():`
`    return "Hello, Pytest!"`

`def test_using_fixture(my_fixture):`
`    assert my_fixture == "Hello, Pytest!"`

### @pytest.mark:
@pytest.mark decorator'ı, testlere özel etiketler eklememizi sağlar. Bu etiketleri kullanarak belirli testleri seçebilir veya hariç tutabiliriz.


`import pytest`

`@pytest.mark.smoke`
`def test_smoke():`
`    assert True`

`@pytest.mark.slow`
`def test_slow():`
`    assert True`
Ardından, terminalde belirli etiketlere sahip testleri çalıştırmak için şu komutu kullanabilirsiniz:

`pytest -m smoke`

### @pytest.mark.parametrize:
Parametrize decorator'ı, aynı test fonksiyonunu farklı parametrelerle çalıştırmamızı sağlıyor. Bu, birbirinden farklı durumları test etmemiz açısından  kullanışlı oluyor.


`import pytest`

`@pytest.mark.parametrize("input, expected", [(1, 2), (2, 4), (3, 6)]) `
`def test_multiply_by_two(input, expected):`
`   result = input * 2`
`   assert result == expected `

 Bu decorator'lar, testlerimizi daha güçlü, esnek, temiz ve okunabilir hale getirmenize (clean code) yardımcı olur.