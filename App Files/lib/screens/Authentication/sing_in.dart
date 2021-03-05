import 'package:ShareApp/screens/Authentication/Loading.dart';
import 'package:ShareApp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:ShareApp/constants/color_constant.dart';
import 'package:ShareApp/constants/Fade_animation.dart';
// import 'package:flutter/src/widgets/focus_scope.dart';
// class SignIn extends StatefulWidget {
//   final Function toggelView;
//   SignIn({this.toggelView});

//   @override
//   _SignInState createState() => _SignInState();
// }

// class _SignInState extends State<SignIn> {
//   final AuthService _auth = AuthService();
//   final _formKey = GlobalKey<FormState>();
//   bool loading = false;

//   String email = '';
//   String password = '';
//   String error = '';

//   @override
//   Widget build(BuildContext context) {
//     return loading
//         ? Loading()
//         : Scaffold(
//             appBar: AppBar(
//               title: Text('Sign In'),
//               elevation: 0.0,
//               actions: <Widget>[
//                 FlatButton.icon(
//                   icon: Icon(Icons.person, color: Colors.white),
//                   label: Text(
//                     'Register',
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.white,
//                     ),
//                   ),
//                   onPressed: () {
//                     widget.toggelView();
//                   },
//                 )
//               ],
//             ),
//             body: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Container(
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     children: <Widget>[
//                       SizedBox(
//                         height: 20.0,
//                       ),
//                       TextFormField(
//                         decoration: textInputDecoration.copyWith(
//                             hintText: 'Email', labelText: 'Email'),
//                         validator: (val) =>
//                             val.isEmpty ? 'Enter an email' : null,
//                         onChanged: (val) {
//                           // get email....
//                           setState(() => email = val);
//                         },
//                       ),
//                       SizedBox(
//                         height: 20.0,
//                       ),
//                       TextFormField(
//                         decoration: textInputDecoration.copyWith(
//                             hintText: 'Password', labelText: 'Password'),
//                         validator: (val) => val.length < 6
//                             ? 'Enter a password 6 chars long'
//                             : null,
//                         obscureText: true,
//                         onChanged: (val) {
//                           // get password....
//                           setState(() => password = val);
//                         },
//                       ),
//                       SizedBox(
//                         height: 20.0,
//                       ),
//                       RaisedButton(
//                           child: Text('Sign In'),
//                           onPressed: () async {
//                             if (_formKey.currentState.validate()) {
//                               setState(() => loading = true);
//                               dynamic result = await _auth
//                                   .signInWithEmailAndPassword(email, password);
//                               if (result == null) {
//                                 setState(() => error =
//                                     'Could not signIn with those credentials');
//                                 loading = false;
//                               }
//                             }
//                           }),
//                       SizedBox(
//                         height: 20.0,
//                       ),
//                       Text(error),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//   }
// }

class SignIn extends StatefulWidget {
  final Function toggelView;
  SignIn({this.toggelView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool hide = true;
  String email = '';
  String password = '';
  String error = '';
  TextEditingController emailOne = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 300,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/background.png'),
                                fit: BoxFit.fill)),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              left: 30,
                              width: 80,
                              height: 200,
                              child: FadeAnimation(
                                  1,
                                  Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/light-1.png'))),
                                  )),
                            ),
                            Positioned(
                              left: 140,
                              width: 80,
                              height: 150,
                              child: FadeAnimation(
                                  1.3,
                                  Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/light-2.png'))),
                                  )),
                            ),
                            Positioned(
                              right: 40,
                              top: 40,
                              width: 80,
                              height: 150,
                              child: FadeAnimation(
                                  1.5,
                                  Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/clock.png'))),
                                  )),
                            ),
                            Positioned(
                              child: FadeAnimation(
                                  1.6,
                                  Container(
                                    margin: EdgeInsets.only(top: 50),
                                    child: Center(
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Column(
                          children: <Widget>[
                            FadeAnimation(
                                1.8,
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color.fromRGBO(
                                                143, 148, 251, .2),
                                            blurRadius: 20.0,
                                            offset: Offset(0, 10))
                                      ]),
                                  child: Column(
                                    children: <Widget>[
                                      // IconButton(icon: Icon(Icons.hid), onPressed: null)
                                      Container(
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey[100]))),
                                        child: TextFormField(
                                          controller: emailOne,
                                          decoration: InputDecoration(
                                              suffix: IconButton(
                                                icon: Icon(Icons.clear),
                                                onPressed: () {
                                                  setState(() {
                                                    emailOne.clear();
                                                  });
                                                },
                                              ),
                                              border: InputBorder.none,
                                              hintText: "Email",
                                              hintStyle: TextStyle(
                                                  color: Colors.grey[400])),
                                          validator: (val) => val.isEmpty
                                              ? 'Enter an email'
                                              : null,
                                          onChanged: (val) {
                                            // get email....
                                            setState(() => email = val);
                                          },
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          validator: (val) => val.length < 6
                                              ? 'Enter a password 6 chars long'
                                              : null,
                                          obscureText: hide,
                                          onChanged: (val) {
                                            // get password....
                                            setState(() => password = val);
                                          },
                                          decoration: InputDecoration(
                                              suffix: IconButton(
                                                icon: hide
                                                    ? Icon(Icons.remove_red_eye)
                                                    : Icon(Icons.close),
                                                onPressed: () {
                                                  hide = !hide;
                                                  setState(() {});
                                                },
                                              ),
                                              border: InputBorder.none,
                                              hintText: "Password",
                                              hintStyle: TextStyle(
                                                  color: Colors.grey[400])),
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                            SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() => loading = true);
                                  print(email);
                                  dynamic result =
                                      await _auth.signInWithEmailAndPassword(
                                          email, password);
                                  if (result == null) {
                                    loading = false;
                                    setState(() => error =
                                        'Could not signIn with those credentials');
                                  } else {
                                    loading = false;
                                    setState(() =>
                                        error = 'Please verify your email');
                                  }
                                }
                              },
                              child: FadeAnimation(
                                  2,
                                  Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(colors: [
                                          Color.fromRGBO(143, 148, 251, 1),
                                          Color.fromRGBO(143, 148, 251, .6),
                                        ])),
                                    child: Center(
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width:
                                      (MediaQuery.of(context).size.width - 80),
                                  child: Center(
                                    child: FadeAnimation(
                                      1.5,
                                      GestureDetector(
                                        // ON tap funtion for forget password
                                        onTap: () {
                                          _showResetPssword();
                                        },
                                        child: Text(
                                          "Forget Password",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  143, 148, 251, 1)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width:
                                      (MediaQuery.of(context).size.width / 2 -
                                          30),
                                  child: Center(
                                    child: FadeAnimation(
                                        1.5,
                                        GestureDetector(
                                          onTap: () {
                                            widget.toggelView();
                                          },
                                          child: Text(
                                            "Register",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    143, 148, 251, 1)),
                                          ),
                                        )),
                                  ),
                                ),
                                // Tab(
                                //   icon: Container(
                                //     child:
                                //         Image.asset('assets/images/google.jpg'),
                                //     height: 50,
                                //     width: 50,
                                //   ),
                                // ),

                                // ON tap function for google and facebook images
                                FadeAnimation(
                                  1.5,
                                  GestureDetector(
                                      child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            // color: Colors.black,
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/google.jpg"),
                                                fit: BoxFit.cover),
                                            //  child: Text("clickMe") // button text
                                          )),
                                      onTap: () async {
                                        // Sign in through google
                                        setState(() => loading = true);
                                        dynamic result =
                                            await _auth.signInWithGoogle();
                                        //print(result);
                                        print(result.toString());
                                        if (result == null) {
                                          setState(() => loading = false);
                                        } else {
                                          print("we get the google user");
                                        }
                                      }),
                                ),
                                SizedBox(width: 10),
                                FadeAnimation(
                                  1.5,
                                  GestureDetector(
                                    onTap: () async {
                                      // Sign in through google
                                      setState(() => loading = true);
                                      dynamic result =
                                          await _auth.signInWithGoogle();
                                      //print(result);
                                      print(result.toString());
                                      if (result == null) {
                                        setState(() => loading = false);
                                      } else {
                                        print("we get the google user");
                                      }
                                    },
                                    child: Text(
                                      "Sign In with Google",
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(143, 148, 251, 1)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }

  void _showResetPssword() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: <Widget>[
              Text("Forget Password"),
              Spacer(
                flex: 2,
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Center(
                child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    hintText: email,
                  ),
                  onChanged: (val) {
                    email = val;
                  },
                ),
                RaisedButton(
                  child: Text('Send Password Reset Link'),
                  onPressed: () {
                    _auth.resetPassword(email);
                  },
                )
              ],
            )),
          ),
        );
      },
    );
  }
}
