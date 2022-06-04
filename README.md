# NC1-MemoAndBlog

NC1 기간에 한국 iOS 개발자를 위한 커뮤니티 앱을 기획하고, 
로컬 메모장 기능과 블로그 UI를 구현했습니다. 

Local app supports memo and partial blog features.


<div class="row">
    <img width="200" alt="image" src="https://user-images.githubusercontent.com/102859746/171984555-5d87f356-436b-4f30-bbfd-277fb358e80c.png">
    <img width="200" alt="image" src="https://user-images.githubusercontent.com/102859746/171984577-b5e89417-01f9-4d60-b5cf-7902861d78d8.png">
  <img width="200" alt="image" src="https://user-images.githubusercontent.com/102859746/171985101-23b6b31a-cd11-4db1-92db-16c33f64fc00.png">

</div>



# NC1 기간 동안 만든 기능 
온보딩(가이드) 페이지
글 추가, 편집, 삭제, 발행
최종 수정일, 발행일 순서대로 정렬
밀어서 기능 실행하기
게시물 좋아요

# 더 추가되어야 할 기능 
- 애플 아이디로 로그인 (SSO)
- StoreKit을 이용한 구독 시스템
- CoreData를 외부 서버로 대체
- 댓글(대답) 기능

# 배운 것들
- 온보딩 페이지: 새로운 사용자가 빠르게 앱에 익숙해지도록 최초 구동 시 안내하는 페이지
- 일관적인 뷰 렌더링: 여러 뷰에서 동일한 내용을 보여주기 위한 Data Flow(@Binding, @ObservedObject, .onDisappear, .onAppear 등)를 설계.
- SwipeActions: UI를 심플하게 유지하면서 기능을 추가할 수 있다. 
- CoreData: 기기에 데이터를 저장하고 앱을 종료해도 데이터가 남는다. 데이터의 추가, 정렬, 편집, 삭제가 필요한 앱에 이용할 수 있다. 앱의 초기 개발 단계에서 서버 대용으로 사용하거나, 서버와 주고받는 트래픽을 줄이기 위해 캐시를 담을 수도 있음. 
