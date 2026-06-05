// Veškerý herní obsah na jednom místě, ať se dá snadno rozšiřovat.
// Vše česky, s vodáckým nádechem. Klidně přidávej další položky.

/// „Kdo z nás nejspíš…" – ukaž prstem na viníka.
const List<String> mostLikely = [
  'Kdo nejspíš spadne první z lodi?',
  'Kdo nejspíš zapomene pádlo v hospodě?',
  'Kdo nejspíš usne první u ohně?',
  'Kdo nejspíš ráno nenajde svůj stan?',
  'Kdo nejspíš převrhne loď na klidné vodě?',
  'Kdo nejspíš začne zpívat trampské písně?',
  'Kdo nejspíš sní cizí svačinu?',
  'Kdo nejspíš si zabalí úplně zbytečnou věc?',
  'Kdo nejspíš ztratí mobil ve vodě?',
  'Kdo nejspíš bude mít nejvíc komářích štípanců?',
  'Kdo nejspíš přivede partu na špatné tábořiště?',
  'Kdo nejspíš odmítne vlézt do studené vody?',
  'Kdo nejspíš vypije poslední pivo a nepřizná se?',
  'Kdo nejspíš dostane ráno nejhorší kocovinu?',
  'Kdo nejspíš se vrhne po hlavě do jezu?',
  'Kdo nejspíš zapálí oheň na první sirku?',
  'Kdo nejspíš si vezme na vodu úplně nevhodné boty?',
  'Kdo nejspíš bude celou cestu komentovat počasí?',
  'Kdo nejspíš se nejvíc spálí od sluníčka?',
  'Kdo nejspíš tajně doma trénoval pádlování?',
  'Kdo nejspíš by přežil týden sám v divočině?',
  'Kdo nejspíš pošle uprostřed výletu pracovní e-mail?',
  'Kdo nejspíš donese na vodu nejvíc jídla?',
  'Kdo nejspíš se zamiluje do někoho z jiné posádky?',
  'Kdo nejspíš začne velet celé flotile?',
];

/// „Pravda nebo úkol" – rozdělené podle pálivosti.
class DareCard {
  const DareCard(this.text, this.isDare);
  final String text;
  final bool isDare; // true = úkol, false = pravda
}

/// Mírná úroveň – pro pohodu u ohně.
const List<DareCard> dareMild = [
  DareCard('Jaký byl tvůj nejtrapnější moment na dnešním výletě?', false),
  DareCard('Co sis zapomněl(a) doma a nejvíc ti chybí?', false),
  DareCard('Koho z party by sis vzal(a) na pustý ostrov?', false),
  DareCard('Jaké je tvoje nejhorší jídlo z konzervy?', false),
  DareCard('Předveď, jak vypadáš ráno po probuzení ve stanu.', true),
  DareCard('Zazpívej refrén písničky, kterou máš spojenou s létem.', true),
  DareCard('Udělej co nejlepší imitaci někoho z party.', true),
  DareCard('Pověz vtip tak, aby se aspoň jeden člověk zasmál.', true),
  DareCard('Co je tvůj nejtrapnější zážitek z dětského tábora?', false),
  DareCard('Předveď pantomimou, jak nasedáš do lodi.', true),
  DareCard('Komu z party bys nejvíc věřil(a) s tajemstvím?', false),
  DareCard('Udělej 10 dřepů a u toho počítej nahlas vodácky.', true),
];

