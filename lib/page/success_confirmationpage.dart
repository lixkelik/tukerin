import 'package:tukerin/constant_builder.dart';
import 'package:tukerin/page/widgets/appTheme.dart';

class SuccessfullPage extends StatelessWidget {
  const SuccessfullPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Swapped!\nThank you for your order",
              style: textStyle(25, extraBold, darkFont),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: buttonStyle,
                
                child: Center(
                  child: 
                  Text(
                    'Go Back',
                    style: textStyle(18, semiBold, Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}