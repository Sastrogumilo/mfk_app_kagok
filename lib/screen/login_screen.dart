import 'package:flutter/material.dart';
import 'package:kagok_app/controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isExpanded = false;
  bool _passwordVisible = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    _passwordVisible = !_passwordVisible;
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isExpanded = true;
      });
    });
  }

  Future<void> _login(
      BuildContext context, String username, String password) async {
    await LoginController().login(context, username, password);
  }

  validate(text) {
    if (text.isEmpty || text == Null) {
      return "This field is required";
    }

    if (!text is String) {
      return "This field must be a string";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: const Text('Flutter Demo Home Page'),
          ),
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: 400,
              height: 450, // Adjust height as needed
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedPositioned(
                      top: _isExpanded ? 100 : 200,
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeInOut,
                      child: FractionalTranslation(
                          translation: Offset(0.0, _isExpanded ? -0.5 : 0.0),
                          child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: AnimatedOpacity(
                                duration: const Duration(seconds: 1),
                                opacity: _isExpanded ? 1.0 : 0.0,
                                child: SizedBox(
                                  child: SizedBox(
                                    width: 300,
                                    child: Image.asset(
                                      "assets/images/main_logo.png",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              )))),
                  // child: AnimatedOpacity(
                  //   opacity: _isExpanded ? 1.0 : 0.0,
                  //   duration: const Duration(seconds: 1),
                  //   child: SizedBox(
                  //     width: 300, // Limit the width of the container
                  //     // Limit the height of the container
                  //     child: Image.asset(
                  //       "assets/images/main_logo.png",
                  //       fit: BoxFit.contain,
                  //     ),
                  //   ),
                  // ),

                  AnimatedPositioned(
                    top: _isExpanded ? 250 : 150,
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInOut,
                    child: FractionalTranslation(
                        translation: Offset(0.0, _isExpanded ? -0.5 : 0.0),
                        child: AnimatedOpacity(
                          duration: const Duration(seconds: 1),
                          opacity: _isExpanded ? 1.0 : 0.0,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  width:
                                      300, // Specify width for the TextFormField
                                  child: TextFormField(
                                    controller: usernameController,
                                    validator: (text) => validate(text),
                                    decoration: const InputDecoration(
                                        labelText: 'Username',
                                        hintText: 'Enter your username',
                                        icon: Icon(Icons.people)),
                                  ),
                                ),
                                const SizedBox(
                                    height:
                                        20), // Add space between text fields
                                SizedBox(
                                  width:
                                      300, // Specify width for the TextFormField
                                  child: TextFormField(
                                    obscureText: _passwordVisible,
                                    controller: passwordController,
                                    validator: (text) => validate(text),
                                    decoration: InputDecoration(
                                        labelText: 'Password',
                                        hintText: 'Enter your password',
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _passwordVisible =
                                                    !_passwordVisible;
                                              });
                                            },
                                            icon: Icon(_passwordVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off)),
                                        icon: const Icon(Icons.lock)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                  AnimatedPositioned(
                    top: _isExpanded ? 400 : 250,
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInOut,
                    child: FractionalTranslation(
                      translation: Offset(0.0, _isExpanded ? -0.5 : 0.0),
                      child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SizedBox(
                            width: 250,
                            child: ElevatedButton(
                              onPressed: () async {
                                await _login(context, usernameController.text,
                                    passwordController.text);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shadowColor: Colors.black,
                                elevation: 10.0,
                              ),
                              child: const Text(
                                'Login',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
