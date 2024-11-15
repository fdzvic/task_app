import 'package:flutter/material.dart';
import 'package:taks_app/core/presentation/design/atoms/custom_card.dart';
import 'package:taks_app/core/presentation/design/atoms/custom_text.dart';
import 'package:taks_app/core/presentation/design/tokens/colors.dart';
import 'package:taks_app/core/presentation/utils/extension/dimens_extension.dart';

class CustomCardTask extends StatelessWidget {
  const CustomCardTask({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title,
            styleType: TextStyleType.bodyLarge,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: context.height(.2),
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return CustomCard(
                    color: index % 2 == 0
                        ? colors.primaryColor.withOpacity(.1)
                        : colors.primaryColor.withOpacity(.4),
                    child: const CustomText(
                      "Llevar a chiripa",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: 4),
          )
        ],
      ),
    );
  }
}
