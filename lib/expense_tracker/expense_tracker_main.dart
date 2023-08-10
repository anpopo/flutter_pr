import 'package:first_web/expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 198, 118, 210),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 71, 31, 111),
);

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [DeviceOrientation.portraitUp],
  // ).then((fn) {
    runApp(
      MaterialApp(
        darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
          colorScheme: kDarkColorScheme,
        ),
        theme: ThemeData().copyWith(
            useMaterial3: true,
            colorScheme: kColorScheme,
            appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: kColorScheme.onPrimary,
              foregroundColor: kColorScheme.onPrimaryContainer,
            ),
            scaffoldBackgroundColor: kColorScheme.onPrimary,
            bottomSheetTheme: const BottomSheetThemeData().copyWith(
              backgroundColor: kColorScheme.onPrimary,
            ),
            cardTheme: CardTheme(
              color: kColorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            dropdownMenuTheme: ThemeData().dropdownMenuTheme.copyWith(
              textStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: kColorScheme.onPrimaryContainer,
              ),
            ),
            textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: kColorScheme.onPrimaryContainer,
              ),
            )
        ),
        themeMode: ThemeMode.system,
        home: const Expenses(),
      ),
    );
  // });
}
