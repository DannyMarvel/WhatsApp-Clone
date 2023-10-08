import 'package:danny_chats/common/widgets2/custom_button.dart';
import 'package:danny_chats/common/widgets2/utils/utils.dart';
import 'package:danny_chats/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/auth_controller.dart';

//Now we convert the statefulWidget to consumer StatefulWidget so we can use Riverpod
class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phoneController = TextEditingController();
  Country? country;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneController.dispose();
  }

  void pickCountry() {
    showCountryPicker(
      context: context,
      showPhoneCode:
          true, // optional. Shows phone code before the country name.
      onSelect: (Country _country) {
        //When ever a country is selected then we,
        setState(() {
          country = _country;
        });
      },
    );
  }
//Whenever the user clicks next after selecting a country
//We need to call the AuthController, which will inturn call the AuthRepository
//Then we communicate with firebase

  void sendPhoneNumber() {
    String phoneNumber = phoneController.text.trim();
    if (country != null && phoneNumber.isNotEmpty) {
//We also need to add the country code to firebae
      ref
          .read(authControllerProvider)
          .signInWithPhone(context, '+${country!.phoneCode}$phoneNumber');
//.read works like Provider.of(context, listen:false)
//Provider ref => Interact provider with provider
//Widget ref => makes widget interact with provider
    } else {
      showSnackBar(context: context, content: 'Fill out all the fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter your phone number'),
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Danny WhatsApp will need to verify your phone number'),
              SizedBox(
                height: 10,
              ),
              //Because our customButton uses elevated button, we need a textButton here
              TextButton(
      //We did'nt do this ()=> because we do not pass in arguements
                onPressed: pickCountry,
                child: Text('Pick Country'),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  if (country != null) Text('+${country!.phoneCode}'),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: size.width * 0.7,
                    child: TextField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        hintText: 'phone Number',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.6),
              SizedBox(
                child: CustomButton(
                  text: 'NEXT',
                  onPressed: sendPhoneNumber,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
