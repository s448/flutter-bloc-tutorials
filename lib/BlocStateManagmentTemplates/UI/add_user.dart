import 'dart:developer';

import 'package:bloc_lesson/BlocStateManagmentTemplates/bloc/user_bloc.dart';
import 'package:bloc_lesson/BlocStateManagmentTemplates/bloc/user_events.dart';
import 'package:bloc_lesson/BlocStateManagmentTemplates/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? _selectedGender;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add user"),
      ),
      body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        if (state is AddUserLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is SuccessAddUserState) {
          return Center(
            child:
                Text("User : ${_nameController.text} was Added successfully"),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    if (!RegExp(
                            r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}")
                        .hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<String>(
                  value: _selectedGender,
                  decoration: InputDecoration(labelText: 'Gender'),
                  items: ['Male', 'Female']
                      .map((gender) => DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select a gender' : null,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    log(_nameController.text);
                    log(_emailController.text);
                    log(_selectedGender.toString());
                    context.read<UserBloc>().add(
                          AddUserEvent(
                            name: _nameController.text,
                            email: _emailController.text,
                            gender: _selectedGender,
                          ),
                        );
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
