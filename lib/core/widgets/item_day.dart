import 'package:flutter/material.dart';
import 'package:task_u_devs/core/extension/color.dart';

class ItemDay extends StatefulWidget {
  String? title;
final  List<int>? colors;

  Function(bool) onTap;
  bool isSelect;
  double? height;
  double? width;

  ItemDay({this.height,this.width,this.title, this.colors,required this.onTap,required this.isSelect, super.key});

  @override
  State<ItemDay> createState() => _ItemDayState();
}

class _ItemDayState extends State<ItemDay> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.title != null)
              GestureDetector(
                onTap: () {
                  widget.onTap(widget.isSelect);
                  setState(() {
                    widget.isSelect = !widget.isSelect;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 40,
                  margin: EdgeInsets.only(bottom:widget.isSelect ? 5 : 0),
                  decoration: BoxDecoration(
                    color: widget.isSelect ? context.colors.blueSelect : context.colors.whiteSelect,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    widget.title ??"",
                    style: TextStyle(
                        fontSize: 20, color: widget.isSelect ? context.colors.whiteSelect : context.colors.systemBlack),
                  ),
                ),
              )
            else
              const SizedBox.shrink(),
            if (widget.colors != null && widget.colors!.isNotEmpty)
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.horizontal,

                runAlignment: WrapAlignment.center,
                spacing: 2,
                alignment: WrapAlignment.center,

                children: [
                  for (int i = 0; i < (widget.colors!.length < 4 ? widget.colors!.length : 4); i++)


                    Container(
                      height:  5,
                      width: 5,
                      decoration: BoxDecoration(
                        color: widget.colors![i] != null ? Color(widget.colors![i]) : context.colors.systemGrey,
                        shape: BoxShape.circle,
                      ),
                    ),
                  if (widget.colors!.length > 4)
                    ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          colors: [
                            context.colors.blueSelect,
                            context.colors.redSelect,
                            context.colors.greenSelect,
                            context.colors.yellowSelect
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ).createShader(bounds);
                      },
                      child: const Icon(
                        Icons.add,
                        size: 10,
                      ),
                    )
                ],
              ),
          ],
        ),
      );
  }

}



// final colors = [
//   Colors.red,
//   Colors.green,
//   Colors.blue,
//   Colors.yellow,
//   Colors.purple,
//   Colors.orange,
//   Colors.pink,
//   Colors.teal,
//   Colors.cyan,
//   Colors.indigo,
//   Colors.lime,
//   Colors.amber,
//   Colors.brown,
//   Colors.grey,
//   Colors.blueGrey,
// ];