# 5.1 Future  (Anh Thinh, Hạnh)
- Lập trình bất đồng bộ:
  - Lập trình bất đồng bộ là hoạt động cho phép chương trình thực hiện tiếp các công việc mà trong khi chờ các công
việc khác vẫn đang trong quá trình hoàn thành.
  - Giúp ứng dụng mượt hơn, nhanh hơn vì chờ quá lâu từng task chạy một
  
  ![Screen Shot 2021-09-19 at 11 42 21](https://user-images.githubusercontent.com/55979453/133915722-160e0a07-a3ed-4872-92fb-3124cd670a4d.png)
  
- Lập trình bất đồng bộ dùng khi nào?
  - Lập trình bất đồng bộ dùng khi :
    - Lấy dữ liệu từ Server, Firestore
    - Ghi, update vào database ví dụ : SQFlite + Đọc nội dung từ file
  - Dấu hiệu nhận biết khi đọc code : Future, async, await, then, stream

- Future là gì?
  - Future là một thể hiện của class Future. Một future đại diện cho một hoạt động bất đồng bộ.
- Future còn đi theo với **async** và **await**
  - async : được đặt trước khối chứa await, nó đánh dấu là bất đồng bộ.
  - await : được đặt bên trong async và đặt ở trước các phương thức thực hiện việc load dữ liệu, hay ghi, update vào database..
- Phân Loại
  - Future
    ```javascript
        Future<String> getUserOrder() {
        return Future.delayed(Duration(seconds: 3), () => print('Nhóm 5'));
        }

        main() {
          getUserOrder();
          print('Hi!');
        }
    ```
    - Kết quả là: nó sẽ in ra "Hi!" sau 3 giây nó in ra tiếp "Nhóm 5"
    - Lưu ý:
      - Một thể hiện Future<T> cung cấp một giá trị kiểu T.
      - Nếu một future không cung cấp một giá trị hữu dụng thì kiểu của future là Future<void>.
      - Khi một hoạt động của future kết thúc, future hoàn thành với một giá trị hoặc một error.
  - FutureBuilder
    ```javascript
        FutureBuilder<List<MovieModel>>(
          future: ApiServces().fetchMovieList(),
          builder: (context, AsyncSnapshot? snapshot) {
            if ((snapshot!.hasError) || (!snapshot.hasData)) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            List<MovieModel>? videoList = snapshot.data;
            return itemPopulars(itemPopular: videoList);
          },
      ),
    ```
    - Video ví dụ trên 
      
      https://user-images.githubusercontent.com/55979453/133916250-d6f8949f-6ab8-4fb1-a1e7-07c25e004ceb.mov

# 5.2 Streams  (Đ.Anh, An)

- `Stream` là một luồng data bất đồng bộ, nó như là một cái ống sẽ có dữ liệu đầu vào và dữ liệu đầu ra

- [Hình ảnh minh hoạ](https://images.viblo.asia/f7b1b7b2-4c2e-45e3-9f81-787574149abc.png)
    - Để handle một *Stream* thì ta có *StreamController*
    - Để đẩy dữ liệu vào *Stream* thì thông qua thuộc tính *sink*(Ta có thể đẩy bất kỳ cái gì vào *Stream*: value, object, collection, error...)
    - Để publish dữ liệu ra ngoài thì chúng ta dùng thuộc tính *stream*
    - Để transform, modify hay bất kỳ một thao tác để chỉnh sửa như xoá, cập nhật thì chúng ta dùng *StreamTransformer*
    
- Có bao nhiêu loại *Stream*:
    - Single-Subscription Stream
    - Broadcast Streams
    
- `Single-Subscription Stream`: Khi chúng ta dùng stream để publish dữ liệu ra ngoài, nếu sử dụng *Single-Subscription Stream* thì chỉ được phép đăng ký lắng nghe dữ liệu một lần

Example:

Ta tạo 1 class MyStream

```
import 'dart:async';

class MyStream {
  int counter = 0;
  StreamController counterController = new StreamController<int>();
  Stream get counterStream => counterController.stream;

  void increment() {
    counter += 1;
    counterController.sink.add(counter);
  }

  void dispose() {
    counterController.close();
  }
}
```

Ở MyHomePage ta dùng `StreamBuilder` để lắng nghe Stream phát đi

```
class _MyHomePageState extends State<MyHomePage> {
  MyStream myStream = new MyStream();

  @override
  void dispose() {
    myStream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // myStream.counterStream.listen((event) {
    //   print(event);
    // });
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('You have pushed the button this many times'),
              StreamBuilder(
                stream: myStream.counterStream,
                builder: (context, snapshot) => Text(
                  snapshot.hasData ? snapshot.data.toString() : '0',
                  style: Theme.of(context).textTheme.headline4,
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            myStream.increment();
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ));
  }
}
```

Ta thêm 1 lắng nghe

```
myStream.counterStream.listen((event) {
    print(event);
});
```


Kết quả: Kết quả sẽ hiện lỗi. Nhưng khi ta dùng với `Broadcast Streams` thì sẽ không lỗi nhé

[Error](https://images.viblo.asia/d5f7f8b6-1e89-4a18-a5b1-35e1f45e1874.png)


- `Broadcast Streams`: cho phép nhiều chỗ có thể lắng nghe sự kiện thay đổi dữ liệu của Stream

Example: Cũng tương tự như ở `Single-Subscription Stream` ta chỉ cần thêm `broadcast()`. Thì Demo sẽ chạy mượt mà nhé:

```
StreamController counterController = new StreamController<int>.broadcast();
```

Kết quả:

https://user-images.githubusercontent.com/61812892/133985318-4db7e886-17ad-46d3-a72d-90251c9006fc.mov

- Cách xử lý dữ liệu Stream trước khi đẩy ra ngoài. Ta có thể xử lý dữ liệu trước khi stream publish dữ liệu ra ngoài với *transformer*

Example:

```
import 'dart:async';

class MyStream {
  int counter = 0;
  StreamController counterController = new StreamController<int>.broadcast();
  Stream get counterStream =>
      counterController.stream.transform(counterTranformer);

  var counterTranformer =
      StreamTransformer<int, int>.fromHandlers(handleData: (data, sink) {
    data += 5;
    sink.add(data);
  });

  void increment() {
    counter += 1;
    counterController.sink.add(counter);
  }

  void dispose() {
    counterController.close();
  }
}
```

Kết quả:

https://user-images.githubusercontent.com/61812892/133985742-854c69b4-2da6-47f6-a096-e56aae27a1fb.mov

- Ngoài ra, ở `Future` ta dùng từ khoá *async* để nhận biết một hàm bất đồng bộ. Thì ở `Stream` ta dùng *async*. Mọi có thể click vào [đây](https://flutteragency.com/what-is-difference-between-async-and-async-in-dart/) để phân biệt được giữa *async* và *async** nhé

- `async`: Nó được dùng trong `Future`. Khi khai báo ở một function thì ta sẽ biết hàm đó là bất đồng bộ, nó thực hiện một số công việc có thể mất nhiều thời gian. Ta sẽ trả về một giá trị bằng từ khoá `return`
- `async*`: Nó được dùng trong `Stream`. Khi khai báo ở một function thì ta cũng sẽ biết đó là hàm bất đồng bộ, nó sẽ trả về một loạt các giá trị tương lai tại một thời điểm. Ta sẽ trả về một giá trị bằng `yield`

- Example:

```
Stream<int> countForOneMinute() async* {
  for (int i = 1; i <= 60; i++) {
    await Future.delayed(const Duration(seconds: 1));
    yield i;
  }
}

```
- Ta có thể dùng `await for` để chờ đợi từng giá trị được trả về
```
await for (int i in countForOneMinute()) {
    print('Number: $i');
  }
```

Kết quả:
```
Number: 1
Number: 2
Number: 3
Number: 4
....
Number: 60
```

- Example: Xử lý lỗi kết hợp giữa `Future` and `Stream`

```
Future<int> sumStream(Stream<int> stream) async {
  var sum = 0;
  try {
    await for (var value in stream) {
      sum += value;
    }
  } catch (error) {
    return -1;
  }
  return sum;
}

Stream<int> countStream(int to) async* {
  for (int i = 0; i <= to; i++) {
    if (i == 4) {
      throw Exception('Intentinal exception');
    } else {
      yield i;
    }
  }
}

void main() async {
  var stream = countStream(10);
  var sum = await sumStream(stream);
  print(sum); // -1
}
```
