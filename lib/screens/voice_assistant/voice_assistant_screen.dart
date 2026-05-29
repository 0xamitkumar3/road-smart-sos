import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../services/ai_service.dart';

class VoiceAssistantScreen extends StatefulWidget {
  const VoiceAssistantScreen({super.key});

  @override
  State<VoiceAssistantScreen> createState() => _VoiceAssistantScreenState();
}

class _VoiceAssistantScreenState extends State<VoiceAssistantScreen>
    with TickerProviderStateMixin {

  late AnimationController pulseController;
  late AnimationController rotateController;
  late Animation<double> pulseAnimation;

  final FlutterTts flutterTts = FlutterTts();
  final AIService aiService = AIService();
  final TextEditingController questionController = TextEditingController();

  // --- Speech to Text ---
  final SpeechToText speechToText = SpeechToText();
  bool isSpeechEnabled = false;

  bool isListening = true;
  bool isLoading = false;

  String aiStatus = "Listening for emergency commands...";
  String aiResponse = "AI emergency assistant ready.";

  List<double> waveValues = List.generate(24, (_) => 20);
  Timer? waveTimer;

  @override
  void initState() {
    super.initState();

    pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    );

    pulseAnimation = Tween<double>(
      begin: 0.92,
      end: 1.08,
    ).animate(
      CurvedAnimation(
        parent: pulseController,
        curve: Curves.easeInOut,
      ),
    );

    pulseController.repeat(reverse: true);
    rotateController.repeat();

    startWaveAnimation();
    speakMessage();
    initSpeech();
  }

  // --- Speech Initialization ---
  Future<void> initSpeech() async {

  isSpeechEnabled =
      await speechToText.initialize(

    onStatus: (status) {
      debugPrint(
        "Speech Status: $status",
      );
    },

    onError: (error) {
      debugPrint(
        "Speech Error: $error",
      );
    },
  );

  debugPrint(
    "Speech Enabled: $isSpeechEnabled",
  );

  if (mounted) {
    setState(() {});
  }
}

  Future<void> speakMessage() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.45);
    await flutterTts.speak("AI emergency assistant activated");
  }

  Future<void> askAI() async {
    if (questionController.text.trim().isEmpty) return;

    setState(() {
      isLoading = true;
      aiResponse = "AI analyzing emergency...";
    });

    final response = await aiService.getEmergencyResponse(
      questionController.text,
    );

    setState(() {
      aiResponse = response;
      isLoading = false;
    });

    await flutterTts.speak(response);
  }

  // --- Voice Listening ---
  Future<void> startListening() async {

  debugPrint(
    "Listen button pressed",
  );

  if (!isSpeechEnabled) {

    ScaffoldMessenger.of(context)
        .showSnackBar(

      const SnackBar(
        content: Text(
          "Speech recognition unavailable",
        ),
      ),
    );

    return;
  }

  await speechToText.listen(

    onResult: (result) async {

      setState(() {

        questionController.text =
            result.recognizedWords;

        aiStatus =
            "Voice captured successfully";
      });

      if (result.finalResult &&
          result.recognizedWords
              .trim()
              .isNotEmpty) {

        setState(() {

          isLoading = true;

          aiResponse =
              "AI analyzing emergency...";
        });

        final response =
            await aiService
                .getEmergencyResponse(

          result.recognizedWords,
        );

        if (!mounted) return;

        setState(() {

          aiResponse = response;

          isLoading = false;

          aiStatus =
              "AI response generated";
        });

        await flutterTts.speak(
          response,
        );
      }
    },
  );
}

  void startWaveAnimation() {
    waveTimer = Timer.periodic(
      const Duration(milliseconds: 150),
      (_) {
        if (!mounted) return;
        setState(() {
          waveValues = List.generate(
            24,
            (_) => Random().nextDouble() * 70 + 12,
          );
        });
      },
    );
  }

  @override
