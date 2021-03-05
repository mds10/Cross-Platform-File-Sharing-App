import 'package:ShareApp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:ShareApp/constants/color_constant.dart';
import 'Loading.dart';
import 'package:ShareApp/constants/Fade_animation.dart';

// class Register extends StatefulWidget {
//   final Function toggelView;
//   Register({this.toggelView});

//   @override
//   _RegisterState createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
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
//               title: Text('Register'),
//               elevation: 0.0,
//               actions: <Widget>[
//                 FlatButton.icon(
//                   icon: Icon(Icons.person),
//                   label: Text('Sign In'),
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
//                         decoration:
//                             textInputDecoration.copyWith(hintText: 'Email'),
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
//                         decoration:
//                             textInputDecoration.copyWith(hintText: 'Pasword'),
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
// RaisedButton(
//     child: Text('Register'),
//     onPressed: () async {
//       setState(() => loading = true);
//       if (_formKey.currentState.validate()) {
//         dynamic result =
//             await _auth.registerWithEmailAndPassword(
//                 email, password);
//         if (result == null) {
//           setState(() =>
//               error = 'please supply a valid email');
//           loading = false;
//         }
//       }
//     }),
//                       SizedBox(
//                         height: 20.0,
//                       ),
//                       Text(
//                         error,
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//   }
// }
class Register extends StatefulWidget {
  final Function toggelView;
  Register({this.toggelView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool hide = true;
  String email = '';
  String password = '';
  String passwordVerify = '';
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
                                        "Register",
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
                        padding: EdgeInsets.fromLTRB(30.0, 0, 30, 0),
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
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(8, 0, 8, 0),
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
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          validator: (val) {
                                            if (val.length < 6) {
                                              return "Enter a password 6 chars long";
                                            } else if (password != val) {
                                              return "Paswword Do Not Match";
                                            } else
                                              null;
                                          },
                                          // val.length < 6
                                          //     ? 'Enter a password 6 chars long'
                                          //     : null,
                                          obscureText: hide,
                                          onChanged: (val) {
                                            // get password....
                                            setState(
                                                () => passwordVerify = val);
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
                                              hintText:
                                                  "ReEnter The Same Password",
                                              hintStyle: TextStyle(
                                                  color: Colors.grey[400])),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                              onTap: () async {
                                setState(() => loading = true);
                                if (_formKey.currentState.validate()) {
                                  setState(() => loading = true);
                                  dynamic result =
                                      await _auth.registerWithEmailAndPassword(
                                          email, password);
                                  if (result == null) {
                                    loading = false;
                                    setState(() =>
                                        error = 'please supply a valid email');
                                  } else {
                                    loading = false;
                                    setState(() => error =
                                        'Email Has been send to ' + email);
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
                                        "Register",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 10,
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
                                            "Sign In",
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
                                              fit: BoxFit.cover,
                                            ),
                                            //  child: Text("clickMe") // button text
                                          )),
                                      onTap: () async {
                                        // Sign in through google
                                        setState(() => loading = true);
                                        dynamic result =
                                            await _auth.signInWithGoogle();
                                        print(result);
                                        if (result == null) {
                                          setState(() => loading = false);
                                        }
                                      }),
                                ),
                                SizedBox(width: 10),
                                FadeAnimation(
                                  1.5,
                                  GestureDetector(
                                    onTap: () async {
                                      setState(() => loading = true);
                                      dynamic result =
                                          await _auth.signInWithGoogle();
                                      print(result);
                                      if (result == null) {
                                        setState(() => loading = false);
                                      }
                                    },
                                    child: Text(
                                      "Register with ",
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
}
