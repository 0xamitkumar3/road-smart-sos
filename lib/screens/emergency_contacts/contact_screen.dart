import 'package:flutter/material.dart';

import 'add_contact_screen.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() =>
      _ContactsScreenState();
}

class _ContactsScreenState
    extends State<ContactsScreen> {

  final List<Map<String, String>>
      contacts = [

    {
      "name": "Mom",
      "phone": "+91 9876543210",
    },

    {
      "name": "Dad",
      "phone": "+91 9876543211",
    },
  ];

  void addContact(
    String name,
    String phone,
  ) {

    setState(() {

      contacts.add({
        "name": name,
        "phone": phone,
      });
    });
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
          "Emergency Contacts",
        ),
      ),

      floatingActionButton:
          FloatingActionButton(
        backgroundColor:
            Colors.red.shade400,

        onPressed: () {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  AddContactScreen(
                onSave: addContact,
              ),
            ),
          );
        },

        child: const Icon(
          Icons.add,
        ),
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Text(
              "Saved Emergency Contacts",

              style: TextStyle(
                fontSize: 28,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            Expanded(
              child: ListView.builder(

                itemCount:
                    contacts.length,

                itemBuilder:
                    (context, index) {

                  final contact =
                      contacts[index];

                  return Container(
                    margin:
                        const EdgeInsets.only(
                      bottom: 15,
                    ),

                    padding:
                        const EdgeInsets.all(
                      18,
                    ),

                    decoration:
                        BoxDecoration(
                      color:
                          const Color(
                        0xFF1C1F2E,
                      ),

                      borderRadius:
                          BorderRadius.circular(
                        20,
                      ),
                    ),

                    child: Row(
                      children: [

                        CircleAvatar(
                          backgroundColor:
                              Colors
                                  .red
                                  .shade400,

                          child: const Icon(
                            Icons.person,
                            color:
                                Colors.white,
                          ),
                        ),

                        const SizedBox(
                          width: 15,
                        ),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                            children: [

                              Text(
                                contact[
                                    "name"]!,

                                style:
                                    const TextStyle(
                                  fontSize:
                                      18,

                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),

                              const SizedBox(
                                height: 5,
                              ),

                              Text(
                                contact[
                                    "phone"]!,

                                style:
                                    const TextStyle(
                                  color: Colors
                                      .white70,
                                ),
                              ),
                            ],
                          ),
                        ),

                        IconButton(
                          onPressed: () {

                            setState(() {

                              contacts
                                  .removeAt(
                                index,
                              );
                            });
                          },

                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}