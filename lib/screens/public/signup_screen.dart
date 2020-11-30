import '../../models/user.dart';
import '../../services/utility/form_utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgets/app_button.dart';
import '../../widgets/text_widget.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();
  TextEditingController _firstNameController,
      _lastNameController,
      __emailController,
      _passwordController;

  bool _isLoading = false;
  bool _isError = false;
  String _errorMsg;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    __emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    __emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _signupFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextWidget(
                hintText: 'First Name',
                suffixIconPath: 'assets/icons/phone.png',
                obscureText: false,
                controller: _firstNameController,
              ),
              TextWidget(
                hintText: 'Last Name',
                suffixIconPath: 'assets/icons/phone.png',
                obscureText: false,
                controller: _lastNameController,
              ),
              TextWidget(
                hintText: 'Email',
                suffixIconPath: 'assets/icons/phone.png',
                obscureText: false,
                controller: __emailController,
              ),
              TextWidget(
                hintText: 'Password',
                suffixIconPath: 'assets/icons/password.png',
                obscureText: true,
                controller: _passwordController,
              ),
              _isError
                  ? Text(
                      _errorMsg,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    )
                  : SizedBox.shrink(),
              AppButton(
                label: _isLoading
                    ? CircularProgressIndicator()
                    : Text(
                        'Sign Up',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                onPressed: () async {
                  User user = User(
                    firstName: _firstNameController.text,
                    lastName: _lastNameController.text,
                    email: __emailController.text,
                    password: _passwordController.text,
                    type: 'user',
                  );
                  setState(() {
                    _isLoading = true;
                    _isError = false;
                    _errorMsg = null;
                  });
                  final String res =
                      await FormUtility.proceed(_signupFormKey, user, 'Signup');
                  if (res != null && res.contains('FAILED')) {
                    setState(() {
                      _isError = true;
                      _errorMsg = res;
                    });
                  }
                  setState(() {
                    _isLoading = false;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
