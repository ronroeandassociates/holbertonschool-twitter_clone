import 'package:flutter/material.dart';
import '../providers/auth_state.dart';
import '../widgets/entry_field.dart';
import '../widgets/flat_button.dart';

class SignUp extends StatefulWidget {
  // Not using state yet but will in future?
  const SignUp({Key? key}) : super(key: key);

  @override
  // Create stateful widget including build context
  // Not mounted yet - just calls build with state encapsulated
  _SignUp createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  // Define property types
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmController;
  final _formKey = GlobalKey<FormState>();

  @override
  @mustCallSuper
  void initState() {
    // Initializes state and mounts - data, properties
    // Subscribes to state changes
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmController = TextEditingController();
  }

  @override
  @mustCallSuper
  void dispose() {
    // Permanently remove everything at end of lifecycle (after unmount)
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Similar to render in React- called when updated, returns widget
    // Rebuilds widget when state (name, email, password, confirm) changes and outdates updated values
    return Scaffold(
        // AppBar contains back button by default
        // Override default color but keep functionality
        appBar: AppBar(
          leading: BackButton(
            color: Theme.of(context).primaryColor,
          ),
          title: const Text('Sign Up'),
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).primaryColorDark,
          elevation: 0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(margin: const EdgeInsets.only(top: 100)),
                        CustomEntryField(
                          hint: 'Enter name',
                          controller: _nameController,
                          isPassword: false,
                        ),
                        CustomEntryField(
                          hint: 'Enter email',
                          controller: _emailController,
                          isPassword: false,
                        ),
                        CustomEntryField(
                          hint: 'Enter password',
                          controller: _passwordController,
                          isPassword: true,
                        ),
                        CustomEntryField(
                          hint: 'Confirm Password',
                          controller: _confirmController,
                          isPassword: true,
                        ),
                        CustomFlatButton(
                          onPressed: () async {
                            String msg = await Auth().attemptSignUp(
                                _nameController.text,
                                _emailController.text,
                                _passwordController.text,
                                _confirmController.text);
                            if (msg == 'Errors.none') {
                              _showMessage(msg);
                              Navigator.pop(context);
                            } else {
                              _showMessage(msg);
                            }
                          },
                          label: 'Sign up',
                        ),
                      ],
                    )))));
  }

  void _showMessage(String msg) {
    Future.delayed(Duration.zero, () {
      final scaffold = ScaffoldMessenger.of(context);
      String text = '';
      if (msg == 'Errors.none') {
        scaffold.showSnackBar(const SnackBar(
          content: Text("Account Created!", textAlign: TextAlign.center),
          backgroundColor: Colors.green,
        ));
      } else {
        if (msg == 'Errors.weakError')
          text = "The password provided is too weak.";
        if (msg == "Errors.matchError")
          text = "The provided passwords don't match";
        if (msg == "Errors.existsError")
          text = "An account already exists with that email.";
        if (msg == "Errors.error")
          text = "Failed to create account! Please try later.";
        scaffold.showSnackBar(SnackBar(
          content: Text(text, textAlign: TextAlign.center),
          backgroundColor: Colors.red,
        ));
      }
    });
  }
}
