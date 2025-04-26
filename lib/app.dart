
import 'package:crud_app/presentation/ui/screens/product_list_screen.dart';
import 'package:device_preview_minus/device_preview_minus.dart' show DevicePreview;
import 'package:flutter/material.dart';

class CrudApp extends StatelessWidget{

  const CrudApp({super.key});

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
       locale: DevicePreview.locale(context),
       builder: DevicePreview.appBuilder,
       title: 'Crud App',
       debugShowCheckedModeBanner: false,
       home: ProductListScreen(),
       themeMode: ThemeMode.system,
       theme: _lightThemeMode(),
       darkTheme: _darkThemeMode(),
     );
  }

  ThemeData _lightThemeMode() {
    return ThemeData(
        brightness: Brightness.light,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
                color: Colors.purple.shade100,
                width: 2
            ),),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  color: Colors.green,
                  width: 2
              )
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  color: Colors.redAccent,
                  width: 2
              )
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
                color: Colors.red,
                width: 2
            ),),),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                fixedSize: Size.fromWidth(double.maxFinite),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                ),
                backgroundColor: Color(0xFFB39DDB),
                foregroundColor: Colors.white
            )
        )
    );
  }

    ThemeData _darkThemeMode(){
      return ThemeData(
        brightness: Brightness.dark,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
                color: Colors.purpleAccent,
                 width: 1.5
            )
          ),
                focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                    color: Colors.green,
                    width: 1.5
                )
            ),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                    color: Colors.red,
                    width: 1.5
                )
            ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.red,
              width: 1.5
            )
          )
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              fixedSize: Size.fromWidth(double.maxFinite),
              padding: EdgeInsets.symmetric(vertical: 14,horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
              ),
              backgroundColor: Colors.purpleAccent.shade100,
              foregroundColor: Colors.white
            )
        )
      );
    }
  }
