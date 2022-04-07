import 'package:diary_app/common/header.dart';
import 'package:diary_app/common/home.dart';
import 'package:diary_app/user/register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const login());
}

class login extends StatefulWidget {
  const login({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<login> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  // firebase
  //final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String errorMessage;

  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        },
        onSaved: (value) {
          passwordController.text = value;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color.fromARGB(255, 36, 109, 218),
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signIn(emailController.text, passwordController.text);
          },
          child: Text(
            "Login",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 200,
                        child: Image.asset(
                          "assets/logo.png",
                          fit: BoxFit.contain,
                        )),
                    SizedBox(height: 45),
                    emailField,
                    SizedBox(height: 25),
                    passwordField,
                    SizedBox(height: 35),
                    loginButton,
                    SizedBox(height: 15),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Don't have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => register()));
                            },
                            child: Text(
                              "SignUp",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 36, 109, 218),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          )
                        ])
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // login function
  void signIn(String email, String password) async {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => home()));
    // if (_formKey.currentState!.validate()) {
    //   try {
    //     await _auth
    //         .signInWithEmailAndPassword(email: email, password: password)
    //         .then((uid) => {
    //               Fluttertoast.showToast(msg: "Login Successful"),
    //               Navigator.of(context).pushReplacement(
    //                   MaterialPageRoute(builder: (context) => HomeScreen())),
    //             });
    //   } on FirebaseAuthException catch (error) {
    //     switch (error.code) {
    //       case "invalid-email":
    //         errorMessage = "Your email address appears to be malformed.";

    //         break;
    //       case "wrong-password":
    //         errorMessage = "Your password is wrong.";
    //         break;
    //       case "user-not-found":
    //         errorMessage = "User with this email doesn't exist.";
    //         break;
    //       case "user-disabled":
    //         errorMessage = "User with this email has been disabled.";
    //         break;
    //       case "too-many-requests":
    //         errorMessage = "Too many requests";
    //         break;
    //       case "operation-not-allowed":
    //         errorMessage = "Signing in with Email and Password is not enabled.";
    //         break;
    //       default:
    //         errorMessage = "An undefined Error happened.";
    //     }
    //     Fluttertoast.showToast(msg: errorMessage!);
    //     print(error.code);
    //   }
    // }
  }
}
//-----------------
// // ignore: camel_case_types
// class login extends StatelessWidget {
//   const login({Key? key}) : super(key: key);

//   double getSmallDiameter(BuildContext context) =>
//       MediaQuery.of(context).size.width * 2 / 3;
//   double getBiglDiameter(BuildContext context) =>
//       MediaQuery.of(context).size.width * 7 / 8;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFEEEEEE),
//       body: Stack(
//         children: <Widget>[
//           const header(),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: ListView(
//               children: <Widget>[
//                 Container(
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       //border: Border.all(color: Colors.grey),
//                       borderRadius: BorderRadius.circular(10)),
//                   margin: const EdgeInsets.fromLTRB(20, 260, 20, 10),
//                   padding: const EdgeInsets.fromLTRB(10, 0, 10, 25),
//                   child: Column(
//                     children: <Widget>[
//                       TextField(
//                         decoration: InputDecoration(
//                             icon: const Icon(
//                               Icons.email,
//                               color: Color.fromARGB(255, 36, 109, 218),
//                             ),
//                             focusedBorder: UnderlineInputBorder(
//                                 borderSide:
//                                     BorderSide(color: Colors.grey.shade100)),
//                             labelText: "Email",
//                             enabledBorder: InputBorder.none,
//                             labelStyle: const TextStyle(color: Colors.grey)),
//                       ),
//                       TextField(
//                         obscureText: true,
//                         decoration: InputDecoration(
//                             icon: const Icon(
//                               Icons.vpn_key,
//                               color: Color.fromARGB(255, 36, 109, 218),
//                             ),
//                             focusedBorder: UnderlineInputBorder(
//                                 borderSide:
//                                     BorderSide(color: Colors.grey.shade100)),
//                             labelText: "Password",
//                             enabledBorder: InputBorder.none,
//                             labelStyle: const TextStyle(color: Colors.grey)),
//                       )
//                     ],
//                   ),
//                 ),
//                 Align(
//                     alignment: Alignment.centerRight,
//                     child: Container(
//                         margin: const EdgeInsets.fromLTRB(0, 0, 20, 10),
//                         child: const Text(
//                           "FORGOT PASSWORD?",
//                           style: TextStyle(
//                               color: Color.fromARGB(255, 36, 109, 218),
//                               fontSize: 11),
//                         ))),
//                 Container(
//                   margin: const EdgeInsets.fromLTRB(20, 10, 20, 30),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width * 0.5,
//                         height: 40,
//                         child: Container(
//                           child: Material(
//                             borderRadius: BorderRadius.circular(20),
//                             color: Colors.transparent,
//                             child: InkWell(
//                               borderRadius: BorderRadius.circular(20),
//                               splashColor:
//                                   const Color.fromARGB(255, 209, 221, 224),
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => const home()),
//                                 );
//                               },
//                               child: const Center(
//                                 child: Text(
//                                   "Login",
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w700),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20),
//                               gradient: const LinearGradient(
//                                   colors: [
//                                     Color.fromARGB(255, 126, 212, 247),
//                                     Color.fromARGB(255, 36, 109, 218)
//                                   ],
//                                   begin: Alignment.topCenter,
//                                   end: Alignment.bottomCenter)),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const <Widget>[
//                     Text(
//                       "DON'T HAVE AN ACCOUNT ? ",
//                       style: TextStyle(
//                           fontSize: 11,
//                           color: Colors.grey,
//                           fontWeight: FontWeight.w500),
//                     )
//                   ],
//                 ),
//                 InkWell(
//                   borderRadius: BorderRadius.circular(20),
//                   splashColor: const Color.fromARGB(255, 209, 221, 224),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => register()),
//                     );
//                   },
//                   child: const Center(
//                     child: Text(
//                       "Register",
//                       style: TextStyle(
//                           color: Color.fromARGB(255, 36, 109, 218),
//                           fontWeight: FontWeight.w700),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