void dispose() {
  speechToText.stop();
  pulseController.dispose();
  rotateController.dispose();
  waveTimer?.cancel();
  flutterTts.stop();
  questionController.dispose();
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090B12),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "AI Voice Assistant",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 10),
                buildAssistantHeader(),
                const SizedBox(height: 35),
                buildRadarMic(),
                const SizedBox(height: 45),
                buildWaveform(),
                const SizedBox(height: 35),
                buildQuickAIStats(),
                const SizedBox(height: 30),
                buildAIStatusPanel(),
                const SizedBox(height: 35),
                buildActionButtons(),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAssistantHeader() {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: [Colors.white, Colors.red.shade300],
            ).createShader(bounds);
          },
          child: const Text(
            "JARVIS Emergency AI",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          aiStatus,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white70,
            height: 1.5,
          ),
        ),
      ],
    ).animate().fadeIn(duration: 700.ms).slideY(begin: 0.2);
  }

  Widget buildRadarMic() {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          ScaleTransition(
            scale: pulseAnimation,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.red.withValues(alpha: 0.10),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          RotationTransition(
            turns: rotateController,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.red.withValues(alpha: 0.18),
                  width: 2,
                ),
              ),
            ),
          ),

          RotationTransition(
            turns: rotateController,
            child: Container(
              width: 230,
              height: 230,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.red.withValues(alpha: 0.08),
                  width: 2,
                ),
              ),
            ),
          ),

          ScaleTransition(
            scale: pulseAnimation,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.red.withValues(alpha: 0.35),
                    Colors.red.withValues(alpha: 0.03),
                  ],
                ),
              ),
            ),
          ),

          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.redAccent, Colors.red.shade900],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withValues(alpha: 0.5),
                  blurRadius: 40,
                  spreadRadius: 6,
                ),
              ],
            ),
            child: const Icon(Icons.mic, size: 60, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget buildWaveform() {
    return Container(
      height: 150,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.04),
            const Color(0xFF151A28),
          ],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: waveValues.map((value) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 7,
            height: value,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.redAccent, Colors.red.shade900],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget buildQuickAIStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildMiniCard(
          title: "Voice",
          value: "ACTIVE",
          color: Colors.green,
          icon: Icons.graphic_eq,
        ),
        buildMiniCard(
          title: "AI Core",
          value: "ONLINE",
          color: Colors.red,
          icon: Icons.memory,
        ),
        buildMiniCard(
          title: "Alerts",
          value: "READY",
          color: Colors.blue,
          icon: Icons.warning,
        ),
      ],
    );
  }

  Widget buildMiniCard({
    required String title,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: color),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAIStatusPanel() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.withValues(alpha: 0.15),
            Colors.purple.withValues(alpha: 0.06),
            const Color(0xFF141824),
          ],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Icon(Icons.memory, color: Colors.blue),
              SizedBox(width: 12),
              Text(
                "AI Monitoring Status",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          const SizedBox(height: 25),

          buildStatusRow(title: "Voice Detection", value: "ACTIVE", color: Colors.green),
          buildStatusRow(title: "Emergency Engine", value: "READY", color: Colors.red),
          buildStatusRow(title: "AI Analysis", value: "RUNNING", color: Colors.orange),
          buildStatusRow(title: "GPS Communication", value: "CONNECTED", color: Colors.blue),

          const SizedBox(height: 25),

          TextField(
            controller: questionController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Ask emergency AI...",
              hintStyle: const TextStyle(color: Colors.white54),
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.05),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(Icons.smart_toy, color: Colors.blue),
            ),
          ),

          const SizedBox(height: 18),

          SizedBox(
            width: double.infinity,
            height: 58,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onPressed: isLoading ? null : askAI,
              icon: const Icon(Icons.auto_awesome),
              label: Text(isLoading ? "Analyzing..." : "Ask AI"),
            ),
          ),

          const SizedBox(height: 24),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              aiResponse,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 15,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStatusRow({
    required String title,
    required String value,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, color: Colors.white70),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: color),
            ),
            child: Text(
              value,
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              padding: const EdgeInsets.symmetric(vertical: 18),
              elevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
            ),
            onPressed: () async {
              setState(() {
                aiStatus = "Emergency protocol activated";
              });
              await flutterTts.speak("Emergency protocol activated");
            },
            icon: const Icon(Icons.warning),
            label: const Text("Emergency"),
          ),
        ),

        const SizedBox(width: 18),

        Expanded(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(vertical: 18),
              elevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
            ),
            // --- Updated Listen button ---
            onPressed: () async {
              setState(() {
                aiStatus = "Listening...";
              });
              await flutterTts.speak("I am listening");
              await startListening();
            },
            icon: const Icon(Icons.mic),
            label: const Text("Listen"),
          ),
        ),
      ],
    );
  }
}