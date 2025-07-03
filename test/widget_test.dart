import 'package:flutter_test/flutter_test.dart';
import 'package:taskflows/main.dart'; // adjust if needed

void main() {
  testWidgets('Main screen loads with success text', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('✅ Firebase is configured and ready!'), findsOneWidget);
  });
}
