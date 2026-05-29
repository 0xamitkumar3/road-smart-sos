import 'package:google_generative_ai/google_generative_ai.dart';

class AIService {

  final model = GenerativeModel(

    model: 'gemini-2.0-flash',

    apiKey:
        'my-api-key',
  );

  Future<String> getEmergencyResponse(
    String prompt,
  ) async {

    try {

      final response =
          await model.generateContent([

        Content.text(
          """
You are an AI emergency safety assistant.

Provide short, accurate, life-saving emergency guidance.

User Question:
$prompt
""",
        ),
      ]);

      return response.text ??
          "No response available.";

    } catch (e) {

        return """
              AI service is currently unavailable.

              Emergency Tips:
              • Call emergency services immediately.
              • Move to a safe location.
              • Apply pressure to severe bleeding.
              • Do not move a suspected spinal injury victim.
              • Share your live location with emergency contacts.
              """;
      }
  }
}