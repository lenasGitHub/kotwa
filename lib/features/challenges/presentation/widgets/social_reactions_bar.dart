import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/models/challenge.dart';

/// Social reactions bar (likes, love, fire, etc.)
class SocialReactionsBar extends StatefulWidget {
  final List<SocialReaction> reactions;
  final Function(SocialReaction) onReactionTap;

  const SocialReactionsBar({
    super.key,
    required this.reactions,
    required this.onReactionTap,
  });

  @override
  State<SocialReactionsBar> createState() => _SocialReactionsBarState();
}

class _SocialReactionsBarState extends State<SocialReactionsBar> {
  Set<String> _selectedReactions = {};

  void _toggleReaction(SocialReaction reaction) {
    HapticFeedback.lightImpact();
    setState(() {
      if (_selectedReactions.contains(reaction.odeName)) {
        _selectedReactions.remove(reaction.odeName);
      } else {
        _selectedReactions.add(reaction.odeName);
      }
    });
    widget.onReactionTap(reaction);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.favorite, color: Colors.redAccent, size: 18),
              const SizedBox(width: 8),
              Text(
                'Show some love!',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: widget.reactions.map((reaction) {
              final isSelected = _selectedReactions.contains(reaction.odeName);
              return GestureDetector(
                onTap: () => _toggleReaction(reaction),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.white.withOpacity(0.15)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? Colors.white30 : Colors.transparent,
                    ),
                  ),
                  child: Row(
                    children: [
                      AnimatedScale(
                        scale: isSelected ? 1.2 : 1.0,
                        duration: const Duration(milliseconds: 150),
                        child: Text(
                          reaction.emoji,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                      if (reaction.count > 0) ...[
                        const SizedBox(width: 6),
                        Text(
                          '${reaction.count}',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

/// Poke button widget
class PokeButton extends StatefulWidget {
  final String friendName;
  final VoidCallback onPoke;

  const PokeButton({super.key, required this.friendName, required this.onPoke});

  @override
  State<PokeButton> createState() => _PokeButtonState();
}

class _PokeButtonState extends State<PokeButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _hasPoked = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _poke() {
    if (_hasPoked) return;

    HapticFeedback.mediumImpact();
    _controller.forward().then((_) {
      _controller.reverse();
    });

    setState(() => _hasPoked = true);
    widget.onPoke();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('👀 You poked ${widget.friendName}!'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF9C27B0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _poke,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(angle: _controller.value * 0.5, child: child);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: _hasPoked
                ? Colors.grey.withOpacity(0.2)
                : const Color(0xFF9C27B0).withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _hasPoked
                  ? Colors.grey.withOpacity(0.3)
                  : const Color(0xFF9C27B0).withOpacity(0.5),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '👆',
                style: TextStyle(
                  fontSize: 16,
                  color: _hasPoked ? Colors.grey : null,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                _hasPoked ? 'Poked!' : 'Poke',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _hasPoked ? Colors.grey : const Color(0xFF9C27B0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
