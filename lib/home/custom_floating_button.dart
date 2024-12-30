import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/home/custom_bottom_sheet.dart';

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      radius: 45,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 33,
        child: FloatingActionButton(
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.white)),
          onPressed: () => showModalBottomSheet(
          //  clipBehavior: Clip.hardEdge,
            // scrollControlDisabledMaxHeightRatio: 100,
            isScrollControlled: true,
            context: context,
            builder: (context) => BottomSheetContent(),
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
