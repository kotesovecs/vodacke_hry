import 'package:flutter/foundation.dart';

/// Globální „párty režim 🍺".
///
/// Když je zapnutý, do klasických her se přidají pití jako sázka a v menu
/// se odemknou pijácké hry. Drží se jako jednoduchý [ValueNotifier], na který
/// se obrazovky dají navázat přes [ValueListenableBuilder].
final ValueNotifier<bool> partyMode = ValueNotifier<bool>(false);
