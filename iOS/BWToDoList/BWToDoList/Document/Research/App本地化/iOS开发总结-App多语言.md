## iOS开发总结-App多语言

App根据系统设置的不同，显示为对应的语言，是开发国际化App的一个很基本的需求。

iOS有自身管理系统语言和系统的机制，在如下的面板上设置系统语言和地区：设置 -> 通用 -> 语言和地区 -> 语言。

![ios_device](/Users/BobWong/BobWong/Development/Github/Product/to-do-list/iOS/BWToDoList/BWToDoList/Document/Research/App本地化/ios_device.png)

在每次切换新语言时，都会先Kill原有App，下次打开App时，重新加载新的语言相关的配置。

也可以在应用内做语言的切换，现在主流的应用都支持这种功能，本文总结系统切换语言和应用内切换语言的两种实现方式。

Demo：https://github.com/bobwongs/to-do-list

### 系统切换语言

**新增语言**

![ios_add_language](/Users/BobWong/BobWong/Development/Github/Product/to-do-list/iOS/BWToDoList/BWToDoList/Document/Research/App本地化/ios_add_language.png)

**Localizable.strings文件**

> 新建

必需命名为Localizable.strings，系统提供的相关读取本地化string的宏定义方法，是读此文件中的内容

![localizable_file](/Users/BobWong/BobWong/Development/Github/Product/to-do-list/iOS/BWToDoList/BWToDoList/Document/Research/App本地化/localizable_file.png)

> strings编写

开发经验总结，使用简体中文为key值，可以减少一套简体中文的语言配置，NSLocalizedString此类宏定义方法，在通过key值获取value时，若没找到对应的value值，则返回key值。

在此示例为语言的全套配置

![ios_localizable_strings](/Users/BobWong/BobWong/Development/Github/Product/to-do-list/iOS/BWToDoList/BWToDoList/Document/Research/App本地化/ios_localizable_strings.png)

**使用**

```objective-c
// 读取本地化相关string的方法
#define NSLocalizedString(key, comment) \
	    [NSBundle.mainBundle localizedStringForKey:(key) value:@"" table:nil]
#define NSLocalizedStringFromTable(key, tbl, comment) \
	    [NSBundle.mainBundle localizedStringForKey:(key) value:@"" table:(tbl)]
#define NSLocalizedStringFromTableInBundle(key, tbl, bundle, comment) \
	    [bundle localizedStringForKey:(key) value:@"" table:(tbl)]
#define NSLocalizedStringWithDefaultValue(key, tbl, bundle, val, comment) \
	    [bundle localizedStringForKey:(key) value:(val) table:(tbl)]

// 使用示例
NSString *text = NSLocalizedString(@"待办事项", nil);
```

**Xib/Storyboard中的语言**

> 开启Localization

![ios_ib_localize](/Users/BobWong/BobWong/Development/Github/Product/to-do-list/iOS/BWToDoList/BWToDoList/Document/Research/App本地化/ios_ib_localize.png)

> 配置相应语言的文本

![ios_xib_sample](/Users/BobWong/BobWong/Development/Github/Product/to-do-list/iOS/BWToDoList/BWToDoList/Document/Research/App本地化/ios_xib_sample.png)

> 借助脚本做修改

运用脚本做对编辑过的Xib/Storyboard进行修改，脚本链接：

https://raw.githubusercontent.com/mokai/iOS-i18n/master/i18n/RunScript/AutoGenStrings.py

**图片资源的本地化**

> 原生支持

不需要把图片放在Images.xcassets里面，放在自定义的Group里，对图片进行本地化，引用时，跟普通图片一样使用。

> 自定义文本命名

利用文本国际化的方式，在代码中调用。此方法的弊端是不能在Storyboard和XIB中使用，二是工作量明细增大。

### 应用内语言切换

> 下一个研究项