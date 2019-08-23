# flutter_stretchable_text_view

a library for stretchable and shrinkable text view.

* just like the image below: 

<img height="300em" src="readme-images/detailWithNote.jpg">
<p></p>
<img height="300em" src="readme-images/stretchableText.gif">

## How to Use

```yaml
# add this line to your dependencies
flutter_stretchable_text_view: ^1.0.0+1
```

```dart
import 'package:flutter_stretchable_text_view/main.dart';
```

```dart
// simple demo
StretchableTextView(
  text: 'your text...'
)
```

```dart
// complex demo
StretchableTextView(
  maxLines: 4, // default value is 3
  suffix: '......', // default value is ...
  spreadBtn: TextSpan(
    text: 'more', // default value is 更多
    style: TextStyle(
      color: Colors.blueGrey,
    ),
  ),
  textStyle: TextStyle(
    height: 1.2,
    fontSize: 12,
    color: Colors.black,
  ),
  text: 'your text...'
)
```

* getting example with this library, view: [flutter_examples/可伸缩文本组件例子(stretchable and shrinkable text view)](https://github.com/shellhong6/flutter_examples)
<!-- * getting source with this library, view[flutter_stretchable_text_view](https://github.com/shellhong6/flutter_stretchable_text_view) -->
* getting example about flutter app, view: [books_app](https://github.com/shellhong6/books_app)

## Show some :heart: and star the repo to support the project