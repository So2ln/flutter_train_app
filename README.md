-----

# 🚄 Flutter Train Ticket Reservation App (Flutter 기차표 예매 앱)

Welcome to the Flutter Train Ticket Reservation App\! Yayyyy
This application provides a intuitive user experience for selecting departure/arrival stations, choosing the number of passengers, and reserving seats. Built with Flutter, it boasts a clean, responsive UI and a robust state management approach.

-----

## 🌟 Features (주요 기능)

  * **Effortless Station Selection (쉬운 역 선택)**: Easily pick your **departure** and **arrival stations** from a comprehensive list. The app intelligently filters out the already selected station to prevent identical selections. (출발역과 도착역을 리스트에서 쉽게 선택할 수 있습니다. 이미 선택된 역은 리스트에서 제외하여 동일한 역을 선택하는 것을 방지합니다.)
  * **Flexible Passenger Count (인원 수 설정)**: Adjust the number of passengers with a simple tap, supporting up to **8 passengers** per reservation. (간편하게 인원 수를 조절할 수 있으며, 한 번에 최대 8명까지 예매할 수 있습니다.)
  * **Interactive Seat Selection (간편한 좌석 선택)**: A clear and interactive **seat map** allows users to select multiple seats according to their passenger count. (명확하고 상호적인(?) 좌석 배치도를 통해 승객 수에 맞춰 여러 좌석을 선택할 수 있습니다.)
  * **Intuitive UI/UX (직관적인 UI/UX)**: Designed with a user-centric approach, featuring clear visual cues for selected seats, station information, and prominent action buttons. (사용자 중심적으로 설계되어 선택된 좌석, 역 정보, 주요 액션 버튼 등이 명확히 제시됩니다.)
  * **Adaptive Theming (테마 지원)**: Supports both **light and dark modes** to suit user preferences and enhance readability. (사용자 기호에 맞춰 라이트 모드와 다크 모드를 모두 지원하여 가독성을 높입니다.)
  * **Responsive Alerts (피드백 알림)**: Provides informative feedback through snack bars and Cupertino-style dialogs for various user actions and validations. (다양한 사용자 동작 및 유효성 검사에 대해 스낵바와 쿠퍼티노 스타일의 다이얼로그를 통해 유익한 피드백을 제공합니다.)

-----

## Project Structure (프로젝트 구조)

The project is organized into logical directories to ensure maintainability and scalability: (프로젝트는 유지보수성과 확장성을 위해 논리적인 디렉토리로 구성되어 있습니다.)

```
flutter_train_app/
├── lib/
│   ├── models/
│   │   └── seat.dart             # Data model for Seat 
│   ├── pages/
│   │   ├── home_page.dart        # Main screen for station and passenger selection 
│   │   ├── seat_page.dart        # Seat selection screen (좌석 선택 화면)
│   │   ├── station_list_page.dart# List of available stations 
│   │   └── seat/                 # Widgets specific to the seat selection page 
│   │       ├── widgets/
│   │       │   ├── seat_booking_button.dart
│   │       │   ├── seat_grid_view.dart
│   │       │   └── seat_header.dart
│   ├── styles/
│   │   └── theme.dart            # Application theme definitions (light/dark) 
│   └── main.dart                 # Application entry point 
└── pubspec.yaml
└── README.md
```

-----

## 🔍 Core Components & Functionality (핵심 구성 요소 및 기능)

### `main.dart`

This file serves as the entry point of the Flutter application. It initializes the app and sets up the main `HomePage`. While not explicitly shown in the provided `main.dart`, it's typically where `MaterialApp` or `CupertinoApp` would be configured, along with the theme settings.

(이 파일은 Flutter 애플리케이션의 진입점 역할을 합니다. 앱을 초기화하고 메인 `HomePage`를 설정합니다. 제공된 `main.dart` 코드에는 명시적으로 표시되어 있지 않지만, 일반적으로 `MaterialApp` 또는 `CupertinoApp`이 테마 설정과 함께 구성되는 곳입니다.)

### `lib/pages/home_page.dart`

The `HomePage` is the central hub for initial booking configurations.

