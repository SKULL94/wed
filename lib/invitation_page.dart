import 'dart:math';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'theme.dart';
import 'name_dialog.dart';
import 'thank_you_page.dart';
import 'config.dart';

class InvitationPage extends StatefulWidget {
  const InvitationPage({super.key});

  @override
  State<InvitationPage> createState() => _InvitationPageState();
}

class _InvitationPageState extends State<InvitationPage> {
  static const _noW = 145.0;
  static const _noH = 44.0;
  static const _zoneH = 120.0;

  double _noX = 0;
  double _noY = 0;
  double _zoneW = 0;
  bool _positioned = false;

  int _dodgeCount = 0;
  static const _maxDodges = 5;
  bool _noSettled = false;
  bool _rsvpDone = false;
  String _nudge = '';
  bool _showNudge = false;

  final _nudges = [
    "Wait — are you sure?",
    "We'd really love to see you there.",
    "Give it one more thought?",
    "It won't be the same without you.",
    "Alright, one last chance to say yes…",
  ];

  void _initPos(double zoneW) {
    _zoneW = zoneW;
    _noX = (zoneW - _noW) / 2;
    _noY = (_zoneH - _noH) / 2;
    _positioned = true;
  }

  void _dodge() {
    if (_noSettled || _rsvpDone) return;
    final r = Random();
    final maxX = (_zoneW - _noW).clamp(0, double.infinity);
    final maxY = (_zoneH - _noH).clamp(0, double.infinity);
    setState(() {
      _noX = r.nextDouble() * maxX;
      _noY = r.nextDouble() * maxY;
    });
  }

  void _onNoTap() {
    if (_rsvpDone) return;
    if (_dodgeCount < _maxDodges) {
      setState(() {
        _dodgeCount++;
        _nudge = _nudges[_dodgeCount - 1];
        _showNudge = true;
        if (_dodgeCount < _maxDodges) {
          _dodge();
        } else {
          _noSettled = true;
          _noX = (_zoneW - _noW) / 2;
          _noY = (_zoneH - _noH) / 2;
          _nudge = "Alright — thank you for letting us know either way.";
        }
      });
      return;
    }
    setState(() {
      _nudge = "We'll miss you — thank you for letting us know. 💐";
      _rsvpDone = true;
    });
  }

  bool _recorded = false;

  void _recordRsvp(String name) {
    if (_recorded) return;
    if (rsvpSheetUrl == 'YOUR_APPS_SCRIPT_URL_HERE') return;
    _recorded = true;
    // Image pixel avoids CORS — browser loads it without preflight
    html.ImageElement()
      ..src = '$rsvpSheetUrl?name=${Uri.encodeComponent(name)}';
  }

