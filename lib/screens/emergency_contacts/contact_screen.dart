import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../services/contact_service.dart';

import 'add_contact_screen.dart';

class ContactsScreen extends StatefulWidget {

  const ContactsScreen({
    super.key,
  });

  @override
  State<ContactsScreen> createState() =>
      _ContactsScreenState();
}

class _ContactsScreenState
    extends State<ContactsScreen> {

  List<Map<String, dynamic>>
      contacts = [];

  @override
  void initState() {

    super.initState();

    loadContacts();
  }

  Future<void> loadContacts() async {

    final user =
        FirebaseAuth
            .instance
            .currentUser;

    if (user == null) return;

    final fetchedContacts =
        await ContactService()
            .getEmergencyContacts(
      user.uid,
    );

    setState(() {

      contacts =
          fetchedContacts;
    });
  }

  void addContact(
    String name,
    String phone,
  ) async {

    final user =
        FirebaseAuth
            .instance
            .currentUser;

    if (user == null) return;

    await ContactService()
        .saveEmergencyContact(

      uid: user.uid,

      name: name,

      phone: phone,
    );

    await loadContacts();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(

      const SnackBar(
        content: Text(
          "Emergency Contact Saved",
        ),
      ),
    );
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

        centerTitle: true,

        title: const Text(

          "Emergency Contacts",

          style: TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      floatingActionButton:
          FloatingActionButton(

        backgroundColor:
            Colors.red.shade400,

        elevation: 10,

        onPressed: () {

          Navigator.push(
            context,

            MaterialPageRoute(
              builder: (_) =>
                  AddContactScreen(
                onSave:
                    addContact,
              ),
            ),
          );
        },

        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),

      body: SafeArea(
        child: Padding(

          padding:
              const EdgeInsets.all(
            20,
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              const SizedBox(
                height: 10,
              ),

              ShaderMask(

                shaderCallback:
                    (bounds) {

                  return LinearGradient(
                    colors: [

                      Colors.white,

                      Colors.red
                          .shade300,
                    ],
                  ).createShader(
                    bounds,
                  );
                },

                child: const Text(

                  "SOS Contacts",

                  style: TextStyle(
                    fontSize: 34,
                    fontWeight:
                        FontWeight.bold,
                    color:
                        Colors.white,
                  ),
                ),
              )
                  .animate()
                  .fadeIn(
                    duration: 700.ms,
                  )
                  .slideY(
                    begin: 0.2,
                  ),

              const SizedBox(
                height: 12,
              ),

              const Text(

                "Trusted people who will receive\nemergency SOS alerts instantly",

                style: TextStyle(
                  color:
                      Colors.white70,

                  fontSize: 16,
                  height: 1.5,
                ),
              )
                  .animate()
                  .fadeIn(
                    delay: 250.ms,
                  ),

              const SizedBox(
                height: 30,
              ),

              Expanded(

                child:
                    contacts.isEmpty

                        ? Center(
                            child: Column(

                              mainAxisAlignment:
                                  MainAxisAlignment.center,

                              children: [

                                Icon(
                                  Icons.contacts,
                                  size: 90,
                                  color: Colors
                                      .red
                                      .withValues(
                                        alpha: 0.5,
                                      ),
                                ),

                                const SizedBox(
                                  height: 18,
                                ),

                                const Text(

                                  "No Emergency Contacts",

                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight:
                                        FontWeight.bold,
                                    color:
                                        Colors.white,
                                  ),
                                ),

                                const SizedBox(
                                  height: 8,
                                ),

                                const Text(

                                  "Add trusted contacts\nfor emergency alerts",

                                  textAlign:
                                      TextAlign.center,

                                  style: TextStyle(
                                    color:
                                        Colors.white54,

                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          )

                        : ListView.builder(

                            physics:
                                const BouncingScrollPhysics(),

                            itemCount:
                                contacts.length,

                            itemBuilder:
                                (
                              context,
                              index,
                            ) {

                              final contact =
                                  contacts[index];

                              return Container(

                                margin:
                                    const EdgeInsets.only(
                                  bottom: 18,
                                ),

                                padding:
                                    const EdgeInsets.all(
                                  20,
                                ),

                                decoration:
                                    BoxDecoration(

                                  gradient:
                                      LinearGradient(

                                    begin:
                                        Alignment.topLeft,

                                    end:
                                        Alignment.bottomRight,

                                    colors: [

                                      Colors.white
                                          .withValues(
                                        alpha: 0.05,
                                      ),

                                      const Color(
                                        0xFF141824,
                                      ),
                                    ],
                                  ),

                                  borderRadius:
                                      BorderRadius.circular(
                                    24,
                                  ),

                                  border: Border.all(

                                    color:
                                        Colors.white
                                            .withValues(
                                      alpha: 0.08,
                                    ),
                                  ),

                                  boxShadow: [

                                    BoxShadow(

                                      color:
                                          Colors.red
                                              .withValues(
                                        alpha: 0.06,
                                      ),

                                      blurRadius: 18,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),

                                child: Row(
                                  children: [

                                    Container(

                                      width: 60,
                                      height: 60,

                                      decoration:
                                          BoxDecoration(

                                        shape:
                                            BoxShape.circle,

                                        gradient:
                                            LinearGradient(

                                          colors: [

                                            Colors.red
                                                .shade400,

                                            Colors.red
                                                .shade900,
                                          ],
                                        ),
                                      ),

                                      child: const Icon(
                                        Icons.person,
                                        color:
                                            Colors.white,

                                        size: 30,
                                      ),
                                    ),

                                    const SizedBox(
                                      width: 18,
                                    ),

                                    Expanded(
                                      child: Column(

                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,

                                        children: [

                                          Text(

                                            contact["name"],

                                            style:
                                                const TextStyle(

                                              fontSize: 20,

                                              fontWeight:
                                                  FontWeight.bold,

                                              color:
                                                  Colors.white,
                                            ),
                                          ),

                                          const SizedBox(
                                            height: 6,
                                          ),

                                          Text(

                                            contact["phone"],

                                            style:
                                                const TextStyle(

                                              color:
                                                  Colors.white70,

                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    IconButton(

                                      onPressed: () {

                                        setState(() {

                                          contacts.removeAt(
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
                              )
                                  .animate()
                                  .fadeIn(
                                    duration: 500.ms,
                                  )
                                  .slideY(
                                    begin: 0.15,
                                  );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}