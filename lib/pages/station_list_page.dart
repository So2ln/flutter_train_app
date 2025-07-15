import 'package:flutter/material.dart';

class StationListPage extends StatefulWidget {
  // HomePAge에서 '출발역'인지 '도착역'인지 정보 받기 (생성자)
  final String title; // AppBar title로 사용할 문자열
  final String? stationToExclude;

  const StationListPage({
    super.key,
    required this.title,
    required this.stationToExclude,
  }); //생성자

  @override
  State<StationListPage> createState() => _StationListState();
}

class _StationListState extends State<StationListPage> {
  final List<String> _allStations = [
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

  late List<String> _displayStations;

  @override
  void initState() {
    super.initState();
    // make displayStations based on allStations
    _displayStations = List.from(_allStations);
    // Check if stationName is provided and is not empty
    if (widget.stationToExclude != null &&
        widget.stationToExclude!.isNotEmpty) {
      _displayStations.remove(
        widget.stationToExclude,
      ); // Use remove to remove a specific item
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),

      body: ListView.builder(
        itemCount: _displayStations.length,
        itemBuilder: (context, index) {
          String stationName = _displayStations[index];
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
