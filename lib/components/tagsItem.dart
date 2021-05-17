import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TagItem extends StatelessWidget {
  TagItem(this.name, this.onClick, this.isSelected);

  final String name;
  final Function onClick;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final localTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: this.onClick,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 8, 5, 8),
        child: Container(
          decoration: BoxDecoration(
            color:
                this.isSelected ? colorScheme.primary : colorScheme.background,
            border: Border(
                bottom: BorderSide(width: 2, color: colorScheme.primary)),
          ),
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                this.name,
                style: localTheme.bodyText2.copyWith(
                    color: this.isSelected
                        ? colorScheme.background
                        : Colors.grey),
              )),
        ),
      ),
    );
  }
}

class TagCirclePainter extends CustomPainter {
  TagCirclePainter(this.size, this.color);

  final double size;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = this.color
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(7, 6), this.size, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
