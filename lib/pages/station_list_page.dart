import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class StationListPage extends StatefulWidget {
  // HomePAge에서 '출발역'인지 '도착역'인지 정보 받기 (생성자)
  final String title; // AppBar title로 사용할 문자열

  const StationListPage({super.key, required this.title}); //생성자

  @override
  State<StationListPage> createState() => _StationListState();
}

class _StationListState extends State<StationListPage> {
  final List<String> stations = const [
    "수서",
    "동탄",
    "평택지제",
    "천안아산",
    "오송",
    "대전",
    "김천구미",
    "동대구",
    "경주",
    "울산",
    "부산",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),

      body: ListView.builder(
        itemCount: stations.length,
        itemBuilder: (context, index) {
          final String stationName = stations[index];
          return GestureDetector(
            onTap: () {
              // 선택된 역 이름을 이전 페이지(HomePage)로 돌려줌
              Navigator.pop(context, stationName);
            },
            // [기차역 이름 감싸고 있는 영역]
            child: Container(
              height: 50,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey[300]!, width: 1.0),
                ),
              ),
              child: Text(
                stationName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
