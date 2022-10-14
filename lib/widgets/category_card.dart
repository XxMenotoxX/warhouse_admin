import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;

   final IconData deleteIcon;
   final IconData updateIcon;

  final void Function() onPressed;
  final void Function() onLongPressed;


  CategoryCard({
    required this.image,
    required this.title,
    required this.description,

    required this.deleteIcon,
     required this.updateIcon,
    required this.onPressed,
    required this.onLongPressed
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, '/sub_category_screen');
      },

        // AlertDialog(
        //     title: Text('ggg'),
        //     content: Text('fff'),
        //   actions: [
        //     TextButton(onPressed: (){}, child: Text('dalete')),
        //   ],
        // );
        // showMenu(
        //   items: <PopupMenuEntry>[
        //     PopupMenuItem(
        //       value: this._index,
        //       child: Row(
        //         children: <Widget>[
        //           Icon(Icons.delete),
        //           Text("Delete"),
        //         ],
        //       ),
        //     )
        //   ],
        //   context: context, position: ,
        // );

      child: Card(

        elevation: 5,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsetsDirectional.only(top: 10, bottom: 20,),
        child: ListTile(
          title: Text(title),
          subtitle: Text(description),
          leading: Image.network(image),
          trailing: IconButton(onPressed: () {
            Navigator.pushReplacementNamed(context, '/update_category_screen');
          },
            icon: Icon(updateIcon),
          ),
          // trailing: Row(
          //      mainAxisAlignment: MainAxisAlignment.end,
          //     children: <Widget>[
          //
          //       IconButton(onPressed: (){Navigator.pushReplacementNamed(context, '/update_category_screen');},
          //         icon: Icon(updateIcon),
          //       ),
          //       IconButton(onPressed: (){},
          //         icon: Icon(deleteIcon),
          //       )
          //     ]),
        ),

      ),
    );
    
  }
}
