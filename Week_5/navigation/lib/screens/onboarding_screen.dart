import 'package:flutter/material.dart';
import '../models/onboarding_item.dart';
import '../widgets/onboarding_page.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  void _nextPage() {
    if (_currentIndex < onboardingItems.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: onboardingItems.length,
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
              },
              itemBuilder: (context, index) {
                return OnboardingPage(item: onboardingItems[index]);
              },
            ),
          ),

          // ===== BUTTON BAR =====
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Previous button
                if (_currentIndex > 0)
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: _previousPage,
                  )
                else
                  const SizedBox(width: 48), // giữ layout cân

                const SizedBox(width: 12),

                // Next / Get Started button
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      child: Text(
                        _currentIndex == onboardingItems.length - 1
                            ? 'Get Started'
                            : 'Next',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
