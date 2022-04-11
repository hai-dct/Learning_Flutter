# 6.1 Provider pattern (Hạnh, Anh)
- Provider là gì:
  - **Provider** Là một giải pháp quản lý State hay là một giải pháp truyền dữ liệu, thay đổi dữ liệu giữa các Widget, giữa các màn hình.
  - Chúng ta có thể sử dụng và thay đổi biến, hàm, cập nhật **State** ở mọi nơi trong ứng dụng, trong phạm vi mà developer thiết lập.
- Nguyên lý của Provider
  - **Provider** giống như một thùng chứa dữ liệu, được đăng ký và khai báo ở widget cha.
  - Dữ liệu trong **Provider** có thể được lấy ra và được thay đổi bởi widget cha đó và các widget con.
  - ![Screen Shot 2021-09-23 at 08 35 50](https://user-images.githubusercontent.com/55979453/134443012-1b18f5dd-358e-4fc2-9e73-4fe6880cfe81.png)
- Cài Đặt Provider
  - Cài thư viện mới nhất của provider trên Pub.dev: https://pub.dev/packages/provider 
- Cách vận hành
  - Tạo model và đặt lắng nghe với ChangeNotifier
  - ![Screen Shot 2021-09-23 at 09 05 59](https://user-images.githubusercontent.com/55979453/134444865-05083cf6-44f5-4463-9023-045b0295cb52.png)
- Khai báo Provider trên Parent Widget
  - ![Screen Shot 2021-09-23 at 10 11 07](https://user-images.githubusercontent.com/55979453/134449550-a851cf0b-61b3-4e78-ba1a-1fcb570a461c.png)
- Sử dụng ở các Widget con
  - Cập nhật dữ liệu
    - ![Screen Shot 2021-09-23 at 10 14 52](https://user-images.githubusercontent.com/55979453/134449815-096e6e85-65e4-4b64-ba80-567bc8170301.png)
  - Sử dụng dữ liệu trên Provider
    - ![Screen Shot 2021-09-23 at 10 17 12](https://user-images.githubusercontent.com/55979453/134449970-0b15767c-1681-4df4-b883-7eb4eefa8cd6.png)
  - Sử dụng FutureProvider
    - ![Screen Shot 2021-09-23 at 10 42 18](https://user-images.githubusercontent.com/55979453/134451652-6db9d4f6-7b65-48dc-a2bc-f2032d71496c.png)
  - Tóm lại Provider giúp : 
    - Dữ liệu có thể tái sử dụng được ở mọi widget con trong ứng dụng.
    - Dữ liệu đã được load trước ở Widget cha
    - Nâng cấp độ mượt của ứng dụng
    - Cải thiện UX(trải nghiệm người dùng )
# 6.2 Mobx pattern (Anh Hải, An)
# 6.3 Bloc (Hạnh, Anh Thinh)
- Ý tưởng của kiến trúc **BLoc**

  ![Screen Shot 2021-09-24 at 10 05 38](https://user-images.githubusercontent.com/55979453/134711250-4762b73d-2f46-48ea-b499-69b8c3f26c42.png)
  
- Kiến trúc **Bloc**

  ![Screen Shot 2021-09-24 at 10 48 26](https://user-images.githubusercontent.com/55979453/134711320-4692d99b-bb5b-460c-8815-daa7ad6ac75a.png)
  
- Tại sao phải dùng kiến trúc **BLOC EVENT_STATE**
  - Khi ứng dụng có nhiều trạng thái và cần thay đổi tức thì. Lúc đó, nếu chỉ dùng các phương pháp cũ như setState() và provider thì xử lý rất phức tạp và khó mượt mà.
  - Hơn nữa rất khó debug và mở rộng sau này.
  - Đối với kiến trúc Bloc_Event_State:
    - Luồng code chạy rõ ràng, mượt mà
    - Dễ dàng mở rộng khi thêm các trạng thái mới tức là dễ mở rộng ứng dụng 
    - Dễ quản lý và debug
 - Khi nào nên dùng ?
   - Dùng ở ứng dụng có nhiều trạng thái mà cách thông thường khó xử lý.
   - Khi trạng thái thay đổi thì UI cũng cần thay đổi tức thì vì vậy cần ứng dụng mượt, Khi đó ta dùng kiến trúc BLoc.
 - ƯU ĐIỂM VÀ NHƯỢC ĐIỂM
   - Ưu điểm
     - App chạy mượt khi chuyển State 
     - Dễ mở rộng, dễ debug, dễ quản lý 
   - Nhược điểm
     - Khó hiểu cho người mới học
     - Cần làm các công đoạn tỉ mỉ
     - Nhưng khi đã làm quen thì Bloc là một công cụ cực mạnh, triển khai các ứng dụng vừa và lớn.
 - Cài đặt thư viện
   ```javascript
      flutter_bloc: ^7.3.0
   ```
 - Các bước thực hiện kiến trúc **BLOC – EVENT_STATE**
   - Hoàn thành bảng phân tích event-state
   - Tạo các Event Class
   - Tạo các State Class
   - Tạo các Bloc Class
   - Hiển thị lên UI : sử dụng BlocProvider, BlocBuilder
# 6.4 getX (Anh Hải, Anh)