  void _onYesTap() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => NameDialog(
        onSelected: (name) {
          _recordRsvp(name);
          Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (_, _, _) => ThankYouPage(name: name),
            transitionsBuilder: (_, anim, _, child) =>
                FadeTransition(opacity: anim, child: child),
            transitionDuration: const Duration(milliseconds: 400),
          ));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: plumDeep,
      body: Container(
        decoration: const BoxDecoration(gradient: bgGradient),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
                child: _card(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _card() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white.withValues(alpha: 0.02),
                Colors.black.withValues(alpha: 0.1),
              ],
            ),
            border: Border.all(color: gold.withValues(alpha: 0.55)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.55),
                blurRadius: 60,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                  style: cinzel(size: 14, color: goldSoft, spacing: 1)),
              const SizedBox(height: 4),
              Text(
                'In the name of Allah the Most Beneficent, the Most Merciful!',
                style: cormorant(size: 15, color: ivoryDim, style: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 14),
              _rule(),
              const SizedBox(height: 14),
              Text(
                'Mr. & Mrs. Md. Kamran sb.\n(Retd. APP, Advocate on Record, Patna High Court)\nand Ghazala Khanam',
                style: cormorant(size: 15, color: ivoryDim),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                'cordially invite you to join them in celebrating\nthe wedding of their beloved son.',
                style: cormorant(size: 15, color: ivory),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 18),
              Text('Md. Zeeshan Haider',
                  style: cinzel(size: 26, color: goldSoft, weight: FontWeight.w600, spacing: 0.5)),
              Text('with', style: tangerine(size: 32, color: ivory)),
              Text('Zubia Samreen',
                  style: cinzel(size: 26, color: goldSoft, weight: FontWeight.w600, spacing: 0.5)),
              const SizedBox(height: 6),
              Text('daughter of Mr. & Mrs. Nasre Alam',
                  style: cormorant(size: 14, color: ivoryDim)),
              const SizedBox(height: 22),
              _rsvpSection(),
              const SizedBox(height: 20),
              _eventBlock(
                'NIKAH',
                'Thursday, 29th October 2026\nAfter Namaz-e-Maghrib, 7:00 PM onwards',
                'Hotel Atithi',
                'Muzaffarpur, Ramdayalu Nagar – 843113',
              ),
              const SizedBox(height: 20),
              _dotDivider(),
              const SizedBox(height: 20),
              _eventBlock(
                'DAAWAT-E-WALIMA',
                'Saturday, 31st October 2026\n7:00 PM onwards',
                'BSEB Community Hall',
                'BSEB Colony Road, Rajbanshi Nagar, Patna – 801103',
              ),
              const SizedBox(height: 24),
              _dotDivider(),
              const SizedBox(height: 18),
              Text(
                'With best compliments from\nMd Kamran · Ghazala Khanam · Mirza Shadan Beg',
                style: cormorant(size: 13, color: ivoryDim),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
            ],
          ),
        ),
        ..._corners(),
      ],
    );
  }

  Widget _rsvpSection() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: gold.withValues(alpha: 0.5)),
          bottom: BorderSide(color: gold.withValues(alpha: 0.5)),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(0, 18, 0, 16),
      child: Column(
        children: [
          Text('WILL YOU BE JOINING US?',
              style: cinzel(size: 13, color: goldSoft, spacing: 2)),
          const SizedBox(height: 18),
          if (!_rsvpDone) ...[
            GestureDetector(
              onTap: _onYesTap,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                width: double.infinity,
                constraints: const BoxConstraints(maxWidth: 280),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [goldBright, gold],
                  ),
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: gold.withValues(alpha: 0.35),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Text("Yes, I'll be there",
                    style: cinzel(size: 17, color: plumDeep, weight: FontWeight.w600, spacing: 0.5),
                    textAlign: TextAlign.center),
              ),
            ),
            const SizedBox(height: 8),
            LayoutBuilder(
              builder: (context, constraints) {
                final zw = constraints.maxWidth;
                if (!_positioned) _initPos(zw);
                return SizedBox(
                  width: zw,
                  height: _zoneH,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 230),
                        curve: Curves.easeOut,
                        left: _noX,
                        top: _noY,
                        child: MouseRegion(
                          onEnter: (_) => _dodge(),
                          child: GestureDetector(
                            onTap: _onNoTap,
                            child: Container(
                              width: _noW,
                              height: _noH,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: plumDeep.withValues(alpha: 0.55),
                                borderRadius: BorderRadius.circular(22),
                                border: Border.all(color: gold.withValues(alpha: 0.5)),
                              ),
                              child: Text("I will try !!",
                                  style: cormorant(size: 15, color: ivoryDim, style: FontStyle.italic)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
          if (_showNudge) ...[
            const SizedBox(height: 6),
            AnimatedOpacity(
              opacity: _showNudge ? 1 : 0,
              duration: const Duration(milliseconds: 250),
              child: Text(_nudge,
                  style: cormorant(size: 16, color: goldBright, weight: FontWeight.w600),
                  textAlign: TextAlign.center),
            ),
          ],
        ],
      ),
    );
  }

  Widget _eventBlock(String label, String date, String venue, String address) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 22),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [goldSoft, gold],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
          child: Text(label, style: cinzel(size: 11.5, color: plumDeep, spacing: 2.5)),
        ),
        const SizedBox(height: 8),
        Text(date, style: cormorant(size: 17, color: ivory), textAlign: TextAlign.center),
        const SizedBox(height: 5),
        Text(venue, style: cormorant(size: 18, color: goldSoft), textAlign: TextAlign.center),
        Text(address, style: cormorant(size: 13.5, color: ivoryDim), textAlign: TextAlign.center),
      ],
    );
  }

  Widget _rule() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _line(),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('✦', style: TextStyle(color: gold, fontSize: 10)),
        ),
        _line(),
      ],
    );
  }

  Widget _line() => Container(
        width: 50,
        height: 1,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Colors.transparent, gold, Colors.transparent]),
        ),
      );

  Widget _dotDivider() => Container(
        height: 1,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, gold.withValues(alpha: 0.5), Colors.transparent],
          ),
        ),
      );

  List<Widget> _corners() {
    const s = 56.0;
    const t = 2.0;
    final c = gold.withValues(alpha: 0.85);

    Widget corner({bool top = true, bool left = true}) => Positioned(
          top: top ? -1 : null,
          bottom: top ? null : -1,
          left: left ? -1 : null,
          right: left ? null : -1,
          child: SizedBox(
            width: s,
            height: s,
            child: CustomPaint(
              painter: _CornerPainter(color: c, thick: t, top: top, isLeft: left),
            ),
          ),
        );

    return [
      corner(top: true, left: true),
      corner(top: true, left: false),
      corner(top: false, left: true),
      corner(top: false, left: false),
    ];
  }
}

class _CornerPainter extends CustomPainter {
  final Color color;
  final double thick;
  final bool top;
  final bool isLeft;

  const _CornerPainter({required this.color, required this.thick, required this.top, required this.isLeft});

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = color..strokeWidth = thick..style = PaintingStyle.stroke;
    final w = size.width;
    final h = size.height;

    if (top && isLeft) {
      canvas.drawLine(Offset(0, h), const Offset(0, 0), p);
      canvas.drawLine(const Offset(0, 0), Offset(w, 0), p);
    } else if (top && !isLeft) {
      canvas.drawLine(const Offset(0, 0), Offset(w, 0), p);
      canvas.drawLine(Offset(w, 0), Offset(w, h), p);
    } else if (!top && isLeft) {
      canvas.drawLine(const Offset(0, 0), Offset(0, h), p);
      canvas.drawLine(Offset(0, h), Offset(w, h), p);
    } else {
      canvas.drawLine(Offset(w, 0), Offset(w, h), p);
      canvas.drawLine(Offset(w, h), Offset(0, h), p);
    }
  }

  @override
  bool shouldRepaint(_CornerPainter old) => false;
}
