# TRIPPY

MadCamp Week4 4분반 TRIPPY팀

- chat gpt api를 이용하여 이미지 generation, sound to text로 검색기능, chat 검색기능이 가능합니다
- 연락처를 받아와서 search,add,delete,상세정보창에서 전화,메세지,이메일보내기가 가능합니다
- 갤러리에서 local image , 갤러리 image, camera 촬영후 이미지를 추가하고 삭제가 가능합니다

### a. 개발 팀원

- 이황근 - 성균관대학교 소프트웨어학과 19학번
- 박병찬 - KAIST 전산학부 21학번

### b. 개발환경

- Language: Dart, Python, Javascript
- Front-end: Flutter
- Back-end: NodeJS
- DataBase: MongoDB
- OS: iOS, Android

- IDE: Visual Studio code
- Target Device: iPhone 14 pro max

### c. 어플리케이션 소개

## Page 0 - Login/SignUp

<img src="https://github.com/pbc1017/trippy/assets/63749140/a5b68119-9697-465b-88cc-626a82a33ae3" width="180"/> 
<img src="https://github.com/pbc1017/trippy/assets/63749140/6b1685f8-3cc3-4c40-aa53-50e91020b58e" width="180"/> 
<img src="https://github.com/pbc1017/trippy/assets/63749140/24535037-a624-41a4-94c5-d28724370558" width="180"/> 
<img src="https://github.com/pbc1017/trippy/assets/63749140/13630b6f-9c71-4c81-8b32-078f42ea1511" width="180"/> 
<img src="https://github.com/pbc1017/trippy/assets/63749140/98f71dba-26a4-4f1a-b4c4-1202a9b7a8df" width="180"/>

***Major features***

- 도형 두개가 좌우에서 날아오는 splash 화면을 구현하였습니다
- 화면에서 스와이프를 하면 다른 탭으로 view가 전환됩니다
- 또는 아래쪽의 탭을 눌러 view를 전환할 수 있습니다

***기술설명***

- ViewPager2와 TabLayout을 사용하여 스와이프를 통해 탭이 자연스럽게 전환될 수 있도록 하였습니다.
- 스플래시 구현을 위해 액티비티 간의 전환을 처리하였으며, 시작 액티비티를 메인액티비티에서 스플래시액티비티로 전환했습니다.
- splash 구현에서 objectAnimator를 사용하여 두 개의 이미지를 좌우에서 날아오게 애니메이션을 처리하였습니다
- Handler를 이용해 일정시간 지연 후 작업이 실행되게 하였습니다.

## Page 1 - Home

<img src="https://github.com/pbc1017/trippy/assets/63749140/dbb0a862-6e98-4236-8e87-6bf2abe2eeff" width="180"/>

***Major features***

- initial의 자음으로 그룹별로 연락처에 나타납니다.
- 우측 상단에 Add Contact 버튼을 클릭하여 연락처를 추가할 수 있는 화면으로 이동할 수 있습니다.
- 연락처를 클릭하면 상세 정보창으로 이동할 수 있습니다.
- 상세정보창에서 이메일, 전화, 메세지 버튼을 누르면 해당 기능을 수행할 수 있습니다.
- search contacts에서 찾고자 하는 연락처를 filtering 할 수 있습니다.
- 연락처를 길게 누를시에 삭제할 수 있습니다.

***기술설명***

- RecyclerView를 사용하여 목록 형태의 인터페이스를 구현했습니다.
- intent를 이용해 핸드폰의 연락처 앱에서 이름, 전화번호, 이메일을 불러왔습니다.
- intent를 이용해 전화, 문자, 이메일 버튼을 눌렀을때 해당 연락처의 정보가 바로 입력될 수 있도록 했습니다.
- 연락처 삭제를 구현하기 위해 전역변수를 선언하여 삭제된 연락처를 저장했습니다.

## Page 2 - Search

<img src="https://github.com/pbc1017/trippy/assets/63749140/e11aa594-842d-4e97-8e30-cb9bc5e22309" width="180"/>

***Major features***

- initial의 자음으로 그룹별로 연락처에 나타납니다.
- 우측 상단에 Add Contact 버튼을 클릭하여 연락처를 추가할 수 있는 화면으로 이동할 수 있습니다.
- 연락처를 클릭하면 상세 정보창으로 이동할 수 있습니다.
- 상세정보창에서 이메일, 전화, 메세지 버튼을 누르면 해당 기능을 수행할 수 있습니다.
- search contacts에서 찾고자 하는 연락처를 filtering 할 수 있습니다.
- 연락처를 길게 누를시에 삭제할 수 있습니다.

***기술설명***

