// Veškerý herní obsah na jednom místě, ať se dá snadno rozšiřovat.
// Vše česky, s vodáckým nádechem. Klidně přidávej další položky.

/// „Kdo z nás nejspíš…" – ukaž prstem na viníka.
const List<String> mostLikely = [
  'Kdo se nejspíš první cvakne?',
  'Kdo nejspíš první usne u ohně?',
  'Kdo nejspíš ráno poblije vlastní stan?',
  'Kdo nejspíš překlopí loď i na voleji?',
  'Kdo nejspíš první pustí řezníka?',
  'Kdo nejspíš šezere cizí polívku?',
  'Kdo si nejspíš sbalí úplnou hovadinu?',
  'Kdo nejspíš utopí mobil?',
  'Kdo bude nejspíš mít nejvíc spálený záda?',
  'Kdo nejspíš ukradne flašku zelený v lokální hospodě?',
  'Kdo bude mít ráno nejhorší kocovinu?',
  'Kdo si nejspíš vezme na vodu úplně blbý boty?',
  'Kdo nejspíš doma potají trénoval pádlování?',
  'Kdo by nejspíš přežil týden sám v divočině?',
  'Kdo nejspíš uprostřed výletu pošle pracovní mail?',
  'Kdo nejspíš dotáhne na vodu nejvíc žrádla?',
];

/// „Pravda nebo úkol" – rozdělené podle pálivosti.
class DareCard {
  const DareCard(this.text, this.isDare);
  final String text;
  final bool isDare; // true = úkol, false = pravda
}

/// Mírná úroveň – pro pohodu u ohně.
const List<DareCard> dareMild = [
  DareCard('Co sis zapomněl(a) doma a teď ti to nejvíc chybí?', false),
  DareCard('Koho z party by sis vzal(a) na pustej ostrov?', false),
  DareCard('Jaký je tvoje nejhorší jídlo z konzervy?', false),
  DareCard('Předveď, jak vypadáš ráno, když se probudíš ve stanu.', true),
  DareCard('Zazpívej refrén songu, kterej ti připomíná léto.', true),
  DareCard('Co nejlíp napodob někoho z party.', true),
  DareCard('Řekni vtip tak, aby se aspoň jeden zasmál.', true),
  DareCard('Jakej je tvůj největší trapas z dětskýho tábora?', false),
  DareCard('Předveď pantomimou, jak lezeš do lodi.', true),
  DareCard('Komu z party bys nejvíc svěřil(a) tajemství?', false),
  DareCard('Dej 10 dřepů a nahlas u toho počítej.', true),
];

/// Ostřejší úroveň – večer, mezi dospělými.
const List<DareCard> dareSpicy = [
  DareCard('Komu z přítomných by ses nejradši svěřil(a)?', false),
  DareCard('Co je největší blbost, cos kdy vyvedl(a) opilý(á)?', false),
  DareCard('Vyměň si na 3 kola tričko se sousedem po pravici.', true),
  DareCard('Zavolej náhodnýmu kontaktu a popřej mu hezkej den.', true),
  DareCard('Řekni upřímnej kompliment každýmu v kruhu.', true),
  DareCard('Jaká je tvoje nejtrapnější rande historka?', false),
  DareCard('Předveď svůj nejlepší taneček bez muziky.', true),
  DareCard('Co bys o tomhle výletě nikdy nepřiznal(a) rodičům?', false),
  DareCard('Nech partu, ať ti vymyslí přezdívku na zbytek večera.', true),
  DareCard('Komu z party bys na škále 1–10 dal(a) nejvíc a proč?', false),
];

/// Vodácký kvíz.
class QuizQuestion {
  const QuizQuestion(this.question, this.options, this.correctIndex);
  final String question;
  final List<String> options;
  final int correctIndex;
}

const List<QuizQuestion> quiz = [
  QuizQuestion('Jak se říká tomu, kdo sedí vzadu a řídí kánoi?', ['Hák', 'Háček', 'Zadák', 'Kapitán'], 2),
  QuizQuestion('A kdo sedí vepředu?', ['Zadák', 'Háček', 'Plavčík', 'První důstojník'], 1),
  QuizQuestion('Která česká řeka je nejoblíbenější pro vodácký začátečníky?', ['Vltava', 'Labe', 'Morava', 'Ohře'], 0),
  QuizQuestion('Co znamená na vodě „nahul" / „houkni"?', [
    'Začni pádlovat',
    'Zastav',
    'Pozor, jez!',
    'Signál ostatním lodím',
  ], 3),
  QuizQuestion('Jak se jmenuje umělá vodácká stavba na sjíždění?', ['Splav', 'Propust', 'Jez', 'Vorová propust'], 1),
  QuizQuestion('Co bys NIKDY neměl(a) dělat, když se ti loď cvakne v proudu?', [
    'Držet se po proudu nohama napřed',
    'Postavit se na dno v proudu',
    'Plavat ke břehu',
    'Držet se lodi',
  ], 1),
  QuizQuestion('Co je to „eskymák" / „eskymácký obrat"?', [
    'Typ stanu',
    'Otočení převrácené lodi zpět bez vylezení',
    'Vodácký pozdrav',
    'Druh pádla',
  ], 1),
  QuizQuestion('Jak se říká místu, kde z řeky vylezeš a obejdeš překážku?', [
    'Přenáška',
    'Vývařiště',
    'Peřej',
    'Tlama',
  ], 0),
  QuizQuestion('Co znamená nebezpečný „válec" pod jezem?', [
    'Místo na opalování',
    'Zpětný proud, který drží předměty u dna',
    'Druh kánoe',
    'Mělčina',
  ], 1),
  QuizQuestion('Co musíš mít na vodě povinně s sebou?', ['Slunečník', 'Plovací vesta', 'Gril', 'Foťák'], 1),
  QuizQuestion('Jak se říká vlnám, co stojí za peřejí?', ['Stojaté vlny', 'Brzdné vlny', 'Vratné vlny', 'Pěny'], 0),
  QuizQuestion('Co je „bahňák"?', [
    'Místo pro táboření',
    'Vodák, který nerad opouští hospodu',
    'Bahnité dno u břehu',
    'Druh ryby',
  ], 2),
];

