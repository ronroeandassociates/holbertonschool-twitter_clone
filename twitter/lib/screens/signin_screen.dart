import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../providers/auth_state.dart';
import './home_screen.dart';
import './signup_screen.dart';
import './forgot_password_screen.dart';
import '../widgets/entry_field.dart';
import '../widgets/flat_button.dart';

class SignIn extends StatefulWidget {
  // Not using state yet but will in future?
  const SignIn({Key? key}) : super(key: key);

  @override
  // Create stateful widget including build context
  // Not mounted yet - just calls build with state encapsulated
  _SignIn createState() => _SignIn();
}

class _SignIn extends State<SignIn> {
  // Define property types
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  // Decorators don't do anything - just for clarity
  @override
  @mustCallSuper
  void initState() {
    // Initializes state and mounts - data, properties
    // Subscribes to state changes
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  @mustCallSuper
  void dispose() {
    // Permanently remove everything at end of lifecycle (after unmount)
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Similar to render in React- called when updated, returns widget
    // Rebuilds widget when state (email, password) changes and outdates updated values
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
                child: Column(
      children: [
        Container(
            margin: const EdgeInsets.fromLTRB(0, 75, 0, 100),
            child: Text(
              'Sign In',
              // Default theme text style, but theme changed from gray
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: Theme.of(context).primaryColorDark),
            )),
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
        CustomFlatButton(
          label: 'Submit',
          onPressed: () async {
            String msg = await Auth()
                .attemptLogin(_emailController.text, _passwordController.text);
            if (msg == 'Errors.none') {
              _showMessage(msg);
              Provider.of<AppState>(context, listen: false).setpageIndex = 0;
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            } else {
              _showMessage(msg);
            }
          },
        ),
        GestureDetector(
            // On tap of text, navigate to sign up screen
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignUp()));
            },
            child: Text(
              'Sign up',
              // Default theme text style, but color changed from black
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Theme.of(context).primaryColor, height: 2.5),
            )),
        GestureDetector(
            // On tap of text, navigate to forget password screen
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ForgetPassword()));
            },
            child: Text(
              'Forget password?',
              // Default theme text style, but color changed from black
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Theme.of(context).primaryColor, height: 2.5),
            )),
      ],
    ))));
  }

  void _showMessage(String msg) {
    Future.delayed(Duration.zero, () {
      final scaffold = ScaffoldMessenger.of(context);
      String text = '';
      if (msg == 'Errors.none') {
        scaffold.showSnackBar(const SnackBar(
          content: Text("Logged in successfully!", textAlign: TextAlign.center),
          backgroundColor: Colors.green,
        ));
      } else {
        if (msg == 'Errors.noUserError') text = "No user found for that email!";
        if (msg == "Errors.wrongError") text = "Wrong password!";
        if (msg == "Errors.error") text = "Failed to Login! Please try later.";
        scaffold.showSnackBar(SnackBar(
          content: Text(text, textAlign: TextAlign.center),
          backgroundColor: Colors.red,
        ));
      }
    });
  }
}
