import 'package:flutter/material.dart';

class AddContactScreen extends StatefulWidget {

  final Function(
    String name,
    String phone,
  ) onSave;

  const AddContactScreen({
    super.key,
    required this.onSave,
  });

  @override
  State<AddContactScreen> createState() =>
      _AddContactScreenState();
}

class _AddContactScreenState
    extends State<AddContactScreen> {

  final TextEditingController
      nameController =
          TextEditingController();

  final TextEditingController
      phoneController =
          TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color(0xFF0F111A),

      appBar: AppBar(
        backgroundColor:
            Colors.transparent,

        title: const Text(
          "Add Emergency Contact",
        ),
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const SizedBox(height: 20),

            const Text(
              "Emergency Contact Details",

              style: TextStyle(
                fontSize: 28,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              controller:
                  nameController,

              decoration: InputDecoration(
                hintText: "Enter Name",

                filled: true,

                fillColor:
                    const Color(
                  0xFF1C1F2E,
                ),

                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    18,
                  ),

                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller:
                  phoneController,

              keyboardType:
                  TextInputType.phone,

              decoration: InputDecoration(
                hintText:
                    "Enter Phone Number",

                filled: true,

                fillColor:
                    const Color(
                  0xFF1C1F2E,
                ),

                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    18,
                  ),

                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 40),

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

                onPressed: () {

                  widget.onSave(
                    nameController.text,
                    phoneController.text,
                  );

                  Navigator.pop(context);
                },

                icon: const Icon(
                  Icons.save,
                ),

                label: const Text(
                  "Save Contact",

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
}