- RecyclerView를 사용하여 목록 형태의 인터페이스를 구현했습니다.
- intent를 이용해 핸드폰의 연락처 앱에서 이름, 전화번호, 이메일을 불러왔습니다.
- intent를 이용해 전화, 문자, 이메일 버튼을 눌렀을때 해당 연락처의 정보가 바로 입력될 수 있도록 했습니다.
- 연락처 삭제를 구현하기 위해 전역변수를 선언하여 삭제된 연락처를 저장했습니다.

## Page 3 - Course Detail

<img src="https://github.com/pbc1017/trippy/assets/63749140/b29b0ca7-80a6-46ce-b8bf-b66b544f7733" width="180"/>
<img src="https://github.com/pbc1017/trippy/assets/63749140/9b724b18-7627-46a0-87f5-2e1f6c283c29" width="180"/>
<img src="https://github.com/pbc1017/trippy/assets/63749140/a043ca1a-64d2-4315-9901-72e5e78f7207" width="180"/>
***Major features***

- initial의 자음으로 그룹별로 연락처에 나타납니다.
- 우측 상단에 Add Contact 버튼을 클릭하여 연락처를 추가할 수 있는 화면으로 이동할 수 있습니다.
- 연락처를 클릭하면 상세 정보창으로 이동할 수 있습니다.
- 상세정보창에서 이메일, 전화, 메세지 버튼을 누르면 해당 기능을 수행할 수 있습니다.
- search contacts에서 찾고자 하는 연락처를 filtering 할 수 있습니다.
- 연락처를 길게 누를시에 삭제할 수 있습니다.

***기술설명***

- RecyclerView를 사용하여 목록 형태의 인터페이스를 구현했습니다.
- intent를 이용해 핸드폰의 연락처 앱에서 이름, 전화번호, 이메일을 불러왔습니다.
- intent를 이용해 전화, 문자, 이메일 버튼을 눌렀을때 해당 연락처의 정보가 바로 입력될 수 있도록 했습니다.
- 연락처 삭제를 구현하기 위해 전역변수를 선언하여 삭제된 연락처를 저장했습니다.

## Page 4 - Map
<img src="https://github.com/pbc1017/trippy/assets/63749140/905da69d-6d04-479a-bb12-a2849d227827" width="180"/>
***Major features***

- initial의 자음으로 그룹별로 연락처에 나타납니다.
- 우측 상단에 Add Contact 버튼을 클릭하여 연락처를 추가할 수 있는 화면으로 이동할 수 있습니다.
- 연락처를 클릭하면 상세 정보창으로 이동할 수 있습니다.
- 상세정보창에서 이메일, 전화, 메세지 버튼을 누르면 해당 기능을 수행할 수 있습니다.
- search contacts에서 찾고자 하는 연락처를 filtering 할 수 있습니다.
- 연락처를 길게 누를시에 삭제할 수 있습니다.

***기술설명***

- RecyclerView를 사용하여 목록 형태의 인터페이스를 구현했습니다.
- intent를 이용해 핸드폰의 연락처 앱에서 이름, 전화번호, 이메일을 불러왔습니다.
- intent를 이용해 전화, 문자, 이메일 버튼을 눌렀을때 해당 연락처의 정보가 바로 입력될 수 있도록 했습니다.
- 연락처 삭제를 구현하기 위해 전역변수를 선언하여 삭제된 연락처를 저장했습니다.

## Page 5 - Reservation Manager
<img src="https://github.com/pbc1017/trippy/assets/63749140/9538768e-29fa-495a-bcaa-f5c0fc653a28" width="180"/>
<img src="https://github.com/pbc1017/trippy/assets/63749140/9b52862d-f9d6-4860-8089-bbbfaee60137" width="180"/>
***Major features***

- initial의 자음으로 그룹별로 연락처에 나타납니다.
- 우측 상단에 Add Contact 버튼을 클릭하여 연락처를 추가할 수 있는 화면으로 이동할 수 있습니다.
- 연락처를 클릭하면 상세 정보창으로 이동할 수 있습니다.
- 상세정보창에서 이메일, 전화, 메세지 버튼을 누르면 해당 기능을 수행할 수 있습니다.
- search contacts에서 찾고자 하는 연락처를 filtering 할 수 있습니다.
- 연락처를 길게 누를시에 삭제할 수 있습니다.

***기술설명***

- RecyclerView를 사용하여 목록 형태의 인터페이스를 구현했습니다.
- intent를 이용해 핸드폰의 연락처 앱에서 이름, 전화번호, 이메일을 불러왔습니다.
- intent를 이용해 전화, 문자, 이메일 버튼을 눌렀을때 해당 연락처의 정보가 바로 입력될 수 있도록 했습니다.
- 연락처 삭제를 구현하기 위해 전역변수를 선언하여 삭제된 연락처를 저장했습니다.