// ---------------------------------------------------------------------------
// PIJÁCKÉ HRY (párty režim 🍺) – obsah pro dospělé. Pijte s rozumem!
// ---------------------------------------------------------------------------

/// „Nikdy jsem…" – kdo to udělal, pije (nebo se přizná).
/// Pohodová úroveň k ohni.
const List<String> neverMild = [
  'Nikdy jsem se necvakl(a).',
  'Nikdy jsem nespal(a) pod širákem.',
  'Nikdy jsem si doma nezapomněl(a) nic důležitého na vodu.',
  'Nikdy jsem se nevykoupal(a) v oblečení.',
  'Nikdy jsem na vodě nic neutopil(a).',
  'Nikdy jsem neusnul(a) pod lodí.',
  'Nikdy jsem v noci nezabloudil(a) cestou na záchod.',
  'Nikdy jsem nepřeklopil(a) loď.',
  'Nikdy jsem nezakopl(a) o šňůru od stanu.',
  'Nikdy jsem nezapomněl(a), kde mám stan.',
  'Nikdy jsem se nedoblil(a), jak zvíře z rumu.',
  'Nikdy jsem nemíchal, tvrdej s tvrdým (a byl u toho tvrdej).',
];

/// „Nikdy jsem…" – ostřejší úroveň, večer mezi dospělými.
const List<String> neverSpicy = [
  'Nikdy jsem nelíbal(a) někoho z party.',
  'Nikdy jsem neusnul(a) opilý(á) u ohně.',
  'Nikdy jsem si nedal(a) panáka k snídani.',
  'Nikdy jsem se nevykoupal(a) nahý(á) v řece.',
  'Nikdy jsem neflirtoval(a) s někým z jiný lodi.',
  'Nikdy jsem nekecal(a) o tom, kolik jsem vypil(a).',
  'Nikdy jsem na výletě neztratil(a) kus oblečení.',
  'Nikdy jsem si nespletl(a) cizí stan se svým.',
  'Nikdy jsem neměl(a) okno z předchozího večera.',
  'Nikdy jsem se nelíbal(a) s někým, koho jsem ten den teprve poznal(a).',
  'Nikdy jsem ráno netušil(a), jak jsem se dostal(a) do stanu.',
];

/// „Pij když…" – pravidla, podle kterých se naráz pije.
const List<String> drinkRules = [
  'Všichni, co maj na sobě něco modrýho, pijou.',
  'Nejmladší a nejstarší u ohně pijou.',
  'Každý, kdo se dneska cvaknul, pije.',
  'Kdo má teď v ruce mobil, pije.',
  'Holky pijou.',
  'Kluci pijou.',
  'Kdo nosí brýle, pije.',
  'Všichni s mokrýma ponožkama pijou.',
  'Kdo se napil jako poslední,pije znova.',
  'Kdo sedí nejblíž ohni, pije.',
  'Každý, kdo dneska řekl „ještě jedno", pije.',
  'Kdo má vousy, pije.',
  'Všichni pijou',
  'Kdo zatím nepil, napije se 2 krát.',
  'Kdo dneska stavěl stan, napije se.',
  'Kdo vyjmenuje 3 řeky, nepije. Kdo ne, napije se.',
  'Kdo dneska pádloval nejvíc, napije se.',
  'Komu nejvíc smrdí prdka, pije',
];

/// „Kostka" – náhodně se zkombinuje KDO + CO. Subjekt je v 1. pádě,
/// akce navazuje, aby věta dávala smysl: `who` + mezera + `what`.
const List<String> diceWho = [
  'Nejmladší',
  'Nejstarší',
  'Ten, kdo nejvíc vypadá jako Jirka Kára',
  'Soused vlevo',
  'Soused vpravo',
  'Ten, kdo je nejvíc zbytečnej,',
  'Ten, kdo dneska řídil loď,',
  'Poslední, kdo se napil,',
  'Ten, kdo má nejdelší vlasy,',
  'Ten, kdo nemá vlasy,',
  'Ten, kdo má doma děti ve sklepě,',
  'Celá posádka',
  'Ten, kdo má nejvíc divnej xicht',
];

