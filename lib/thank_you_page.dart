import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'theme.dart';

class ThankYouPage extends StatefulWidget {
  final String name;
  const ThankYouPage({super.key, required this.name});

  @override
  State<ThankYouPage> createState() => _ThankYouPageState();
}

class _ThankYouPageState extends State<ThankYouPage>
    with SingleTickerProviderStateMixin {
  late final ConfettiController _confetti;
  late final AnimationController _fadeCtrl;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 6));
    _fadeCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeIn);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _confetti.play();
      _fadeCtrl.forward();
    });
  }

  @override
  void dispose() {
    _confetti.dispose();
    _fadeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: plumDeep,
      body: Container(
        decoration: const BoxDecoration(gradient: bgGradient),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: 0,
              left: MediaQuery.of(context).size.width / 2 - 10,
              child: ConfettiWidget(
                confettiController: _confetti,
                blastDirectionality: BlastDirectionality.explosive,
                numberOfParticles: 30,
                gravity: 0.3,
                colors: const [gold, goldSoft, goldBright, ivory, plum],
                shouldLoop: false,
              ),
            ),
            FadeTransition(
              opacity: _fadeAnim,
              child: SafeArea(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 440),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('الحمد لله',
                              style: cinzel(size: 28, color: goldBright, spacing: 2),
                              textAlign: TextAlign.center),
                          const SizedBox(height: 4),
                          Text('Alhamdulillah!',
                              style: cinzel(size: 22, color: goldSoft, spacing: 1),
                              textAlign: TextAlign.center),
                          const SizedBox(height: 24),
                          const Text('🎉', style: TextStyle(fontSize: 56)),
                          const SizedBox(height: 20),
                          _goldRule(),
                          const SizedBox(height: 20),
                          Text(widget.name,
                              style: tangerine(size: 52, color: goldBright),
                              textAlign: TextAlign.center),
                          const SizedBox(height: 16),
                          Text(
                            "Thank you for confirming — we can't wait to celebrate this joyous occasion with you, insha'Allah! 🤍",
                            style: cormorant(size: 18, color: ivory),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 28),
                          _goldRule(),
                          const SizedBox(height: 20),
                          Text(
                            'MD Zeeshan Haider\n& Zubia Samreen',
                            style: cinzel(size: 14, color: goldSoft, spacing: 0.5),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _goldRule() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [_line(), const Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Text('✦', style: TextStyle(color: gold, fontSize: 10))), _line()],
    );
  }

  Widget _line() => Container(
        width: 60,
        height: 1,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Colors.transparent, gold, Colors.transparent]),
        ),
      );
}
