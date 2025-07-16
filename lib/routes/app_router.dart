import 'package:flutter/material.dart';
import 'package:lafyuu/models/enums/Gender.dart';
import 'package:lafyuu/views/main/client/main_navigation_page.dart';
import 'package:lafyuu/views/main/client/tabScreens/account/pages/account_address_page.dart';
import 'package:lafyuu/views/main/client/tabScreens/account/pages/account_payment_page.dart';
import 'package:lafyuu/views/main/client/tabScreens/account/pages/geolocation/account_geolocation_page.dart';
import 'package:lafyuu/views/main/client/tabScreens/account/pages/order/account_order_page.dart';
import 'package:lafyuu/views/main/client/tabScreens/account/pages/order/order_detail_page.dart';
import 'package:lafyuu/views/main/client/tabScreens/account/pages/profile/account_profile_page.dart';
import 'package:lafyuu/views/main/client/tabScreens/account/pages/profile/edit/edit_birth_date_page.dart';
import 'package:lafyuu/views/main/client/tabScreens/account/pages/profile/edit/edit_email_page.dart';
import 'package:lafyuu/views/main/client/tabScreens/account/pages/profile/edit/edit_full_name_page.dart';
import 'package:lafyuu/views/main/client/tabScreens/account/pages/profile/edit/edit_gender_page.dart';
import 'package:lafyuu/views/main/client/tabScreens/account/pages/profile/edit/edit_password_page.dart';
import 'package:lafyuu/views/main/client/tabScreens/account/pages/profile/edit/edit_phone_number_page.dart';
import 'package:lafyuu/views/main/client/tabScreens/cart/cart_success_screen.dart';
import 'package:lafyuu/views/main/client/tabScreens/product/favorite/favorite_screen.dart';
import 'package:lafyuu/views/main/screens/product_detail/product_detail_screen.dart';
import 'package:lafyuu/views/main/seller/seller_navigation_page.dart';
import 'package:lafyuu/views/sign/sign_in_page.dart';
import 'package:lafyuu/views/sign/sign_up_page.dart';
import 'package:lafyuu/views/splash/splash_page.dart';

Route<dynamic> generateAppRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => SplashPage());
    case '/signIn':
      return MaterialPageRoute(builder: (_) => SignInPage());
    case '/signUp':
      return MaterialPageRoute(builder: (_) => SignUpPage());
    case '/main':
      return MaterialPageRoute(builder: (_) => MainNavigationPage());
    case '/sellerMain':
      return MaterialPageRoute(builder: (_) => SellerNavigationPage());
    case '/explore/favorites':
      return MaterialPageRoute(builder: (_) => FavoriteScreen());
    case '/product/details':
      final productId = settings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => ProductDetailScreen(productId: productId),
      );

    case '/account/profile':
      return MaterialPageRoute(builder: (_) => AccountProfilePage());
    case '/account/order':
      return MaterialPageRoute(builder: (_) => AccountOrderPage());
    case '/account/order/details':
      final orderId = settings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => AccountOrderDetailPage(orderId: orderId),
      );
    case '/account/address':
      return MaterialPageRoute(builder: (_) => AccountAddressPage());
    case '/account/payment':
      return MaterialPageRoute(builder: (_) => AccountPaymentPage());
    case '/account/geolocation':
      return MaterialPageRoute(builder: (_) => AccountGeolocationPage());

    case '/edit/fullName':
      final fullName = settings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => EditFullNamePage(currentFullName: fullName),
      );
    case '/edit/gender':
      final gender = settings.arguments as Gender;
      return MaterialPageRoute(
        builder: (_) => EditGenderPage(currentGender: gender),
      );
    case '/edit/birthDate':
      final birthDate = settings.arguments as DateTime;
      return MaterialPageRoute(
        builder: (_) => EditBirthDatePage(currentBirthDate: birthDate),
      );
    case '/edit/email':
      final email = settings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => EditEmailPage(currentEmail: email),
      );
    case '/edit/phoneNumber':
      final phoneNumber = settings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => EditPhoneNumberPage(currentPhoneNumber: phoneNumber),
      );
    case '/edit/password':
      return MaterialPageRoute(builder: (_) => EditPasswordPage());

    case '/cart/successScreen':
      return MaterialPageRoute(builder: (_) => CartSuccessScreen());

    default:
      return MaterialPageRoute(
        builder:
            (_) => const Scaffold(
              body: Center(child: Text('Rota não encontrada')),
            ),
      );
  }
}
