import 'dart:math';
import 'package:flutter/material.dart';
import 'theme.dart';

const _guestsSource = [
  'Ronit', 'Purnima', 'HKD', '::>>K!LLeR<<::',
  'Bl00D**', 'XtRaMOUS', 'Snake Eye', 'v!per',
  'J.C', 'Rom@n', 'Vips', 'Sush', 'Shubh', 'Dipsy',
  'Tikesh', 'Rachit', 'Nanni', 'Shubham - GGN',
  'Shabnam', 'Ritzi', 'Richaaa', 'Harsh', 'Sakshi',
  'Aarti', 'Prabha', 'Sneha', 'Bhagat', 'Sid', 'Shubham - CCDS',
];

class NameDialog extends StatefulWidget {
  final ValueChanged<String> onSelected;
  const NameDialog({super.key, required this.onSelected});

  @override
  State<NameDialog> createState() => _NameDialogState();
}

class _NameDialogState extends State<NameDialog> {
  String? _picked;
  late final List<String> _guests;

  @override
  void initState() {
    super.initState();
    _guests = List.of(_guestsSource)..shuffle(Random());
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 560),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2D0F28), plumDeep],
          ),
          border: Border.all(color: gold.withValues(alpha: 0.55), width: 1),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.65), blurRadius: 48, offset: const Offset(0, 20)),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _header(),
            Divider(color: gold.withValues(alpha: 0.3), height: 1),
            Flexible(child: _nameList()),
            Divider(color: gold.withValues(alpha: 0.3), height: 1),
            _footer(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
      child: Column(
        children: [
          Text('WHO ARE YOU?', style: cinzel(size: 16, color: goldSoft, spacing: 2.5)),
          const SizedBox(height: 6),
          Text('Select your name from the list below',
              style: cormorant(size: 14, color: ivoryDim, style: FontStyle.italic)),
        ],
      ),
    );
  }

  Widget _nameList() {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 4),
      itemCount: _guests.length,
      itemBuilder: (_, i) {
        final name = _guests[i];
        final selected = _picked == name;
        return InkWell(
          onTap: () => setState(() => _picked = name),
          splashColor: gold.withValues(alpha: 0.12),
          highlightColor: gold.withValues(alpha: 0.06),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 24),
            decoration: BoxDecoration(
              color: selected ? gold.withValues(alpha: 0.13) : Colors.transparent,
              border: Border(
                left: selected
                    ? const BorderSide(color: goldSoft, width: 3)
                    : BorderSide.none,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(name,
                      style: cormorant(
                          size: 17,
                          color: selected ? goldBright : ivory,
                          weight: selected ? FontWeight.w600 : FontWeight.w400)),
                ),
                AnimatedOpacity(
                  opacity: selected ? 1 : 0,
                  duration: const Duration(milliseconds: 180),
                  child: const Icon(Icons.check_rounded, color: goldSoft, size: 18),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _footer() {
    final ready = _picked != null;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GestureDetector(
        onTap: ready
            ? () {
                Navigator.of(context).pop();
                widget.onSelected(_picked!);
              }
            : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 15),
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: ready
                ? const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [goldBright, gold])
                : null,
            color: ready ? null : Colors.white.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(4),
            boxShadow: ready
                ? [BoxShadow(color: gold.withValues(alpha: 0.3), blurRadius: 14, offset: const Offset(0, 5))]
                : [],
          ),
          child: Text(
            ready ? "That's me! ✓" : 'Select your name above',
            style: cinzel(
                size: 14,
                color: ready ? plumDeep : ivoryDim.withValues(alpha: 0.6),
                weight: FontWeight.w600,
                spacing: 0.5),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
