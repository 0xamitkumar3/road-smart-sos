import 'package:flutter/material.dart';

import '../../models/medical_info_model.dart';

import '../../services/storage_service/medical_storage_service.dart';

class MedicalInfoScreen
    extends StatefulWidget {

  const MedicalInfoScreen({
    super.key,
  });

  @override
  State<MedicalInfoScreen>
      createState() =>
          _MedicalInfoScreenState();
}

class _MedicalInfoScreenState
    extends State<MedicalInfoScreen> {

  final TextEditingController
      bloodGroupController =
          TextEditingController();

  final TextEditingController
      allergiesController =
          TextEditingController();

  final TextEditingController
      conditionsController =
          TextEditingController();

  final TextEditingController
      medicationsController =
          TextEditingController();

  final TextEditingController
      notesController =
          TextEditingController();

  final MedicalStorageService
      storageService =
          MedicalStorageService();

  @override
  void initState() {
    super.initState();

    loadMedicalInfo();
  }

  Future<void> loadMedicalInfo() async {

    final medicalInfo =
        await storageService
            .loadMedicalInfo();

    if (medicalInfo != null) {

      bloodGroupController.text =
          medicalInfo.bloodGroup;

      allergiesController.text =
          medicalInfo.allergies;

      conditionsController.text =
          medicalInfo.conditions;

      medicationsController.text =
          medicalInfo.medications;

      notesController.text =
          medicalInfo.notes;

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color(0xFF0F111A),

      appBar: AppBar(
        backgroundColor:
            Colors.transparent,

        title: const Text(
          "Medical Information",
        ),
      ),

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Text(
              "Emergency Medical Profile",

              style: TextStyle(
                fontSize: 28,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            buildTextField(
              controller:
                  bloodGroupController,

              label:
                  "Blood Group",

              icon:
                  Icons.bloodtype,
            ),

            buildTextField(
              controller:
                  allergiesController,

              label:
                  "Allergies",

              icon:
                  Icons.warning_amber,
            ),

            buildTextField(
              controller:
                  conditionsController,

              label:
                  "Medical Conditions",

              icon:
                  Icons.health_and_safety,
            ),

            buildTextField(
              controller:
                  medicationsController,

              label:
                  "Current Medications",

              icon:
                  Icons.medication,
            ),

            buildTextField(
              controller:
                  notesController,

              label:
                  "Emergency Notes",

              icon:
                  Icons.notes,

              maxLines: 4,
            ),

            const SizedBox(height: 35),

            SizedBox(
              width: double.infinity,
              height: 60,

              child:
                  ElevatedButton.icon(
                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.red.shade400,

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                      18,
                    ),
                  ),
                ),

                onPressed: () async {

                  final medicalInfo =
                      MedicalInfoModel(

                    bloodGroup:
                        bloodGroupController.text,

                    allergies:
                        allergiesController.text,

                    conditions:
                        conditionsController.text,

                    medications:
                        medicationsController.text,

                    notes:
                        notesController.text,
                  );

                  await storageService
                      .saveMedicalInfo(
                    medicalInfo,
                  );

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(

                    const SnackBar(
                      content: Text(
                        "Medical information saved successfully.",
                      ),
                    ),
                  );
                },

                icon: const Icon(
                  Icons.save,
                ),

                label: const Text(
                  "Save Medical Information",

                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField({

    required TextEditingController
        controller,

    required String label,

    required IconData icon,

    int maxLines = 1,
  }) {

    return Container(
      margin:
          const EdgeInsets.only(
        bottom: 22,
      ),

      child: TextField(
        controller: controller,

        maxLines: maxLines,

        style: const TextStyle(
          color: Colors.white,
        ),

        decoration: InputDecoration(

          filled: true,

          fillColor:
              const Color(0xFF1C1F2E),

          labelText: label,

          labelStyle:
              const TextStyle(
            color: Colors.white70,
          ),

          prefixIcon: Icon(
            icon,
            color: Colors.red,
          ),

          border:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(
              20,
            ),

            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}