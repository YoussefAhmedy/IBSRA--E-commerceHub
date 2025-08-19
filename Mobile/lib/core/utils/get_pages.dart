import 'package:get/get.dart';
import 'package:unique/core/constants/app_route.dart';
import 'package:unique/features/create_custom_poster/presentation/pages/create_custom_poster_page.dart';
import 'package:unique/features/create_custom_poster/presentation/pages/payment_success.dart';
import 'package:unique/features/main/presentation/pages/main_page.dart';
import 'package:unique/features/poster_details/presentation/pages/poster_details_page.dart';

import '../../features/create_custom_poster/presentation/pages/check_out_page.dart';

List<GetPage<dynamic>>? getPages = [
  GetPage(
    name: AppRoute.createCustomPoster,
    page: () => CreateCustomPosterPage(),
  ),
  GetPage(
    name: AppRoute.posterDetails,
    page: () => PosterDetailsPage(),
  ),
  GetPage(
    name: AppRoute.checkOutPage,
    page: () => CheckOutPage(),
  ),
  GetPage(
    name: AppRoute.paymentSuccessPage,
    page: () => PaymentSuccessPage(),
  ),
  GetPage(
    name: AppRoute.mainPage,
    page: () => MainPage(),
  ),
];
