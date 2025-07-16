enum AppRoutes {
  splash,
  signIn,
  signUp,
  main,
  sellerMain,
  exploreFavorites,
  productDetails,

  accountProfile,
  accountOrders,
  accountOrderDetails,
  accountAddress,
  accountPayment,
  AccountGelocation,

  editFullName,
  editGender,
  editBirthDate,
  editEmail,
  editPhoneNumber,
  editPassword,

  cartSuccessScreen,
}

extension AppRoutesExtension on AppRoutes {
  String get path {
    switch (this) {
      case AppRoutes.splash:
        return '/';
      case AppRoutes.signIn:
        return '/signIn';
      case AppRoutes.signUp:
        return '/signUp';
      case AppRoutes.main:
        return '/main';
      case AppRoutes.sellerMain:
        return '/sellerMain';
      case AppRoutes.exploreFavorites:
        return '/productManager';
      case AppRoutes.productDetails:
        return '/product/details';
      case AppRoutes.accountProfile:
        return '/account/profile';
      case AppRoutes.accountOrders:
        return '/account/order';
      case AppRoutes.accountOrderDetails:
        return '/account/order/details';
      case AppRoutes.accountAddress:
        return '/account/address';
      case AppRoutes.accountPayment:
        return '/account/payment';
      case AppRoutes.AccountGelocation:
        return '/account/geolocation';

      case AppRoutes.editFullName:
        return '/edit/fullName';
      case AppRoutes.editGender:
        return '/edit/gender';
      case AppRoutes.editBirthDate:
        return '/edit/birthDate';
      case AppRoutes.editEmail:
        return '/edit/email';
      case AppRoutes.editPhoneNumber:
        return '/edit/phoneNumber';
      case AppRoutes.editPassword:
        return '/edit/password';

      case AppRoutes.cartSuccessScreen:
        return '/cart/successScreen';
    }
  }
}