const List<String> diceWhat = [
  'se napije 1 krát.',
  'se napije 2 krát.',
  'senapije 3 krát.',
  'si dá panáka.',
  'se napije se 2 krát.',
  'pije s tím, koho si vybere.',
  'vymyslí pravidlo do dalšího kola.',
  'má kliku – tentokrát nepije.',
  'dopije, co má zrovna v ruce.',
  'ťukne si se sousedem a oba pijou.',
  'napije se 1 krát a zazpívá řádek songu.',
  'pije za každýho, kdo má stejnou barvu trika.',
];

/// „Aktivity" – slova k předvádění/popisování, rozdělená podle kategorie.
class CharadesCategory {
  const CharadesCategory(this.name, this.words);
  final String name;
  final List<String> words;
}

const List<CharadesCategory> charadesCategories = [
  CharadesCategory('Voda a tábor', [
    'pádlo',
    'stan',
    'spacák',
    'oheň',
    'kotlík',
    'jez',
    'kánoe',
    'vesta',
    'mapa',
    'buřt',
    'komár',
    'déšť',
    'záchod v lese',
    'mokré boty',
    'opalovací krém',
    'čelovka',
    'řeka',
    'most',
    'tábořák',
    'kytara',
    'hospoda',
    'pivo',
    'kemp',
    'sluníčko',
    'vlny',
    'mlha',
    'soutok',
  ]),
  CharadesCategory('Filmy a seriály', [
    'Titanic',
    'Piráti z Karibiku',
    'Vykoupení z věznice Shawshank',
    'Pán prstenů',
    'Sám doma',
    'Pelíšky',
    'Vrchní, prchni!',
    'Jaws',
    'Forrest Gump',
    'Hra o trůny',
    'Přátelé',
    'Hvězdné války',
    'Mrazík',
    'Slunce, seno, jahody',
    'Avatar',
  ]),
  CharadesCategory('Zvířata', [
    'štika',
    'volavka',
    'bobr',
    'rak',
    'kapr',
    'labuť',
    'žába',
    'liška',
    'medvěd',
    'klíště',
    'pavouk',
    'jelen',
    'sova',
    'vážka',
    'kachna',
    'racek',
    'had',
    'ježek',
    'netopýr',
    'kuna',
  ]),
  CharadesCategory('Akce a sloveso', [
    'pádlovat',
    'plavat',
    'stanovat',
    'zpívat',
    'vařit',
    'spát',
    'tahat loď',
    'nadávat',
    'fotit',
    'opékat',
    'veslovat',
    'topit se',
    'sušit věci',
    'balit batoh',
    'rozdělávat oheň',
    'chrápat',
    'klepat se zimou',
    'tancovat',
  ]),
];

/// „Kdo jsem?" – balíčky slov, která se ti zobrazí na čele.
const Map<String, List<String>> headsUpDecks = {
  'Vodácké': [
    'pádlo',
    'jez',
    'kánoe',
    'pramice',
    'vesta',
    'helma',
    'splav',
    'eskymák',
    'háček',
    'zadák',
    'přenáška',
    'peřej',
    'kotlík',
    'stan',
    'spacák',
    'čelovka',
    'komár',
    'klíště',
    'kemp',
    'oheň',
    'buřt',
    'řeka',
    'most',
    'vlny',
    'válec',
    'mapa',
    'plavky',
    'mokré boty',
    'kelt vprcanej',
  ],
  'Celebrity': [
    'Karel Gott',
    'Lucie Bílá',
    'Jaromír Jágr',
    'Ester Ledecká',
    'Leoš Mareš',
    'Marek Eben',
    'Patrik Hartl',
    'Tomio Okamura',
    'Albert Einstein',
    'Lady Gaga',
    'Leonardo DiCaprio',
    'Jirka Kára',
    'Beyoncé',
    'Cristiano Ronaldo',
    'Elon Musk',
    'Václav Havel',
    'Mona Lisa',
  ],
  'Zvířata': [
    'slon',
    'tučňák',
    'krokodýl',
    'žirafa',
    'ježek',
    'bobr',
    'velbloud',
    'tučňák',
    'klokan',
    'sova',
    'medvěd',
    'žába',
    'štika',
    'labuť',
    'kobra',
    'chobotnice',
    'liška',
    'netopýr',
    'mravenec',
    'velryba',
  ],
  'Profese': [
    'pilot',
    'kuchař',
    'učitel',
    'hasič',
    'lékař',
    'instalatér',
    'zpěvák',
    'kapitán lodi',
    'fotograf',
    'horník',
    'pikař',
    'záchranář',
    'zahradník',
    'řezník',
    'vědec',
    'pasák',
  ],
};
