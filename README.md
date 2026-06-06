# 🔥 Vodácké Hry

Mobilní (Android + iOS) sbírka společenských her na večer u ohně na vodáckém
výletě. Navržené tak, aby šly hrát **s jedním telefonem, potmě a bez učení
pravidel** — velká písmena, tmavé téma, vše česky.

## Hry v krabici

| Hra | Princip |
| --- | --- |
| **Kdo jsem?** | Telefon na čelo, ostatní popisují slovo. Sklopení dolů = uhodl, zaklonění = další. Ovládá se nakláněním (akcelerometr), hraje se naležato. |
| **Kdo z nás nejspíš…** | Telefon ukáže otázku, všichni na „tři" ukážou prstem na viníka. |
| **Pravda nebo úkol** | Karty s pravdami a úkoly, přepínatelná úroveň pálivosti (pohoda / pikantní). |
| **Aktivity** | Předváděj/popisuj slova na čas. Výběr kategorií a délky kola, počítání bodů. |
| **Vodácký kvíz** | Otázky o pádlování, řekách a táboření s vyhodnocením. |

### 🍺 Párty režim (jen pro dospělé)

Přepínač **Párty režim** v menu zapne pijácké prvky:

| Hra | Princip |
| --- | --- |
| **Nikdy jsem** | Kdo to udělal, pije. Pohodová i pikantní úroveň. |
| **Pij když…** | Karty s pravidly, podle kterých se naráz pije. |
| **Kostka osudu** | Hod rozhodne, kdo a kolik si přihne. |

Navíc do klasických her přidá pití jako sázku (špatná odpověď v kvízu = napiješ se,
odmítnutý úkol = pij apod.). **Pijte s rozumem a nikdy ne na vodě** — alkohol
a voda jsou nebezpečná kombinace.

## Spuštění

```bash
flutter pub get
flutter run        # na připojeném zařízení / emulátoru
```

Build instalačních balíčků:

```bash
flutter build apk            # Android
flutter build ios            # iOS (vyžaduje Xcode + podpis)
```

## Struktura projektu

```
lib/
  main.dart                 # vstupní bod, téma, orientace
  theme.dart                # tmavé „u ohně" téma + ohnivé pozadí
  models/game.dart          # popis hry pro menu
  state/party_mode.dart     # globální přepínač párty režimu
  data/content.dart         # VEŠKERÝ obsah her (otázky, slova, úkoly)
  widgets/party_banner.dart # pruh s pijáckým pravidlem (jen v párty režimu)
  screens/
    home_screen.dart        # hlavní menu (herní krabice)
    heads_up_screen.dart    # Kdo jsem?
    most_likely_screen.dart # Kdo z nás nejspíš…
    truth_or_dare_screen.dart
    charades_screen.dart    # Aktivity
    quiz_screen.dart        # Vodácký kvíz
    never_have_i_ever_screen.dart # Nikdy jsem 🍺
    drink_rules_screen.dart # Pij když… 🍺
    dice_screen.dart        # Kostka osudu 🍺
```

## Jak přidat vlastní obsah

Stačí editovat `lib/data/content.dart` — všechny seznamy (otázky, slova,
úkoly, balíčky) jsou tam pohromadě a okomentované. Nová minihra = nový soubor
ve `screens/` + jeden záznam `GameInfo` v `home_screen.dart`.

## Závislosti

- [`sensors_plus`](https://pub.dev/packages/sensors_plus) — naklánění telefonu ve hře Kdo jsem?
- [`wakelock_plus`](https://pub.dev/packages/wakelock_plus) — drží obrazovku rozsvícenou během hry
