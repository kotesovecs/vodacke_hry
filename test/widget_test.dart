import 'package:flutter_test/flutter_test.dart';

import 'package:vodacke_hry/main.dart';

void main() {
  testWidgets('Domovská obrazovka ukáže nadpis a hry', (tester) async {
    await tester.pumpWidget(const VodackeHryApp());
    await tester.pumpAndSettle();

    expect(find.text('Vodácké Hry'), findsOneWidget);
    expect(find.text('Kdo jsem?'), findsOneWidget);
    expect(find.text('Vodácký kvíz'), findsOneWidget);
  });
}