/// Ostřejší úroveň – večer, mezi dospělými.
const List<DareCard> dareSpicy = [
  DareCard('Komu z přítomných by ses nejradši svěřil(a) s tajemstvím?', false),
  DareCard('Co je největší blbost, kterou jsi kdy udělal(a) opilý(á)?', false),
  DareCard('Kdy naposledy ses do někoho potají zakoukal(a)?', false),
  DareCard('Vyměň si na 3 kola tričko se sousedem po pravici.', true),
  DareCard('Zavolej náhodnému kontaktu a popřej mu hezký den.', true),
  DareCard('Nech souseda napsat status na tvůj telefon.', true),
  DareCard('Řekni upřímný kompliment každému v kruhu.', true),
  DareCard('Jaká je tvoje nejtrapnější randevú historka?', false),
  DareCard('Předveď svůj nejlepší taneční pohyb bez hudby.', true),
  DareCard('Co bys nikdy nepřiznal(a) rodičům o tomhle výletě?', false),
  DareCard('Nech partu vybrat ti přezdívku na zbytek večera.', true),
  DareCard('Komu z party bys dal(a) na škále 1–10 nejvíc bodů a proč?', false),
];

/// Vodácký kvíz.
class QuizQuestion {
  const QuizQuestion(this.question, this.options, this.correctIndex);
  final String question;
  final List<String> options;
  final int correctIndex;
}

const List<QuizQuestion> quiz = [
  QuizQuestion(
    'Jak se říká člověku, který sedí vzadu a řídí kánoi?',
    ['Hák', 'Háček', 'Zadák', 'Kapitán'],
    2,
  ),
  QuizQuestion(
    'A kdo sedí vepředu?',
    ['Zadák', 'Háček', 'Plavčík', 'První důstojník'],
    1,
  ),
  QuizQuestion(
    'Která řeka je nejoblíbenější česká vodácká řeka pro začátečníky?',
    ['Vltava', 'Labe', 'Morava', 'Ohře'],
    0,
  ),
  QuizQuestion(
    'Co znamená na vodě „nahul" / „houkni"?',
    ['Začni pádlovat', 'Zastav', 'Pozor, jez!', 'Signál ostatním lodím'],
    3,
  ),
  QuizQuestion(
    'Jak se jmenuje umělá vodácká stavba ke sjíždění?',
    ['Splav', 'Propust', 'Jez', 'Vorová propust'],
    1,
  ),
  QuizQuestion(
    'Co bys NIKDY neměl(a) dělat při převrácení lodi v proudu?',
    [
      'Držet se po proudu nohama napřed',
      'Postavit se na dno v proudu',
      'Plavat ke břehu',
      'Držet se lodi',
    ],
    1,
  ),
  QuizQuestion(
    'Co je to „eskymák" / „eskymácký obrat"?',
    [
      'Typ stanu',
      'Otočení převrácené lodi zpět bez vylezení',
      'Vodácký pozdrav',
      'Druh pádla',
    ],
    1,
  ),
  QuizQuestion(
    'Jak se nazývá místo, kde se z řeky vystupuje a obchází překážka?',
    ['Přenáška', 'Vývařiště', 'Peřej', 'Tlama'],
    0,
  ),
  QuizQuestion(
    'Co znamená nebezpečný „válec" pod jezem?',
    [
      'Místo na opalování',
      'Zpětný proud, který drží předměty u dna',
      'Druh kánoe',
      'Mělčina',
    ],
    1,
  ),
  QuizQuestion(
    'Co patří mezi povinnou výbavu na vodě?',
    ['Slunečník', 'Plovací vesta', 'Gril', 'Foťák'],
    1,
  ),
  QuizQuestion(
    'Jak se říká vlnám stojícím za peřejí?',
    ['Stojaté vlny', 'Brzdné vlny', 'Vratné vlny', 'Pěny'],
    0,
  ),
  QuizQuestion(
    'Co je „bahňák"?',
    [
      'Místo pro táboření',
      'Vodák, který nerad opouští hospodu',
      'Bahnité dno u břehu',
      'Druh ryby',
    ],
    2,
  ),
];

/// „Aktivity" – slova k předvádění/popisování, rozdělená podle kategorie.
class CharadesCategory {
  const CharadesCategory(this.name, this.words);
  final String name;
  final List<String> words;
}

