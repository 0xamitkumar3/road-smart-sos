import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_tts/flutter_tts.dart';

class VoiceAssistantScreen
    extends StatefulWidget {

  const VoiceAssistantScreen({
    super.key,
  });

  @override
  State<VoiceAssistantScreen>
      createState() =>
          _VoiceAssistantScreenState();
}

class _VoiceAssistantScreenState
    extends State<
        VoiceAssistantScreen>
    with TickerProviderStateMixin {

  late AnimationController
      pulseController;

  late AnimationController
      rotateController;

  late Animation<double>
      pulseAnimation;

  final FlutterTts flutterTts =
      FlutterTts();

  bool isListening = true;

  String aiStatus =
      "Listening for emergency commands...";

  List<double> waveValues = List.generate(
    24,
    (_) => 20,
  );

  Timer? waveTimer;

  @override
  void initState() {
    super.initState();

    pulseController =
        AnimationController(
      vsync: this,
      duration:
          const Duration(
        seconds: 2,
      ),
    );

    rotateController =
        AnimationController(
      vsync: this,
      duration:
          const Duration(
        seconds: 12,
      ),
    );

    pulseAnimation =
        Tween<double>(
      begin: 0.92,
      end: 1.08,
    ).animate(

      CurvedAnimation(
        parent:
            pulseController,

        curve:
            Curves.easeInOut,
      ),
    );

    pulseController.repeat(
      reverse: true,
    );

    rotateController.repeat();

    startWaveAnimation();

    speakMessage();
  }

  Future<void> speakMessage() async {

    await flutterTts.setLanguage(
      "en-US",
    );

    await flutterTts.setSpeechRate(
      0.45,
    );

    await flutterTts.speak(
      "AI emergency assistant activated",
    );
  }

  void startWaveAnimation() {

    waveTimer = Timer.periodic(

      const Duration(
        milliseconds: 150,
      ),

      (_) {

        if (!mounted) return;

        setState(() {

          waveValues =
              List.generate(

            24,

            (_) =>
                Random().nextDouble() *
                    70 +
                12,
          );
        });
      },
    );
  }

  @override
  void dispose() {

    pulseController.dispose();

    rotateController.dispose();

    waveTimer?.cancel();

    flutterTts.stop();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color(0xFF090B12),

      appBar: AppBar(
        backgroundColor:
            Colors.transparent,

        elevation: 0,

        title: const Text(
          "AI Voice Assistant",

          style: TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(

          physics:
              const BouncingScrollPhysics(),

          child: Padding(
            padding:
                const EdgeInsets.all(
              24,
            ),

            child: Column(
              children: [

                const SizedBox(
                  height: 10,
                ),

                buildAssistantHeader(),

                const SizedBox(
                  height: 35,
                ),

                buildRadarMic(),

                const SizedBox(
                  height: 45,
                ),

                buildWaveform(),

                const SizedBox(
                  height: 35,
                ),

                buildQuickAIStats(),

                const SizedBox(
                  height: 30,
                ),

                buildAIStatusPanel(),

                const SizedBox(
                  height: 35,
                ),

                buildActionButtons(),

                const SizedBox(
                  height: 30,
                ),
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
              colors: [

                Colors.white,

                Colors.red.shade300,
              ],
            ).createShader(
              bounds,
            );
          },

          child: const Text(
            "JARVIS Emergency AI",

            textAlign:
                TextAlign.center,

            style: TextStyle(
              fontSize: 34,
              fontWeight:
                  FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),

        const SizedBox(height: 12),

        Text(
          aiStatus,

          textAlign:
              TextAlign.center,

          style: const TextStyle(
            fontSize: 16,
            color: Colors.white70,
            height: 1.5,
          ),
        ),
      ],
    )
        .animate()
        .fadeIn(
          duration: 700.ms,
        )
        .slideY(
          begin: 0.2,
        );
  }

  Widget buildRadarMic() {

    return Center(
      child: Stack(
        alignment:
            Alignment.center,

        children: [

          ScaleTransition(
            scale: pulseAnimation,

            child: Container(
              width: 300,
              height: 300,

              decoration:
                  BoxDecoration(
                shape:
                    BoxShape.circle,

                gradient:
                    RadialGradient(
                  colors: [

                    Colors.red
                        .withValues(
                      alpha: 0.10,
                    ),

                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          RotationTransition(
            turns:
                rotateController,

            child: Container(
              width: 280,
              height: 280,

              decoration:
                  BoxDecoration(
                shape:
                    BoxShape.circle,

                border: Border.all(
                  color: Colors.red
                      .withValues(
                    alpha: 0.18,
                  ),

                  width: 2,
                ),
              ),
            ),
          ),

          RotationTransition(
            turns:
                rotateController,

            child: Container(
              width: 230,
              height: 230,

              decoration:
                  BoxDecoration(
                shape:
                    BoxShape.circle,

                border: Border.all(
                  color: Colors.red
                      .withValues(
                    alpha: 0.08,
                  ),

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

              decoration:
                  BoxDecoration(
                shape:
                    BoxShape.circle,

                gradient:
                    RadialGradient(
                  colors: [

                    Colors.red
                        .withValues(
                      alpha: 0.35,
                    ),

                    Colors.red
                        .withValues(
                      alpha: 0.03,
                    ),
                  ],
                ),
              ),
            ),
          ),

          Container(
            width: 130,
            height: 130,

            decoration:
                BoxDecoration(
              shape:
                  BoxShape.circle,

              gradient:
                  LinearGradient(
                begin:
                    Alignment.topLeft,

                end:
                    Alignment
                        .bottomRight,

                colors: [

                  Colors.redAccent,

                  Colors.red.shade900,
                ],
              ),

              boxShadow: [

                BoxShadow(
                  color: Colors.red
                      .withValues(
                    alpha: 0.5,
                  ),

                  blurRadius: 40,
                  spreadRadius: 6,
                ),
              ],
            ),

            child: const Icon(
              Icons.mic,
              size: 60,
              color: Colors.white,
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(
          duration: 700.ms,
        )
        .scale(
          begin: const Offset(
            0.8,
            0.8,
          ),
        );
  }

  Widget buildWaveform() {

    return Container(
      height: 150,

      padding:
          const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 18,
      ),

      decoration: BoxDecoration(

        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end:
              Alignment.bottomRight,

          colors: [

            Colors.white.withValues(
              alpha: 0.04,
            ),

            const Color(
              0xFF151A28,
            ),
          ],
        ),

        borderRadius:
            BorderRadius.circular(
          30,
        ),

        border: Border.all(
          color: Colors.red
              .withValues(
            alpha: 0.12,
          ),
        ),

        boxShadow: [

          BoxShadow(
            color: Colors.red
                .withValues(
              alpha: 0.08,
            ),

            blurRadius: 24,
          ),
        ],
      ),

      child: Row(
        mainAxisAlignment:
            MainAxisAlignment
                .spaceEvenly,

        crossAxisAlignment:
            CrossAxisAlignment.end,

        children: waveValues
            .map(
              (value) {

            return AnimatedContainer(
              duration:
                  const Duration(
                milliseconds: 150,
              ),

              curve:
                  Curves.easeInOut,

              width: 7,

              height: value,

              decoration:
                  BoxDecoration(

                gradient:
                    LinearGradient(
                  begin:
                      Alignment.topCenter,

                  end:
                      Alignment.bottomCenter,

                  colors: [

                    Colors.redAccent,

                    Colors.red.shade900,
                  ],
                ),

                borderRadius:
                    BorderRadius.circular(
                  20,
                ),

                boxShadow: [

                  BoxShadow(
                    color: Colors.red
                        .withValues(
                      alpha: 0.45,
                    ),

                    blurRadius: 12,
                  ),
                ],
              ),
            );
          },
        ).toList(),
      ),
    )
        .animate()
        .fadeIn(
          duration: 700.ms,
        );
  }

  Widget buildQuickAIStats() {

    return Row(
      mainAxisAlignment:
          MainAxisAlignment
              .spaceBetween,

      children: [

        buildMiniCard(
          title: "Voice",

          value: "ACTIVE",

          color: Colors.green,

          icon:
              Icons.graphic_eq,
        ),

        buildMiniCard(
          title: "AI Core",

          value: "ONLINE",

          color: Colors.red,

          icon:
              Icons.memory,
        ),

        buildMiniCard(
          title: "Alerts",

          value: "READY",

          color: Colors.blue,

          icon:
              Icons.warning,
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

        margin:
            const EdgeInsets.symmetric(
          horizontal: 5,
        ),

        padding:
            const EdgeInsets.all(
          16,
        ),

        decoration: BoxDecoration(

          color:
              color.withValues(
            alpha: 0.10,
          ),

          borderRadius:
              BorderRadius.circular(
            24,
          ),

          border: Border.all(
            color: color,
          ),
        ),

        child: Column(
          children: [

            Icon(
              icon,
              color: color,
              size: 28,
            ),

            const SizedBox(
              height: 12,
            ),

            Text(
              title,

              style:
                  const TextStyle(
                color:
                    Colors.white70,
              ),
            ),

            const SizedBox(
              height: 8,
            ),

            Text(
              value,

              style: TextStyle(
                color: color,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(
          duration: 600.ms,
        )
        .scale();
  }

  Widget buildAIStatusPanel() {

    return Container(
      width: double.infinity,

      padding:
          const EdgeInsets.all(
        24,
      ),

      decoration: BoxDecoration(

        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end:
              Alignment.bottomRight,

          colors: [

            Colors.blue
                .withValues(
              alpha: 0.15,
            ),

            Colors.purple
                .withValues(
              alpha: 0.06,
            ),

            const Color(
              0xFF141824,
            ),
          ],
        ),

        borderRadius:
            BorderRadius.circular(
          30,
        ),

        border: Border.all(
          color: Colors.blue
              .withValues(
            alpha: 0.12,
          ),
        ),

        boxShadow: [

          BoxShadow(
            color: Colors.blue
                .withValues(
              alpha: 0.08,
            ),

            blurRadius: 24,
            spreadRadius: 1,
          ),
        ],
      ),

      child: Column(
        children: [

          const Row(
            children: [

              Icon(
                Icons.memory,
                color: Colors.blue,
              ),

              SizedBox(width: 12),

              Text(
                "AI Monitoring Status",

                style: TextStyle(
                  fontSize: 22,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          buildStatusRow(
            title:
                "Voice Detection",

            value:
                "ACTIVE",

            color:
                Colors.green,
          ),

          buildStatusRow(
            title:
                "Emergency Engine",

            value:
                "READY",

            color:
                Colors.red,
          ),

          buildStatusRow(
            title:
                "AI Analysis",

            value:
                "RUNNING",

            color:
                Colors.orange,
          ),

          buildStatusRow(
            title:
                "GPS Communication",

            value:
                "CONNECTED",

            color:
                Colors.blue,
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(
          duration: 700.ms,
        )
        .slideY(
          begin: 0.2,
        );
  }

  Widget buildStatusRow({

    required String title,

    required String value,

    required Color color,
  }) {

    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 18,
      ),

      child: Row(
        mainAxisAlignment:
            MainAxisAlignment
                .spaceBetween,

        children: [

          Text(
            title,

            style: const TextStyle(
              fontSize: 16,
              color:
                  Colors.white70,
            ),
          ),

          Container(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),

            decoration:
                BoxDecoration(

              color:
                  color.withValues(
                alpha: 0.18,
              ),

              borderRadius:
                  BorderRadius.circular(
                20,
              ),

              border: Border.all(
                color: color,
              ),
            ),

            child: Text(
              value,

              style: TextStyle(
                color: color,
                fontWeight:
                    FontWeight.bold,
              ),
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

            style:
                ElevatedButton.styleFrom(
              backgroundColor:
                  Colors.redAccent,

              padding:
                  const EdgeInsets.symmetric(
                vertical: 18,
              ),

              elevation: 12,

              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(
                  22,
                ),
              ),
            ),

            onPressed: () async {

              setState(() {

                aiStatus =
                    "Emergency protocol activated";
              });

              await flutterTts.speak(
                "Emergency protocol activated",
              );
            },

            icon: const Icon(
              Icons.warning,
            ),

            label: const Text(
              "Emergency",
            ),
          ),
        ),

        const SizedBox(width: 18),

        Expanded(
          child: ElevatedButton.icon(

            style:
                ElevatedButton.styleFrom(
              backgroundColor:
                  Colors.blueAccent,

              padding:
                  const EdgeInsets.symmetric(
                vertical: 18,
              ),

              elevation: 12,

              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(
                  22,
                ),
              ),
            ),

            onPressed: () async {

              setState(() {

                aiStatus =
                    "AI assistant listening...";
              });

              await flutterTts.speak(
                "AI assistant listening",
              );
            },

            icon: const Icon(
              Icons.mic,
            ),

            label: const Text(
              "Listen",
            ),
          ),
        ),
      ],
    )
        .animate()
        .fadeIn(
          duration: 700.ms,
        )
        .slideY(
          begin: 0.2,
        );
  }
}