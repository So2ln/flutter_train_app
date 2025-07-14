import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StationListPage extends StatefulWidget {
  // HomePAge에서 '출발역'인지 '도착역'인지 정보 받기 (생성자)
  final String title; // AppBar title로 사용할 문자열
  final String? excludedStation; // 도전과제!!!: 제외할 역 이름 (null일 수 있음)

  const StationListPage({
    super.key,
    required this.title,
    required this.excludedStation, // (도전과제) 생성자에도 추가
  }); //생성자

  @override
  State<StationListPage> createState() => _StationListState();
}

class _StationListState extends State<StationListPage> {
  List<String> _allStations = [];

  // ListView.builder에 실제로 표시될 역 목록 (이미 선택된 역 제외)
  List<String> _displayStations = [];

  bool _isLoading = true; // 로딩 상태를 표시! (json 데이터를 비동기로 가져올 때 필요하다고 함)

  @override
  void initState() {
    super.initState();

    _loadStations();
  }

  Future<void> _loadStations() async {
    try {
      String jsonString = await rootBundle.loadString('assets/stations.json');
      List<dynamic> jsonList = json.decode(jsonString);

      // List<dynamic>을 List<String>으로 변환합니다.
      _allStations = jsonList.map((item) => item.toString()).toList();

      if (widget.excludedStation != null) {
        _displayStations = _allStations
            .where((station) => station != widget.excludedStation)
            .toList();
      } else {
        _displayStations = List.from(_allStations);
      }
    } catch (e) {
      print('failed to load stations: $e');
      _displayStations = ['데이터 로드 실패'];
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),

      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _displayStations.length,
              itemBuilder: (context, index) {
                final String stationName = _displayStations[index];
                // 현재 역이 제외할 역인지 확인하기
                final bool isExcluded = stationName == widget.excludedStation;

                return GestureDetector(
                  onTap: isExcluded
                      ? null
                      : () {
                          //
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
                        bottom: BorderSide(
                          color: Colors.grey[300]!,
                          width: 1.0,
                        ),
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
