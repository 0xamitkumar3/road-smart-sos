import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../home/home_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF0F111A),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 50),

              const Text(
                "Welcome Back",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              )
                  .animate()
                  .fadeIn(),

              const SizedBox(height: 10),

              const Text(
                "Login to continue your safety journey",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              )
                  .animate()
                  .fadeIn(delay: 300.ms),

              const SizedBox(height: 50),

              const CustomTextField(
                hint: "Email",
                icon: Icons.email,
              ),

              const SizedBox(height: 20),

              const CustomTextField(
                hint: "Password",
                icon: Icons.lock,
                obscure: true,
              ),

              const SizedBox(height: 30),

              CustomButton(
                text: "Login",

                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HomeScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  const Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.white70),
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SignupScreen(),
                        ),
                      );
                    },

                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.red.shade400,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}