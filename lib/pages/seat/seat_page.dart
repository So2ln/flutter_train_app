import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_train_app/models/seat.dart';

class SeatPage extends StatefulWidget {
  final String departure;
  final String arrival;

  const SeatPage({super.key, required this.departure, required this.arrival});

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  List<List<Seat>> _seats = [];

  // 현재 선택된 좌석
  Seat? _selectedSeat;

  @override
  void initState() {
    // 좌석 리스트 초기화
    for (int r = 0; r < 20; r++) {
      List<Seat> rowSeats = [];
      for (int c = 0; c < 4; c++) {
        rowSeats.add(Seat(row: r, col: c));
      }
      _seats.add(rowSeats);
    }
  }

  // 좌석 탭하면 호출
  void _toggleSeatSelect(int row, int col) {
    setState(() {
      final tappedSeat = _seats[row][col];

      //이미 예약된 좌석은 선택할 수 없도록
      if (tappedSeat.isBooked) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('이미 예약된 좌석입니다.')));
        return;
      }
      // 이미 선택된 좌석이 있다면, 그 좌석의 선택 상태 해제
      if (_selectedSeat != null) {
        _selectedSeat!.isSelected = false;
      }
      // 새로 선택한 좌석의 선택 상태 업데이트
      /// 이미 선택되어있으면 해제하는거고, 아니면 선택하는것
      tappedSeat.isSelected = !tappedSeat.isSelected;

      // _selectedSeat 변수 업데이트
      if (tappedSeat.isSelected) {
        _selectedSeat = tappedSeat; // 새로 선택된 좌석으로 저장하기!
      } else {
        _selectedSeat = null; // 선택 해제되면 null값 출력
      }
    });
  }

  // 좌석 예매 확인하기 팝업

  void _showBookingConfirm() {
    if (_selectedSeat != null) {
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('예매 하시겠습니까?'),
            content: Text('좌석 : ${_selectedSeat!.seatID}'),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  Navigator.of(context).pop(); // 팝업 닫기
                },
                child: const Text('취소'),
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {},
                child: const Text('확인'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('좌석 선택')),
      body: Column(
        // 전체 body는 column으로 감싸고 아래 좌석 부분만 listview!
        children: [
          // [출발역, 도착역]
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.departure,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(width: 10),
                  // 가운데 아이콘
                  const Icon(
                    Icons.arrow_circle_right_outlined,
                    size: 30,
                    color: Colors.purple,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.arrival,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSeatStatusLabel(color: Colors.purple, text: '선택됨'),
                  const SizedBox(width: 20),
                  _buildSeatStatusLabel(color: Colors.grey[300]!, text: '선택안됨'),
                ],
              ),
            ],
          ),

          Expanded(
            child: ListView.builder(
              itemCount: _seats.length + 1,
              itemBuilder: (context, rowIndex) {
                if (rowIndex == 0) {
                  return _buildHeaderRow(); //column A,B,C,D
                } else {
                  return _buildSeatRow(_seats[rowIndex - 1], rowIndex - 1);
                }
              },
            ),
          ),

          // 예매하기 버튼
          Container(
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _selectedSeat == null ? null : _showBookingConfirm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  '예매 하기',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildSeatStatusLabel({required Color color, required String text}) {
  return Row(
    children: [
      Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      const SizedBox(width: 4),
      Text(text),
    ],
  );
}

Widget _buildHeaderRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SizedBox(width: 20),
      ...List.generate(4, (index) {
        return Expanded(
          child: Center(
            child: Text(
              String.fromCharCode('A'.codeUnitAt(0) + index),
              style: const TextStyle(fontSize: 18),
            ),
          ),
        );
      }),
      const SizedBox(width: 20),
    ],
  );
}

extension on _SeatPageState {
  Widget _buildSeatRow(List<Seat> rowSeats, int rowIndex) {
    final actualRowNum = rowIndex + 1;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          alignment: Alignment.center,
          child: Text('$actualRowNum', style: const TextStyle(fontSize: 18)),
        ),
        const SizedBox(width: 20),

        ...rowSeats.map((seat) {
          Color seatColor;
          if (seat.isSelected) {
            seatColor = Colors.purple;
          } else {
            seatColor = Colors.grey[300]!;
          }

          return Expanded(
            child: GestureDetector(
              onTap: () => _toggleSeatSelect(seat.row, seat.col),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: seatColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: (seat.isSelected && _selectedSeat == seat)
                        ? Colors.purple.shade900
                        : Colors.transparent,
                    width: (seat.isSelected && _selectedSeat == seat)
                        ? 2.0
                        : 0.0,
                  ),
                ),
                alignment: Alignment.center,
              ),
            ),
          );
        }),
      ],
    );
  }
}
