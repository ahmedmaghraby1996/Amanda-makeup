import 'package:Makeup_app/Explore.dart';
import 'package:Makeup_app/category_class.dart';
import 'package:Makeup_app/prodcuts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Categories extends StatefulWidget {
  String category;
  Categories({@required this.category});
  @override
  State<StatefulWidget> createState() {
    return CategoriesState();
  }
}

class CategoriesState extends State<Categories> {
  String category="";
  List<Category_class> menu;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    category=widget.category;
    if(category=="lips")
      {
        menu=[Category_class("Lipstick", "assets/images/the-metallic-lipstick.jpg"),Category_class("Lip Pen","assets/images/1617790920756.jpg"),Category_class("Lip Balm", "assets/images/lip-care.jpg"),];
      }
    else if (category=="eyes")
      menu=[Category_class("Mascara","assets/images/hot-lash-mascara.jpg"),Category_class("Eyeshadow","assets/images/1617538249397.jpg"),Category_class("Eyeliner","assets/images/permenant-eyeliner.jpg"),];
    else if (category=="face")
      menu=[Category_class("Blush","assets/images/1617630827489.jpg"),Category_class("Concealer","assets/images/cover-stick- concealer.jpg"),Category_class("Powder", "assets/images/velvet-compact-powder.jpg"),Category_class("Foundation", "assets/images/teint-prefection-foundation.jpg")];
else if(category=="nails")
      menu=[Category_class("Nail Care","assets/images/double-use.jpg"),Category_class("Nail Polish", "assets/images/last-and-shine.jpg"),Category_class("Nail Polish Remover", "assets/images/regular-nail-polish-remover.png")];

 } @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        childAspectRatio: 3/4,
        crossAxisCount: 2,
        children:

            menu.map((e) =>
          InkWell(
              onTap: () { Provider.of<Prodcuts_Provider>(context,listen: false).nullproduct(); Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => Explore(category:"/${e.name.toLowerCase().replaceAll(" ", "")}",)));},
              splashColor: Colors.redAccent,

                 child: Card(
                      elevation: 5,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            child: Image.asset(
                              e.pic,
                              fit: BoxFit.cover,
                            ),
                            height: 200,
                            decoration:
                                BoxDecoration(borderRadius: BorderRadius.circular(8)),
                          ),
                          Text(e.name=="Nail Polish Remover"?"Polish Remover":e.name,style: TextStyle(fontSize: 20),maxLines: 1,textAlign: TextAlign.center,)
                        ],
                      )),


              ),



      ).toList(),

      mainAxisSpacing: 10,
    crossAxisSpacing: 10,
    ));

  }
}
