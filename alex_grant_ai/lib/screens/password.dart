  import 'package:alex_grant_ai/screens/otp.dart';
  import 'package:flutter/material.dart';
  import 'package:http/http.dart' as http;
  import 'dart:convert';

  String userEmail = ''; // Declare the global email variable
  String userName = ''; // Declare the global email variable
  String userId = ''; // Declare the global email variable

  class Password extends StatelessWidget {
    const Password({super.key});

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false, // Remove the debug banner
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
        ),
        home: Scaffold(
          body: SingleChildScrollView( // Wrap the content with SingleChildScrollView
            child: PasswordState(username:'',email: '',),
          ),
        ),
      );
    }
  }

  class PasswordState extends StatefulWidget {
    final String email; // Declare the email parameter
    final String username; // Declare the email parameter
    // const PasswordState({super.key});
    PasswordState({required this.username,required this.email});

    @override
    _PasswordState createState() => _PasswordState();
  }

  class _PasswordState extends State<PasswordState> {
    final TextEditingController passwordController = TextEditingController();
    bool _isPasswordVisible = false; // Track password visibility
    bool _isLoading = false; // Track password visibility

    @override
    void initState() {
      super.initState();

      userEmail = widget.email; // Assign the email to global variable
      userName=widget.username;
    }

    Future<void> _createUser(String password) async {
      setState(() {
        _isLoading = true;
      });

      const String apiUrl = "http://localhost:5000/user/create-user";
      print('password $password userName $userName userEmail $userEmail');

      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "username":userName, // passed from previous screen
            "email": userEmail, // passed from previous screen
            "password": password, // entered password
          }),
        );


        setState(() {
          _isLoading = false;
        });

        // Handle response
        if (response.statusCode == 200 || response.statusCode == 201) {
          final responseData = jsonDecode(response.body);
          userId=responseData["user"]["userId"];
          print('userId $userId');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseData["message"])),
          );
          Navigator.pop(context);
          _showAccountCreatedSuccessfulModal(context);
          // Navigator.pop(context); // Navigate back or to the next screen after signup
        } else {
          final errorData = jsonDecode(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorData["message"])),
          );
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        print('Error during user creation: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("An error occurred while creating the user")),
        );
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold( // Keep Material here for transparent background
        body: SingleChildScrollView(
          child: Material(
            color: Colors.transparent,
            child: Column(  // Column expects a list of children
              children: [
                Container(
                    width: MediaQuery.of(context).size.width, // Full width of the screen
                    height: MediaQuery.of(context).size.height, // Full height of the screen
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(color: const Color(0xFF222222)), // Container color
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/rectangle_background.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 23.50,
                          top: 56,
                          child: Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                ),
                                const SizedBox(width: 51),
                                Text(
                                  'Create a Password',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: 'Euclid Circular A',
                                    fontWeight: FontWeight.w500,
                                    height: 1.11,
                                    letterSpacing: -0.20,
                                    decoration: TextDecoration.none,  // Add this line to remove any underline
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 18,
                          top: 134,
                          child: Container(
                            height: 120,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 320,
                                  height: 88,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          'Password',
                                          style: TextStyle(
                                            color: Color(0xFFF8FAFC),
                                            fontSize: 16,
                                            fontFamily: 'Euclid Circular A',
                                            fontWeight: FontWeight.w500,
                                            height: 1.50,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Container(
                                        width: 350,
                                        height: 56,
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                        decoration: ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(width: 1, color: Colors.white),
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 24,
                                              height: 24,
                                              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  // Replace the Icon with an Image.asset widget
                                                  Container(
                                                    width: 18,  // Adjust the width and height to match the size of your icon
                                                    height: 18,
                                                    clipBehavior: Clip.antiAlias,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle, // If you want the image to be circular, use BoxShape.circle
                                                    ),
                                                    child: Image.asset(
                                                      'assets/images/fi_lock.png', // Replace with your image path
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: TextField(
                                                controller: passwordController,
                                                obscureText: !_isPasswordVisible, // Toggle password visibility
                                                decoration: InputDecoration(
                                                  hintText: 'Your Password',
                                                  hintStyle: TextStyle(
                                                      color: Color(0xFFF8FAFC),
                                                      fontSize: 16,
                                                      fontFamily: 'Euclid Circular A'
                                                  ),
                                                  border: InputBorder.none,
                                                  contentPadding: EdgeInsets.only(bottom: 10, left: 12),
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              icon: ColorFiltered(
                                                colorFilter: ColorFilter.mode(
                                                  Color(0xFF756878), // The color you want to apply to the image
                                                  BlendMode.srcIn,   // Apply the color to the image while keeping transparency intact
                                                ),
                                                child: Image.asset(
                                                  _isPasswordVisible
                                                      ? 'assets/images/u_eye.png' // Image for visible password
                                                      : 'assets/images/fi_eye-off.png', // Image for hidden password
                                                  width: 24, // Adjust width if needed
                                                  height: 24, // Adjust height if needed
                                                ),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _isPasswordVisible = !_isPasswordVisible;
                                                });
                                              },
                                            )


                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Use a capital letter, a number , and 6 or more characters.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFFE4E6EB),
                                    fontSize: 14,
                                    fontFamily: 'Euclid Circular A',
                                    fontWeight: FontWeight.w400,
                                    height: 1.14,
                                    letterSpacing: -0.40,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 348, // Keep the vertical position as it is
                          child: Align(
                            alignment: Alignment.center, // Center the button horizontally
                            child: Material(
                              color: Colors.transparent, // Makes the Material background transparent
                              child: Container(
                                width: 320,
                                height: 56,
                                decoration: ShapeDecoration(
                                  color: Color(0xFF5E216D), // Set background color for button using hex color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16), // Rounded corners
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () async {
                                    final String password = passwordController.text.trim();
                                    if (password.isEmpty) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text("Please enter a password")),
                                      );
                                      return;
                                    }
                                    // Show the terms modal and pass the password
                                    _showTermsModal(
                                      context,
                                      password,
                                          () {
                                        // Callback function that is triggered after terms acceptance
                                        _createUser(password); // Call _createUser once terms are accepted
                                      },
                                    );
                                    // Add your onTap logic here
                                  },
                                  child: Center(
                                    child: Text(
                                      'Next',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Euclid Circular A',
                                        fontWeight: FontWeight.w600,
                                        height: 1,
                                        letterSpacing: -0.40,
                                        decoration: TextDecoration.none,  // Remove any underline
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  // Function to show the modal
  void _showTermsModal(BuildContext context, String password, Function onAccept) {

    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing the modal by tapping outside
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent, // Transparent background
          child: Center( // Center the modal in the middle of the screen
            child: Container(
              width: 350,
              height: 450,
              padding: const EdgeInsets.all(32),
              decoration: ShapeDecoration(
                color: Color(0xFF161117),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'By signing up, you agree to our ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontFamily: 'Euclid Circular A',
                              fontWeight: FontWeight.w600,
                              height: 1.43,
                            ),
                          ),
                          TextSpan(
                            text: 'Terms of Service',
                            style: TextStyle(
                              color: Color(0xFFA45AD5),
                              fontSize: 21,
                              fontFamily: 'Euclid Circular A',
                              fontWeight: FontWeight.w600,
                              height: 1.43,
                            ),
                          ),
                          TextSpan(
                            text: ' and',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontFamily: 'Euclid Circular A',
                              fontWeight: FontWeight.w600,
                              height: 1.43,
                            ),
                          ),
                          TextSpan(
                            text: ' Privacy Policy',
                            style: TextStyle(
                              color: Color(0xFFA45AD5),
                              fontSize: 21,
                              fontFamily: 'Euclid Circular A',
                              fontWeight: FontWeight.w600,
                              height: 1.43,
                            ),
                          ),
                          TextSpan(
                            text: '.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontFamily: 'Euclid Circular A',
                              fontWeight: FontWeight.w600,
                              height: 1.43,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog if they accept
                      onAccept(); // Call the callback to trigger the creation

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF5E216D), // Set background color here
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                    ),
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  void _showAccountCreatedSuccessfulModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing the modal by tapping outside
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent, // Transparent background
          child: Center( // Center the modal in the middle of the screen
            child: Container(
              width: 400,
              height: 450,
              padding: const EdgeInsets.all(32),
              decoration: ShapeDecoration(
                color: Color(0xFF161117),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Column(

                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between text and button
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 200), // Add space on top of the text
                  SizedBox(
                    width: 240,

                    child: Text(
                      'Your Account has been successfully created!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontFamily: 'Euclid Circular A',
                        fontWeight: FontWeight.w600,
                        height: 1.43,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the modal
                      _showConfirmEmailModal(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF5E216D), // Set background color here
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                    ),
                    child: Text(
                      'Login to Your Account',
                      textAlign: TextAlign.center, // Center-align the text
                      overflow: TextOverflow.ellipsis, // Handle overflow with an ellipsis
                      maxLines: 1, // Ensure the text stays on one line
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Euclid Circular A',
                        fontWeight: FontWeight.w600,
                        height: 1,
                        letterSpacing: -0.40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  void _showConfirmEmailModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true, // Allow closing the dialog by tapping outside
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: 350,
            decoration: BoxDecoration(
              color: Color(0xFF161117),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsets.all(16),
            child: ConfirmEmail(),
          ),
        );
      },
    );
  }

  class ConfirmEmail extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20), // Adds space from the top
            child: Text(
              'Confirm Email Address',
              style: TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontFamily: 'Euclid Circular A',
                fontWeight: FontWeight.w600,
                height: 1.14,
                decoration: TextDecoration.none, // Ensures no underline
              ),
            ),
          ),

          SizedBox(height: 8),
          Text(
            userEmail,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Euclid Circular A',
              fontWeight: FontWeight.w600,
              height: 1.25,
              decoration: TextDecoration.none,  // Add this line to remove any underline
            ),
          ),
          SizedBox(height: 16),
          Text(
            'To complete your setup, please confirm your email address.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFE4E6EB),
              fontSize: 16,
              fontFamily: 'Euclid Circular A',
              fontWeight: FontWeight.w400,
              height: 1.38,
              decoration: TextDecoration.none,  // Add this line to remove any underline
            ),
          ),
          SizedBox(height: 32),
          SizedBox(
            width: 250,
            height: 50,// Specify the desired width
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close modal
                _showVerifyIdentityModal(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF5E216D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'Looks Good',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Euclid Circular A',
                  fontWeight: FontWeight.w600,
                  height: 1,
                  letterSpacing: -0.40,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(bottom: 20), // Adds 20 pixels of space below
            child: Text(
              'Change Email Address',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFE4E6EB),
                fontSize: 16,
                fontFamily: 'Euclid Circular A',
                fontWeight: FontWeight.w400,
                height: 1.38,
                decoration: TextDecoration.none, // Ensures no underline
              ),
            ),
          ),

        ],
      );
    }
  }
  void _showVerifyIdentityModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true, // Allow closing the dialog by tapping outside
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: 350,
            decoration: BoxDecoration(
              color: Color(0xFF161117),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsets.all(16),
            child: VerifyIdentity(),
          ),
        );
      },
    );
  }
  class VerifyIdentity extends StatelessWidget {
    Future<void> otpApi(BuildContext context) async {
      const String apiUrl = 'http://localhost:5000/otp/generate-otp'; // Replace with your API URL
      final otp = "123456"; // Replace this with your OTP generation logic
      final user_Id = userId; // Replace with actual user ID
      final sessionId = "exampleSessionId"; // Replace with actual session ID

      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "userId": userId,
            "email": userEmail,
            "sessionId": sessionId,
            "otp": otp,
          }),
        );

        if (response.statusCode == 201) {
          // API call successful
          final responseBody = jsonDecode(response.body);
          print("OTP generated successfully: ${responseBody['data']}");

          // Navigate to OTP verification page
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OtpState(email: userEmail),
            ),
          );
        } else {
          // API returned an error
          final responseBody = jsonDecode(response.body);
          print("Error: ${responseBody['message']}");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${responseBody['message']}")),
          );
        }
      } catch (error) {
        // Handle network or other errors
        print("Error: $error");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to generate OTP. Please try again.")),
        );
      }
    }

    @override
    Widget build(BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20), // Adds space from the top
            child: Text(
              'Verify your identity',
              style: TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontFamily: 'Euclid Circular A',
                fontWeight: FontWeight.w600,
                height: 1.14,
                decoration: TextDecoration.none, // Ensures no underline
              ),
            ),
          ),

          SizedBox(height: 12),
          Text(
            'To continue, please verify your account. We have sent a verification code to'
                +userEmail,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFE4E6EB),
              fontSize: 16,
              fontFamily: 'Euclid Circular A',
              fontWeight: FontWeight.w400,
              height: 1.38,
              decoration: TextDecoration.none,  // Add this line to remove any underline
            ),

          ),
          SizedBox(height: 32),
          SizedBox(
            width: 250,
            height: 50,// Specify the desired width
            child: ElevatedButton(
              onPressed: () async {
                // Show a loading indicator if needed
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return Center(child: CircularProgressIndicator());
                  },
                );

                // Call the OTP API and wait for it to complete
                await otpApi(context);

                // Close the loading dialog after the API call
                Navigator.of(context).pop(); // This closes the loading indicator
              }
              ,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF5E216D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'Continue',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Euclid Circular A',
                  fontWeight: FontWeight.w600,
                  height: 1,
                  letterSpacing: -0.40,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),


        ],
      );
    }
  }
