import 'package:flutter/material.dart';
import '../widgets/entry_field.dart';
import '../widgets/flat_button.dart';

class ForgetPassword extends StatefulWidget {
  // Not using state yet but will in future?
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  // Create stateful widget including build context
  // Not mounted yet - just calls build with state encapsulated
  _ForgetPassword createState() => _ForgetPassword();
}

class _ForgetPassword extends State<ForgetPassword> {
  // Define property types
  late TextEditingController _emailController;

  @override
  @mustCallSuper
  void initState() {
    // Initializes state and mounts - data, properties
    // Subscribes to state changes
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  @mustCallSuper
  void dispose() {
    // Permanently remove everything at end of lifecycle (after unmount)
    _emailController.dispose();
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
          title: const Text('Forget Password'),
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).primaryColorDark,
          elevation: 0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Center(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.fromLTRB(0, 150, 0, 25),
                child: Text(
                  'Forget Password',
                  // Default theme text style, but theme changed from gray
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: Theme.of(context).primaryColorDark),
                )),
            Text(
              'Enter your email address below to receive password reset instructions.',
              textAlign: TextAlign.center,
              // Default theme text style, but color changed from black
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Theme.of(context).primaryColorLight, height: 1.25),
            ),
            CustomEntryField(
              hint: 'Enter email',
              controller: _emailController,
              isPassword: false,
            ),
            CustomFlatButton(
              onPressed: () {},
              label: 'Sign up',
            ),
          ],
        ))));
  }
}
