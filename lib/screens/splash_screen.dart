import 'package:emoodie_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:emoodie_app/screens/search_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../controllers/auth_controller.dart';
import '../utils/dimensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = true;
  bool displayRestartButton = false;

  @override
  void initState() {
    super.initState();
    getClientToken();
  }

  void getClientToken() async {
    setState(() {
      isLoading = true;
    });

    String? token = await AuthController().getSpotifyToken();

    setState(() {
      isLoading = false;
      displayRestartButton = token == null;
    });

    if (token != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SearchScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Initialize dimensions
    Dimensions.init(context);

    return Scaffold(
      backgroundColor: AppColors.darkBlack,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/spotifylogo.png',
              width: Dimensions.blockSizeHorizontal * 25,
              height: Dimensions.blockSizeVertical * 25,
            ),
            SizedBox(height: Dimensions.blockSizeVertical * 2),
            if (isLoading)
              LoadingAnimationWidget.threeArchedCircle(
                color: AppColors.green,
                size: Dimensions.iconSize24 + 6,
              ),
            if (displayRestartButton)
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Initialization Failed',
                    style: TextStyle(
                      color: Color.fromARGB(122, 231, 231, 231),
                    ),
                  ),
                  SizedBox(height: Dimensions.blockSizeVertical * 2),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const SplashScreen()),
                      );
                    },
                    child: const Text('RESTART',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
