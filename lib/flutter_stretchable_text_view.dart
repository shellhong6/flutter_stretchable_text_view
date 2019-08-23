import 'package:flutter/material.dart';

class StretchableTextView extends StatefulWidget {
  static const double fontSize = 12;
  @required final String text;
  final int maxLines;
  final TextStyle textStyle;
  final TextSpan spreadBtn;
  final String suffix;
  StretchableTextView({Key key, this.text, this.maxLines = 3, this.textStyle = const TextStyle(fontSize: fontSize, color: Colors.black), this.spreadBtn, this.suffix = '...'}):super(key:key);
  @override
  State<StatefulWidget> createState() {
    return StretchableTextViewState();
  }
}

class StretchableTextViewState extends State<StretchableTextView> {
  List<Widget> shrinkWidgets = [];
  List<Widget> stretchWidgets = [];
  List<Widget> widgets = [];
  bool isStretch = false;
  // double lineHeight = 0;
  @override
  void initState() {
    super.initState();
    // lineHeight = (widget.textStyle?.fontSize??StretchableTextView.fontSize) * (widget.textStyle?.height);
    TextPainter painter = new TextPainter();
    painter.textDirection = TextDirection.ltr;
    WidgetsBinding.instance.addPostFrameCallback((callback){
      RegExp mulLineSel = new RegExp('(\r)?(\n)');
      final double containerW = this.context.findRenderObject().paintBounds.size.width;
      String _text = widget.text;
      String temp1 = '';
      String temp2 = '';
      painter.maxLines = 1;
      int i = 0;
      while (_text.length != 0) {
        int index = _text.indexOf(mulLineSel);
        temp1 = this.getOneLineText(_text.substring(0, index == -1 ? _text.length : index), containerW, painter, isLast: false);
        stretchWidgets.add(this.createLineText(temp1));
        if (i < widget.maxLines - 1) {
          shrinkWidgets.add(this.createLineText(temp1));
        } else if (i == widget.maxLines - 1) {
          temp2 = this.getOneLineText(_text.substring(0, index == -1 ? _text.length : index), containerW, painter, isLast: true);
          if (_text.length == temp2.length) {
            shrinkWidgets.add(this.createLineText(temp2));
          } else {
            shrinkWidgets.add(
              this.createWrapLine(
                Row(
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        text: temp2 + widget.suffix,
                        style: widget.textStyle
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: RichText(
                        textAlign: TextAlign.right,
                        text: widget.spreadBtn??this.createSpreadBtn(),
                      ),
                    ),
                  ],
                )
              )
            );
          }
        }
        _text = _text.substring(temp1.length);
        if (index != -1) {
          _text = _text.replaceFirst(mulLineSel, '');
        }
        i++;
      }
      this.widgets = this.shrinkWidgets;
      this.setState((){});
    });
  }

  String getOneLineText (String text, double containerW, TextPainter painter, {bool isLast = false}) {
    int i = 1;
    for (;i <= text.length; i++) {
      painter.text = this.createTextSpan(text.substring(0, i), isLast);
      painter.layout();
      if(painter.size.width > containerW){
        return text.substring(0, i - 1);
      }
    }
    return text;
  }

  TextSpan createTextSpan (String text, bool isLast) {
    if (isLast) {
      return TextSpan(
        text: text + '${widget.suffix}   ',
        style: widget.textStyle,
        children: [
          widget.spreadBtn??this.createSpreadBtn()
        ]
      );
    } else {
      return TextSpan(
        text: text,
        style: widget.textStyle
      );
    }
  }

  TextSpan createSpreadBtn () {
    return TextSpan(
      text: '更多',
      style: TextStyle(
        color: Colors.blue[200],
        fontSize: (widget.textStyle?.fontSize)??StretchableTextView.fontSize
      ),
    );
  }

  SizedBox createWrapLine (Widget widget) {
    return SizedBox(
      // height: lineHeight,
      width: this.context.findRenderObject().paintBounds.width,
      child: widget,
    );
  }

  SizedBox createLineText (String text) {
    return createWrapLine(
      RichText(
        text: TextSpan(
          text: text,
          style: widget.textStyle
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.widgets,
      ),
      onTap: () {
        if (isStretch) {
          this.widgets = this.shrinkWidgets;
        } else {
          this.widgets = this.stretchWidgets;
        }
        isStretch = !isStretch;
        this.setState((){});
      }
    );
  }
}