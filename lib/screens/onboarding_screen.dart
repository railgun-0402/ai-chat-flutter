import 'package:ai_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  Future<void> _completeOnboarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstLaunch', false);

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ChatScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {

    final introMenuStyle = TextStyle(
      fontSize: 16,
      color: Theme.of(context).colorScheme.onSurface,
    );

    final introMenuColor = Theme.of(context).colorScheme.onSurface;

    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "モバイルチャットへようこそ！",
          body: "Welcome to mobile chat!",
          image: Center(child: Image.asset('assets/icon1.png', height: 175)),
        ),
        PageViewModel(
        title: "〜使い方〜",
        body: "チャットで聞きたいことを入力し、AIに質問してみましょう！",
        image: SafeArea(
        child: Center(child: Image.asset('assets/screen1.png', height: 450, width: MediaQuery.of(context).size.width * 0.8)),
          ),
        ),
        PageViewModel(
          title: "音声でも対応！",
          body: "音声ボタンを押下して、話しかけてみましょう！",
          image: Center(child: Image.asset('assets/icon2.png', height: 175)),
        ),
        PageViewModel(
          title: "さあ、始めよう！",
          body: "スマホであなたの生活を便利に！",
          image: Center(child: Image.asset('assets/icon2.png', height: 175)),
        ),
      ],
      onDone: () {
        _completeOnboarding(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ChatScreen()),
        );
      },
      onSkip: () {
        _completeOnboarding(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ChatScreen()),
        );
      },
      showSkipButton: true,
      skip: Text(
          "Skip",
        style: introMenuStyle,
      ),
      next: Icon(Icons.arrow_forward, color: introMenuColor),
      done: Text("Done", style: introMenuStyle),
    );
  }
}
