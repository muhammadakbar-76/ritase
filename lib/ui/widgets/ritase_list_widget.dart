import 'package:flutter/material.dart';
import 'package:ritase/shared/theme.dart';
import 'package:ritase/ui/pages/ritase_detail_page.dart';

class RitaseListWidget extends StatelessWidget {
  const RitaseListWidget({
    super.key,
    required this.material,
    required this.kategori,
    required this.time,
    required this.ritaseId,
  });

  final String material;

  final String kategori;

  final String time;

  final int ritaseId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RitaseDetailPage(
              ritaseId: ritaseId,
            ),
          ),
        );
      },
      child: Container(
        height: 100,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              height: double.infinity,
              width: 60,
              margin: const EdgeInsets.only(right: 12),
              child: CircleAvatar(
                backgroundColor: cSecondaryColor2,
                child: Icon(
                  Icons.tram,
                  size: 40,
                  color: cSecondaryColor,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        material,
                        style: tBlackText.copyWith(
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        time,
                        style: tGreyText.copyWith(fontSize: 13),
                      ),
                    ],
                  ),
                  Text(
                    kategori,
                    style: tGreyText.copyWith(fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
