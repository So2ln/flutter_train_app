// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_train_app/pages/seat_page.dart';
import 'package:flutter_train_app/pages/station_list_page.dart';

/// HomePage 위젯:
/// 나중에 출발역, 도착역 등 선택 상태를 관리해야 하므로 StatefulWidget으로 시작한다.
class HomePage extends StatefulWidget {
  const HomePage({super.key}); //생성자

  @override
  State<HomePage> createState() => _HomePageState(); // 이 StatefulWidget의 상태를 관리할 클래스를 지정
}

// _HomePageState 클래스: HomePage의 실제 UI와 상태(데이터)를 관리하는 곳
class _HomePageState extends State<HomePage> {
  String _selectedDepartStation = '선택';
  String _selectedArrivStation = '선택';
  int _selectedPassengers = 1; // 선택된 인원 수 (기본값 1) <--- 추가기능!!!

  @override
  Widget build(BuildContext context) {
    final containerColor = Theme.of(context).colorScheme.surface;
    final textColor = Theme.of(context).colorScheme.onSurface;
    final wallColor = Theme.of(context).scaffoldBackgroundColor;
    final iconColor = Theme.of(context).colorScheme.secondary;

    // Scaffold: 앱의 기본 구조를 제공하는 위젯
    // 1. 앱바, 2. body영역, 3. floatingActionButton 등
    return Scaffold(
      // 1. 앱바
      appBar: AppBar(title: const Text('기차 예매')),
      // 2. body영역
      // 테마 설정
      // backgroundColor: Colors.grey[200],
      backgroundColor: wallColor,

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            // 3. [출발역, 도착역 감싸고 있는 박스]
            Container(
              height: 200, // 높이
              decoration: BoxDecoration(
                color: containerColor, // 색상 - 테마별로
                borderRadius: BorderRadius.circular(20), // 모서리 둥글기
              ),
              child: Row(
                children: [
                  // ---여기는 출발역---
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        // [도전과제!] 만약 '도착역'에서 역이 선택되었다면 해당 역 제거
                        final String? excludeStation =
                            _selectedArrivStation != '선택'
                            ? _selectedArrivStation
                            : null;

                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StationListPage(
                              title: '출발역',
                              stationToExclude: excludeStation,
                            ),
                          ),
                        );

                        if (result != null && result is String) {
                          setState(() {
                            _selectedDepartStation = result;
                            // if (_selectedDepartStation ==
                            //     _selectedArrivStation) {
                            //   _selectedArrivStation = "선택";
                            // }
                          });
                        }
                      },

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '출발역', // 4. 출발역
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            _selectedDepartStation,
                            style: TextStyle(fontSize: 40),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ====6. 구분선====
                  // 나는 container로 했는데, 시간 남으면 verticalDivider 사용법도 알아봐야겠음.
                  Container(
                    width: 2,
                    height: 50,
                    color: Colors.grey[400],
                    margin: EdgeInsets.symmetric(horizontal: 10),
                  ),

                  // ----여기는 도착역----
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        // [도전과제!] 만약 '출발역'에서 역이 선택되었다면 해당 역 제거
                        final String? excludeStation =
                            _selectedDepartStation != '선택'
                            ? _selectedDepartStation
                            : null;

                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StationListPage(
                              title: '도착역',
                              stationToExclude: excludeStation,
                            ),
                          ),
                        );

                        if (result != null && result is String) {
                          setState(() {
                            _selectedArrivStation = result;
                          });
                        }
                      },
                      //도착역 부분의 글자 스타일은 출발역 부분과 동일
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '도착역',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            _selectedArrivStation,
                            style: TextStyle(fontSize: 40),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // --- 여기까지 출발역, 도착역 감싸고 있는 박스

            // 좌석 선택 버튼과 출발역 및 도착역 감싸고 있는 박스의 간격: 20
            SizedBox(height: 20),

            /////////////////////////////////////////////////////////
            /// -------- 인원 선택 버튼 추가하기!!! 도저어어언 ------- ///
            ///
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: containerColor,
                borderRadius: BorderRadius.circular(20),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: Text(
                      '인원 수',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Flexible(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 감소 버튼
                        IconButton(
                          icon: Icon(
                            Icons.remove_circle_outline,
                            color: iconColor,
                            size: 30,
                          ),
                          onPressed: () {
                            setState(() {
                              if (_selectedPassengers > 1) {
                                _selectedPassengers--;
                              }
                            });
                          },
                        ),

                        // 선택된 인원 수 표시
                        SizedBox(
                          width: 100,
                          child: Center(
                            child: Text(
                              '$_selectedPassengers명',
                              style: TextStyle(fontSize: 24, color: textColor),
                            ),
                          ),
                        ),

                        // 증가 버튼
                        IconButton(
                          icon: Icon(
                            Icons.add_circle_outline,
                            color: iconColor,
                            size: 30,
                          ),
                          onPressed: () {
                            setState(() {
                              _selectedPassengers++;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 간격
            SizedBox(height: 20),

            // ----7. [좌석 선택 버튼]
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  if (_selectedDepartStation == '선택' ||
                      _selectedArrivStation == '선택') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '출발역과 도착역을 모두 선택해주세요!',
                          style: TextStyle(color: textColor),
                        ),
                        backgroundColor: containerColor, // 스낵바 배경색을 surface로 설정
                      ),
                    );
                    return;
                  }

                  /// seatpage로 이동!
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SeatPage(
                        departureStation: _selectedDepartStation,
                        arrivalStation: _selectedArrivStation,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors
                      .purple, // 나중에 main.dart에서 ElevatedButtonThemeData설정하면 여기 지워주기!
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  '좌석 선택',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