(`HomePage`는 초기 예매 설정을 위한 중심 허브입니다.)

  * **`HomePage` (StatefulWidget)**: Manages the state of selected departure/arrival stations and the number of passengers. (선택된 출발역/도착역 및 승객 수를 관리합니다.)
  * **`_HomePageState`**:
      * **State Variables (상태 변수)**:
          * `_selectedDepartStation` (String): Stores the chosen departure station (default: '선택'). (선택된 출발역을 저장합니다 (기본값: '선택').)
          * `_selectedArrivStation` (String): Stores the chosen arrival station (default: '선택'). (선택된 도착역을 저장합니다 (기본값: '선택').)
          * `_selectedPassengers` (int): Tracks the number of passengers (default: 1, max: 8). (선택된 승객 수를 추적합니다 (기본값: 1, 최대: 8).)
      * **UI Elements (UI 요소)**:
          * **Station Selection Boxes (역 선택 박스)**: Interactive `Container` widgets for selecting departure and arrival stations. Tapping these navigates to `StationListPage`. (출발역 및 도착역을 선택하기 위한 대화형 `Container` 위젯입니다. 이를 탭하면 `StationListPage`로 이동합니다.)
          * **Passenger Counter (인원 수 카운터)**: Allows users to increase or decrease the number of passengers with `IconButton`s. A `CupertinoAlertDialog` pops up if the user tries to exceed the 8-passenger limit. (사용자가 `IconButton`을 사용하여 승객 수를 늘리거나 줄일 수 있습니다. 8명 제한을 초과하려고 하면 `CupertinoAlertDialog`가 나타납니다.)
          * **"좌석 선택" (Select Seat) Button**: Navigates to the `SeatPage` after validating that both departure and arrival stations have been selected. A `SnackBar` is shown if validation fails. (출발역과 도착역이 모두 선택되었는지 확인한 후 `SeatPage`로 이동합니다. 유효성 검사에 실패하면 `SnackBar`가 표시됩니다.)
      * **Logic (로직)**: Handles `setState` calls to update the UI based on user interactions and navigation results from `StationListPage`. It smartly prevents selecting the same station for departure and arrival. (사용자 상호 작용 및 `StationListPage`의 탐색 결과에 따라 UI를 업데이트하기 위해 `setState` 호출을 처리합니다. 출발역과 도착역으로 동일한 역을 선택하는 것을 영리하게 방지합니다.)

### `lib/pages/station_list_page.dart`

This page presents a list of available train stations for selection.

(이 페이지는 선택할 수 있는 기차역 목록을 표시합니다.)

  * **`StationListPage` (StatefulWidget)**: Receives a `title` (e.g., '출발역' or '도착역') and an optional `stationToExclude` to prevent selecting the same station. (`title` (예: '출발역' 또는 '도착역')과 동일한 역을 선택하는 것을 방지하기 위한 선택적 `stationToExclude`를 받습니다.)
  * **`_StationListState`**:
      * **`_allStations`**: A predefined `List<String>` containing all possible station names. (사용 가능한 모든 역 이름이 포함된 미리 정의된 `List<String>`입니다.)
      * **`_displayStations`**: A `late List<String>` initialized in `initState` to hold stations that are presented to the user. It automatically removes the `stationToExclude` if provided. (`initState`에서 초기화되는 `late List<String>`으로, 사용자에게 표시될 역을 담습니다. `stationToExclude`가 제공되면 자동으로 해당 역을 제거합니다.)
      * **UI**: Displays stations using a `ListView.builder`. (`ListView.builder`를 사용하여 역을 표시합니다.)
      * **Interaction (상호 작용)**: Tapping a station pops the current route and returns the selected station name to the previous page (`HomePage`). (역을 탭하면 현재 경로를 팝하고 선택된 역 이름을 이전 페이지(`HomePage`)로 반환합니다.)

### `lib/pages/seat_page.dart`

This is where users select their seats.

