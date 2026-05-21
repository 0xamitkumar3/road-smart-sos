import 'package:flutter/material.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../home/home_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF0F111A),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),

        child: SingleChildScrollView(
          child: Column(
            children: [

              const SizedBox(height: 20),

              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              const CustomTextField(
                hint: "Full Name",
                icon: Icons.person,
              ),

              const SizedBox(height: 20),

              const CustomTextField(
                hint: "Phone Number",
                icon: Icons.phone,
              ),

              const SizedBox(height: 20),

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

              const SizedBox(height: 20),

              const CustomTextField(
                hint: "Blood Group",
                icon: Icons.bloodtype,
              ),

              const SizedBox(height: 40),

              CustomButton(
                text: "Create Account",

                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HomeScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}