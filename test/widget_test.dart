import 'package:flutter_test/flutter_test.dart';
import 'package:wed_flutter/main.dart';

void main() {
  testWidgets('App renders without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const WeddingApp());
    expect(find.byType(WeddingApp), findsOneWidget);
  });
}