(이곳에서 사용자는 좌석을 선택합니다.)

  * **`SeatPage` (StatefulWidget)**: Receives `departureStation`, `arrivalStation`, and `countPassangers` from `HomePage`. (`HomePage`에서 `departureStation`, `arrivalStation`, `countPassangers`를 받습니다.)
  * **`_SeatPageState`**:
      * **State Variables (상태 변수)**:
          * `_seats` (`List<List<Seat>>`): A 2D list representing the seat grid (20 rows, 4 columns). Each `Seat` object stores its row, column, and `isSelected` status. (좌석 그리드를 나타내는 2D 목록입니다 (20행, 4열). 각 `Seat` 객체는 행, 열 및 `isSelected` 상태를 저장합니다.)
          * `_multipleSelectedSeats` (`List<Seat>`): Tracks all currently selected seats. (현재 선택된 모든 좌석을 추적합니다.)
      * **`initState()`**: Initializes the `_seats` grid with `Seat` objects. (`Seat` 객체로 `_seats` 그리드를 초기화합니다.)
      * **`_toggleSeatSelect(int row, int col)`**: This crucial method handles seat selection logic. It toggles the `isSelected` status of a tapped seat. It also enforces the `countPassangers` limit, preventing users from selecting more seats than specified. An informative `CupertinoAlertDialog` is shown if the limit is exceeded. (이 중요한 메서드는 좌석 선택 로직을 처리합니다. 탭한 좌석의 `isSelected` 상태를 토글합니다. 또한 `countPassangers` 제한을 적용하여 사용자가 지정된 좌석보다 더 많이 선택하는 것을 방지합니다. 제한을 초과하면 유익한 `CupertinoAlertDialog`가 표시됩니다.)
      * **`_showBookingConfirm()`**: Displays a confirmation dialog with the selected seat IDs before finalizing the booking. If the number of selected seats doesn't match `countPassangers`, it prompts the user to select the correct number. Upon confirmation, selected seats are reset, and a "예매 완료" (Booking Complete) alert is shown. (예매를 확정하기 전에 선택된 좌석 ID와 함께 확인 대화 상자를 표시합니다. 선택된 좌석 수가 `countPassangers`와 일치하지 않으면 올바른 수를 선택하도록 사용자에게 안내합니다. 확인 시 선택된 좌석은 초기화되고 "예매 완료" 알림이 표시됩니다.)
      * **`_showCustomCupertinoAlert(String message)`**: A reusable utility function to display Cupertino-style alerts that automatically close after 1.8 seconds. (1.8초 후에 자동으로 닫히는 쿠퍼티노 스타일 알림을 표시하는 재사용 가능한 유틸리티 함수입니다.)
      * **UI Composition (UI 구성)**: Integrates three key widgets: (세 가지 핵심 위젯을 통합합니다.)
          * **`SeatHeader`**: Displays the selected departure/arrival stations and the total number of passengers. It also includes a legend for seat status (selected/unselected). (선택된 출발역/도착역과 총 승객 수를 표시합니다. 또한 좌석 상태(선택됨/선택 안 됨)에 대한 범례를 포함합니다.)
          * **`SeatGridView`**: Renders the interactive seat grid, allowing users to tap and select seats. (사용자가 좌석을 탭하고 선택할 수 있도록 대화형 좌석 그리드를 렌더링합니다.)
          * **`SeatBookingButton`**: The "예매 하기" (Book Now) button, which is only enabled when the number of selected seats matches `countPassangers`. (선택된 좌석 수가 `countPassangers`와 일치할 때만 활성화되는 "예매 하기" 버튼입니다.)

### `lib/models/seat.dart`

Defines the `Seat` data model. (`Seat` 데이터 모델을 정의합니다.)

  * **`Seat` Class (Seat 클래스)**:
      * `row` (int): The row index of the seat. (좌석의 행 인덱스.)
      * `col` (int): The column index of the seat. (좌석의 열 인덱스.)
      * `isSelected` (bool): Indicates if the seat is currently selected by the user. (좌석이 현재 사용자에게 선택되었는지 여부를 나타냅니다.)
      * `seatID` (Getter): Generates a user-friendly seat ID (e.g., "1-A", "5-C"). (사용자 친화적인 좌석 ID를 생성합니다 (예: "1-A", "5-C").)

### `lib/pages/seat/widgets/seat_booking_button.dart`