const List<CharadesCategory> charadesCategories = [
  CharadesCategory('Voda a tábor', [
    'pádlo', 'stan', 'spacák', 'oheň', 'kotlík', 'jez', 'kánoe', 'vesta',
    'mapa', 'buřt', 'komár', 'déšť', 'záchod v lese', 'mokré boty',
    'opalovací krém', 'čelovka', 'řeka', 'most', 'tábořák', 'kytara',
    'hospoda', 'pivo', 'kemp', 'sluníčko', 'vlny', 'mlha', 'soutok',
  ]),
  CharadesCategory('Filmy a seriály', [
    'Titanic', 'Piráti z Karibiku', 'Vykoupení z věznice Shawshank',
    'Pán prstenů', 'Sám doma', 'Pelíšky', 'Vrchní, prchni!', 'Jaws',
    'Forrest Gump', 'Hra o trůny', 'Přátelé', 'Hvězdné války',
    'Mrazík', 'Slunce, seno, jahody', 'Avatar',
  ]),
  CharadesCategory('Zvířata', [
    'štika', 'volavka', 'bobr', 'rak', 'kapr', 'labuť', 'žába', 'liška',
    'medvěd', 'klíště', 'pavouk', 'jelen', 'sova', 'vážka', 'kachna',
    'racek', 'had', 'ježek', 'netopýr', 'kuna',
  ]),
  CharadesCategory('Akce a sloveso', [
    'pádlovat', 'plavat', 'stanovat', 'zpívat', 'vařit', 'spát',
    'tahat loď', 'nadávat', 'fotit', 'opékat', 'veslovat', 'topit se',
    'sušit věci', 'balit batoh', 'rozdělávat oheň', 'chrápat',
    'klepat se zimou', 'tancovat',
  ]),
];

/// „Kdo jsem?" – balíčky slov, která se ti zobrazí na čele.
const Map<String, List<String>> headsUpDecks = {
  'Vodácké': [
    'pádlo', 'jez', 'kánoe', 'pramice', 'vesta', 'helma', 'splav',
    'eskymák', 'háček', 'zadák', 'přenáška', 'peřej', 'kotlík', 'stan',
    'spacák', 'čelovka', 'komár', 'klíště', 'kemp', 'oheň', 'buřt',
    'řeka', 'most', 'vlny', 'válec', 'mapa', 'plavky', 'mokré boty',
  ],
  'Celebrity': [
    'Karel Gott', 'Lucie Bílá', 'Jaromír Jágr', 'Ester Ledecká',
    'Leoš Mareš', 'Marek Eben', 'Patrik Hartl', 'Tomio Okamura',
    'Albert Einstein', 'Lady Gaga', 'Leonardo DiCaprio', 'Beyoncé',
    'Cristiano Ronaldo', 'Elon Musk', 'Václav Havel', 'Mona Lisa',
  ],
  'Zvířata': [
    'slon', 'tučňák', 'krokodýl', 'žirafa', 'ježek', 'bobr', 'velbloud',
    'tučňák', 'klokan', 'sova', 'medvěd', 'žába', 'štika', 'labuť',
    'kobra', 'chobotnice', 'liška', 'netopýr', 'mravenec', 'velryba',
  ],
  'Filmy': [
    'Titanic', 'Avatar', 'Pelíšky', 'Mrazík', 'Sám doma', 'Matrix',
    'Pán prstenů', 'Piráti z Karibiku', 'Forrest Gump', 'Jurský park',
    'Vetřelec', 'Pulp Fiction', 'Shrek', 'Frozen', 'Rocky',
  ],
  'Profese': [
    'pilot', 'kuchař', 'učitel', 'hasič', 'lékař', 'instalatér',
    'programátor', 'zpěvák', 'kapitán lodi', 'fotograf', 'horník',
    'pekař', 'záchranář', 'zahradník', 'řezník', 'vědec',
  ],
};
