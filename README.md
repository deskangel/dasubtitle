# DASUBTITLE

### 简介
一个电影字幕工具，提供以下功能：

    - 平移时间轴 （ASS文件格式已经支持）
    - 合并字幕 （未实现）

### 使用
```bash
dasubtitle -t [+/-]milliseconds input_file -o output_file

-t, --time (mandatory)    in milliseconds. positive to delay and negative to rush
-o, --output
```
如果字幕的文件编码不是`utf-8`，需要使用`iconv`转换成`utf-8`，比如：
```bash
iconv -t utf-16le -f utf8 s.ass > t.ass
```

### 编译
`dart compile exe bin/dasubtitle.dart`

### 其他
如果你觉得这个 应用 有点用处，可以考虑[捐助一下](https://blog.deskangel.com/images/wx_donate.png)让我保持动力。