A reusable widget for the "예매 하기" button. ("예매 하기" 버튼을 위한 재사용 가능한 위젯입니다.)

  * **`SeatBookingButton` (StatelessWidget)**:
      * `onPressed` (`VoidCallback`): The callback function to execute when the button is pressed. (버튼이 눌렸을 때 실행될 콜백 함수입니다.)
      * `isSeatSelected` (bool): Determines if the button should be active. If `false`, the button is disabled. (버튼이 활성화되어야 하는지 여부를 결정합니다. `false`이면 버튼이 비활성화됩니다.)

### `lib/pages/seat/widgets/seat_grid_view.dart`

Renders the visual representation of the train seats. (기차 좌석의 시각적 표현을 렌더링합니다.)

  * **`SeatGridView` (StatelessWidget)**:
      * `seats` (`List<List<Seat>>`): The 2D list of `Seat` objects to display. (표시할 `Seat` 객체의 2D 목록입니다.)
      * `multipleSelectedSeats` (`List<Seat>`): The list of currently selected seats to determine their visual state. (현재 선택된 좌석의 시각적 상태를 결정하기 위한 목록입니다.)
      * `onSeatTap` (`Function(int row, int col)`): A callback function triggered when a seat is tapped. (좌석이 탭될 때 트리거되는 콜백 함수입니다.)
      * **`_buildHeaderRow()`**: Creates the column labels (A, B, C, D). (열 라벨(A, B, C, D)을 생성합니다.)
      * **`_buildSeatRow()`**: Renders each row of seats, including the row number. (행 번호를 포함하여 각 좌석 행을 렌더링합니다.)
      * **`_buildSeatWidget()`**: Creates an individual seat widget, dynamically changing its color and border based on its `isSelected` status. (좌석의 `isSelected` 상태에 따라 색상과 테두리를 동적으로 변경하여 개별 좌석 위젯을 생성합니다.)

### `lib/pages/seat/widgets/seat_header.dart`

Displays the booking summary at the top of the seat selection screen. (좌석 선택 화면 상단에 예매 요약을 표시합니다.)

  * **`SeatHeader` (StatelessWidget)**:
      * `departureStation` (String): The selected departure station. (선택된 출발역.)
      * `arrivalStation` (String): The selected arrival station. (선택된 도착역.)
      * `countPassangers` (int): The number of passengers selected. (선택된 승객 수.)
      * **UI**: Shows the departure and arrival stations with an arrow, and a clear labeling system for seat status (selected/unselected) including the total passenger count. (출발역과 도착역을 화살표와 함께 표시하며, 총 승객 수를 포함하여 좌석 상태(선택됨/선택 안 됨)에 대한 명확한 라벨링 시스템을 보여줍니다.)

### `lib/styles/theme.dart`

Manages the application's visual themes. (애플리케이션의 시각적 테마를 관리합니다.)

  * **`lightTheme`**: Defines the light mode theme with specific colors for background, app bar, surfaces, text, and accent elements, utilizing Material 3 design. (Material 3 디자인을 활용하여 배경, 앱 바, 표면, 텍스트 및 강조 요소에 대한 특정 색상으로 라이트 모드 테마를 정의합니다.)
  * **`darkTheme`**: Defines the dark mode theme with a dark background and appropriate color schemes for surfaces, text, and accent elements, also based on Material 3. (어두운 배경과 Material 3를 기반으로 하는 표면, 텍스트 및 강조 요소에 대한 적절한 색상 구성표로 다크 모드 테마를 정의합니다.)
  * Both themes use `Colors.purple` as their `seedColor`, ensuring a consistent brand color across the application. (두 테마 모두 `Colors.purple`을 `seedColor`로 사용하여 애플리케이션 전체에서 일관된 브랜드 색상을 보장합니다.)

-----

## Getting Started!

1.  **Clone the repository (저장소 복제):**
    ```bash
    git clone [repository_url]
    cd flutter_train_app
    ```
2.  **Install dependencies (종속성 설치):**
    ```bash
    flutter pub get
    ```
3.  **Run the app (앱 실행):**
    ```bash
    flutter run
    ```

-----

Feel free to explore and enhance this CUTE train ticket reservation application\! (소린이의 귀여운 기차표 예매 애플리케이션을 자유롭게 탐색하고 개선해 보세요\!)