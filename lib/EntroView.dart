import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:pharmacy/Pages/Home.dart';
class Intro extends StatefulWidget {
  @override
  _Intro createState() => _Intro();
}
class _Intro extends State<Intro> {
  List<PageViewModel> getPages() {
    return [
      PageViewModel(
         
          image: Image.asset("lib/assets/person.jpg"),
          title: "",
          body: "هل  تــواجه مشـكلة في ايـجاد الــدواء ؟",
          footer: Text("ابـحث  عن دوائـك مـن  منذلك"),
          decoration: const PageDecoration(
            pageColor: Colors.white,
          )),
      PageViewModel(
        image: Image.asset("lib/assets/money.jpg"),
        title: "سـهولة الــحصول علي الــدواء ",
        body: "",
        footer: Text(""),
      ),
      PageViewModel(
        image: Image.asset("lib/assets/phar.jpg"),
        title: "هل لديك منتج تريد عرضـه؟",
        body: "اعـرض منتجك مع التطبيق",
        footer: Text(" "),
      ),
      // PageViewModel(
      //   image: Image.asset("lib/assets/per.jpg"),
      //   title: "",
      //   body: "Live Demo Text",
      //   footer: Text("Footer Text  here "),
      // ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Introduction Screen"),
      // ),

      body: IntroductionScreen(
        globalBackgroundColor: Colors.white,
        pages: getPages(),
        showNextButton: true,
        showSkipButton: true,
        skip: Text("تخطي"),
        done: Text("موافق"),
        onDone: (){
           Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
      ),
    );
  }
}