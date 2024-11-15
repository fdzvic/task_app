import 'package:flutter/material.dart';
import 'package:taks_app/core/presentation/design/atoms/custom_card.dart';
import 'package:taks_app/core/presentation/design/atoms/custom_text.dart';
import 'package:taks_app/core/presentation/design/tokens/colors.dart';
import 'package:taks_app/core/presentation/utils/global/global_data.dart';

class ButtonsFilter extends StatelessWidget {
  const ButtonsFilter({
    super.key,
    required this.length,
  });

  final int length;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => CustomCard(
          color: colors.primaryColor,
          child: CustomText(
            "${globalData.itemsFilter[index]['label']} ($length)",
            textAlign: TextAlign.center,
            textColor: Colors.white,
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(
          width: 10,
        ),
        itemCount: globalData.itemsFilter.length,
      ),
    );
  }
}
