# Vastum

Vastum to aplikacja ułatwiająca użytkownikowi segregowanie odpadów.

- Pomaga segregować odpady
- Występuje w wersji przeglądarkowej i mobilnej
- Jest prosta w obsłudze 
## Cechy aplikacji

- Automatyczne wyszukanie odpowiedniego typu odpadu zaraz po wpisaniu
- Rozpoznawanie odpadu przy użyciu zdjęcia
- Model uczenia maszynowego oparty o zbiór danych [TrashNet](https://github.com/garythung/trashnet)

## Użyte technologie

W projekcie posłużyliśmy się następującymi technologiami:

- [Flutter](https://flutter.dev) - Tworzenie aplikacji mobilnej jednocześnie na platforme iOS i Android
- [Teachable Machine](https://teachablemachine.withgoogle.com) - Tworzenie modelu klasyfikacji obrazów
- [Tensorflow](https://www.tensorflow.org) - Zaimplementowanie modelu w aplikacji mobilnej
- [Laravel](https://laravel.com/) - Tworzenie w pełni aplikacji internetowej

Aplikacja działa na podstawie bazy danych zaczerpniętej z [https://api.um.warszawa.pl](https://api.um.warszawa.pl)

### Zrzuty ekranu
Zrzuty ekranu znajdują się w odpowiednich podfolderach Web i Mobile

## Licencja

MIT
