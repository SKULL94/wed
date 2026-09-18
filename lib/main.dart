import 'package:flutter/material.dart';
import 'invitation_page.dart';

void main() => runApp(const WeddingApp());

class WeddingApp extends StatelessWidget {
  const WeddingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zeeshan & Zubia — Wedding Invitation',
      debugShowCheckedModeBanner: false,
      home: const InvitationPage(),
    );
  }
}
