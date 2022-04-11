# 4.1 Navigator (Đ. Anh)

- `Navigator`: Là một widget con quản lý stack các đối tượng Route(Tuyến đường)

- Các methods quan trọng Navigator hay dùng:
    - `Navigator.push`: Next page. Trong method này dùng `MaterialPageRoute`
    - `Navigator.pop`: Back page
    - `Navigator.pushReplacement`: Next page and set root page

- Ngoài ra có rất nhiều method khác. Các bạn có thể tham khảo tại [đây](https://api.flutter.dev/flutter/widgets/Navigator-class.html)

- `MaterialPageRoute là gì?`: Là một tuyến phương thức thay thế toàn bộ màn hình bằng quá trình chuyển đổi thích ứng với nền tảng

- Example: Từ màn hình *Page1* push sang *Page2* và ngược lại

Page1 Screen: Dùng *Navigator.push()* để chuyển sang màn hình mong muốn
```
`floatingActionButton: FloatingActionButton(
onPressed: () {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => Page2()));
},
child: Icon(Icons.add),
),`
```

Page 2 Screen: Sử dụng *Navigator.pop()* để quay lại màn hình đầu tiên
```
floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.add),
      ),
```

- Kết quả:

https://user-images.githubusercontent.com/61812892/133726730-e715f4ff-5825-4aae-b490-686ed50eb2fb.mov

- *Lưu ý*: Ở widget *Scaffold* ta có thuộc tính `appBar`. Khi ta dùng `appBar` thì sẽ có sẵn nút *Back* để chúng ta có thể *pop* về màn hình trước


    

# 4.2 Route (Đ. Anh)

- `Route`: An abstraction for an entry managed by a Navigator

- Chúng ta có thể làm việc với các tuyến đường được đặt tên bằng sử dụng hàm *Navigator.pushNamed()*. 

- Example:

Chúng ta cần xác định các tuyến đường(routes)

```
return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/detail': (context) => DetailScreen(),
      },
      home: HomeScreen(),
    );
```

Sau đó điều hướng đến màn hình mong muốn bằng *Navigator.pushNamed()*
```
ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/detail');
              },
              child: Text('Next'),
            )
```

Sử dụng *Navigator.pop()* để quay lại màn hình đầu tiên
```
ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back'),
            )
```

- Kết quả:

https://user-images.githubusercontent.com/61812892/133726818-55f1bb7b-6e7f-4045-b80d-f03d5127c50f.mov

# 4.3 Di chuyển dữ liệu giữa các màn hình (Đ. Anh)

- Có 2 cách chuyển dữ liệu từ màn hình A sang màn hình B:
    - Truyền thông qua contructor
    - Truyền qua arguments

- Example: Truyền thông qua contructor

Ở Home ta truyền dữ liệu qua Detail bằng *Navigator.push*

```
ElevatedButton(
              onPressed: () {
                // Contructor
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => EditInfo(value: textField.text)));
              },
              child: Text('Send data'),
            ),
```

Ở màn hình Detail ta nhận dữ liệu và show lên màn hình

```
class EditInfo extends StatelessWidget {
  const EditInfo({Key? key, required this.value}) : super(key: key);

  final String value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Info'),
      ),
      body: Center(
        child: Text('Gia tri = $value'),
      ),
    );
  }
}
```

Kết quả

https://user-images.githubusercontent.com/61812892/133933425-7952c2aa-2fc9-443c-af20-089c429d2b19.mov

- Example: Truyền thông qua Argument

Ở màn hình Home ta dùng thuộc tính `arguments` của *Navigator.pushNamed* để truyền dữ liệu qua màn hình Detail

```
ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/edit_info',
                    arguments: textField.text);
              },
              child: Text('Send data'),
            ),
```

Ở màn hình Detail ta nhận dữ liệu bằng *ModalRoute.of(context)?.settings.arguments* và ép kiểu nó về kiểu dữ liệu mà chúng ta truyền (*as String*)

```
class EditInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String name = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Info'),
      ),
      body: Center(
        child: Text('Gia tri = $name'),
      ),
    );
  }
}
```

Kết quả

https://user-images.githubusercontent.com/61812892/133933433-be528dc4-2a00-4b98-8245-23ca2ce15515.mov

- Example: Trả dữ liệu từ Detail về Home ta truyền param muốn trả về vào *Navigator.pop(context, `param cần trả về`)*

Ở màn hình Home ta dùng `await` để lấy dữ liệu từ Detail trả về

```
...
ElevatedButton(
        onPressed: () async {
            final nameTitle = await Navigator.pushNamed(
                    context, '/edit_info',
                    arguments: textField.text);
            setState(() {
                name = nameTitle.toString();
            });
        },
        child: Text('Send data'),
    ),
...
```

Ở màn hình Detail ta truyền param vào *Navigator.pop(context, param)*
```
...
ElevatedButton(
        onPressed: () {
            Navigator.pop(context, textField.text);
        },
        child: Text('Edit name'),
    )
...
```

Kết quả
https://user-images.githubusercontent.com/61812892/133956233-c6260f88-74cd-4210-91aa-be54739aa9c5.mov
