import 'package:ai_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Welcome",
          body: "Discover the amazing features of our app.",
          image: Center(child: Image.asset('assets/tutorial1.png', height: 175)),
        ),
        PageViewModel(
          title: "Easy Navigation",
          body: "Navigate the app with ease using intuitive controls.",
          image: Center(child: Image.asset('assets/tutorial2.png', height: 175)),
        ),
        PageViewModel(
          title: "Get Started",
          body: "Start exploring and make the most of your experience.",
          image: Center(child: Image.asset('assets/tutorial3.png', height: 175)),
        ),
      ],
      onDone: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ChatScreen()),
        );
      },
      onSkip: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ChatScreen()),
        );
      },
      showSkipButton: true,
      skip: const Text("Skip"),
      next: const Icon(Icons.arrow_forward),
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}
