import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:taks_app/core/data/network/user_preferences.dart';
import 'package:taks_app/core/presentation/design/atoms/custom_card.dart';
import 'package:taks_app/core/presentation/design/atoms/custom_text.dart';
import 'package:taks_app/core/presentation/design/tokens/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late List<Map<String, dynamic>> listData;

  @override
  void initState() {
    super.initState();
    listData = [];
    final data = json.decode(prefs.userData) as Map<String, dynamic>;
    listData = data.entries.map((entry) {
      return {
        'label': entry.key,
        'value': entry.value,
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomCard(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    "Mi perfil",
                    styleType: TextStyleType.bodyLarge,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 20),
                  Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(1),
                    },
                    children: listData.isNotEmpty
                        ? List<TableRow>.generate(
                            listData.length * 2 - 1,
                            (index) {
                              if (index.isOdd) {
                                return TableRow(
                                  children: List.generate(
                                    2,
                                    (colIndex) => const SizedBox(height: 10),
                                  ),
                                );
                              } else {
                                final data = listData[index ~/ 2];
                                return TableRow(
                                  decoration: BoxDecoration(
                                    color: colors.primaryColor.withOpacity(.5),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomText(
                                        getTitle(data["label"]),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        getValue(data["label"].toString(),
                                            data["value"].toString()),
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            },
                          )
                        : [
                            const TableRow(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text(
                                    "No hay datos disponibles",
                                    style: TextStyle(fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ],
                  ),
                ],
              ))
        ],
      ),
    );
  }

  getValue(String key, String value) {
    if (key == 'createdAt') {
      return DateTime.parse(value).toString().split(' ').first;
    }
    return value;
  }

  getTitle(String value) {
    switch (value) {
      case 'name':
        return 'Nombres';
      case 'lastName':
        return 'Apellidos';
      case 'email':
        return 'Correo';
      case 'createdAt':
        return 'Fecha de registro';

      default:
    }
  }
}
