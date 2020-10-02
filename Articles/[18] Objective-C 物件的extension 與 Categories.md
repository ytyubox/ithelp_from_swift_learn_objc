# [18] 30 天從 Swift 學會 Objective-C：Objective-C 物件的 extension 與 Categories

對現成的事物做延伸是人類獨有的能力，像是水可以載舟，同時也能煮粥。而程式語言也能透過延伸來替現存的物件提供拓展。

![](https://images.unsplash.com/photo-1596464716127-f2a82984de30?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80)
Photo by [@sigmund](https://unsplash.com/@sigmund) on [Unsplash](https://unsplash.com/photos/OV44gxH71DU)

## Swift 的 extension 

在 Swift 中，我們可以根據 [Extension - Swift.org](https://docs.swift.org/swift-book/LanguageGuide/Extensions.html) 的開頭引言，我們可以知道 Extension 可以為現存的類別拓展，尤其是當類別沒有編輯權限的時候。

> Extensions add new functionality to an existing class, structure, enumeration, or protocol type. This includes the ability to extend types for which you do not have access to the original source code (known as retroactive modeling).

## Objective—C 的 Extension 不是 Swift 的 Extension
在 Objective-C 有所謂的 Category 和 Extension，在這裏我們要先告訴讀者：

> Objective—C 的 Extension 不是 Swift 的 Extension

在  [Extension - Swift.org](https://docs.swift.org/swift-book/LanguageGuide/Extensions.html) 同時提到了 Swift 的 Extension 是與 Objective-C 的 Category 相似的：

> Extensions are similar to categories in Objective-C. (Unlike Objective-C categories, Swift extensions do not have names.)

https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/CustomizingExistingClasses/CustomizingExistingClasses.html

也因此我們可以知道 Category 的目的是：
> 提供現有的類別更多的 function。

```objectivec
// Objective-C
/* NSNumber+abs.h */
@interface NSNumber (abs)
- (int) absIntValue;
```

然而這
Categories Add Methods to Existing Classes

Class Extensions Extend the Internal Implementation

Consider Other Alternatives for Class Customization
Categories and class extensions make it easy to add behavior directly to an existing class, but sometimes this isn’t the best option.

One of the primary goals of object-oriented programming is to write reusable code, which means that classes should be reusable in a variety of situations, wherever possible. If you’re creating a view class to describe an object that displays information on screen, for example, it’s a good idea to think whether the class could be usable in multiple situations.

Rather than hard-coding decisions about layout or content, one alternative is to leverage inheritance and leave those decisions in methods specifically designed to be overridden by subclasses. Although this does make it relatively easy to reuse the class, you still need to create a new subclass every time you want to make use of that original class.

Another alternative is for a class to use a delegate object. Any decisions that might limit reusability can be delegated to another object, which is left to make those decisions at runtime. One common example is a standard table view class (NSTableView for OS X and UITableView for iOS). In order for a generic table view (an object that displays information using one or more columns and rows) to be useful, it leaves decisions about its content to be decided by another object at runtime. Delegation is covered in detail in the next chapter, Working with Protocols.

