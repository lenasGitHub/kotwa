import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2C2C),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Tab 0: Home/Main
          GestureDetector(
            onTap: () => onTap(0),
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: selectedIndex == 0
                    ? const Color(0xFF8CDD9C)
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.forest_outlined,
                color: selectedIndex == 0
                    ? const Color(0xFF1A2C2C)
                    : Colors.white,
                size: 28,
              ),
            ),
          ),

          // Tab 1: Explore (Map Icon)
          IconButton(
            onPressed: () => onTap(1),
            icon: Icon(
              Icons.map_outlined,
              color: selectedIndex == 1
                  ? const Color(0xFF8CDD9C)
                  : Colors.white,
              size: 28,
            ),
          ),

          // Tab 2: Challenges (Chat Icon)
          IconButton(
            onPressed: () => onTap(2),
            icon: Icon(
              Icons.chat_bubble_outline_rounded,
              color: selectedIndex == 2
                  ? const Color(0xFF8CDD9C)
                  : Colors.white,
              size: 26,
            ),
          ),

          // Tab 3: User Profile
          GestureDetector(
            onTap: () => onTap(3),
            child: Container(
              width: 56,
              height: 56,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selectedIndex == 3
                      ? const Color(0xFF8CDD9C)
                      : Colors.white.withOpacity(0.2),
                  width: selectedIndex == 3 ? 2 : 1,
                ),
              ),
              child: ClipOval(
                child: Image.network(
                  'https://i.pravatar.cc/150?img=68',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
