# [28] 30 天從 Swift 學會 Objective-C：Swift friendly 的 API Swift name

在 Objective-C 與 Swift 的命名有明顯的區別，雖然 Swift interface 可以將 Objective-C 的 API 以一定程度的方式改寫為 Swift 命名方式。

![](https://images.unsplash.com/photo-1516384100354-0e0bbc0d2e00?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80)

Photo by [@jontyson](https://unsplash.com/@jontyson) on [Unsplash](https://unsplash.com/photos/566CgCRSNCk)

## 可以改寫的部分
Objective-C 的 `Foundation/Foundtion.h` 提供了 `NS_SWIFT_NAME` 作為改寫 API 的關鍵字：

```objectivec
// Objective-C
NS_SWIFT_NAME(Sandwich.Preferences)
@interface SandwichPreferences : NSObject

@property BOOL includesCrust NS_SWIFT_NAME(isCrusty);

@end

@interface Sandwich : NSObject
@end
```
> 範例來自 Apple Developer Documentation [註 1]

其相對應的 Swift interface 則是
![](https://i.imgur.com/3M8Yq0O.png)



## 一些限制

Swift interface 並不是萬能的，在提供方便的 `NS_SWIFT_NAME` 的同時，有幾個要避免的事情：
1. Namespace 的使用只有 1 個，如`Sandwich.Preferences.Detail` 是不能使用的 
```objectivec
// Objective-C
NS_SWIFT_NAME(Sandwich.Preferences.Detail) // 'swift_name' attribute has invalid identifier for base name
@interface SandwichPreferencesDetail : NSObject
@end
```
> 正確使用的方式是 `NS_SWIFT_NAME(SandwichPreferences.Detail)`

2. 參數的順序是不可以更改的。

## [進階] NS_REFINED_FOR_SWIFT 隱藏 API
之前說到在 public header 的實作是會自動出現在 Swift interface 的，但是當我們想要透過改寫 API 的順序或是不想讓 Swift client 使用不方便的 API (如: ObjcBool 與 Swift.Bool)，我們可以使用 `NS_REFINED_FOR_SWIFT` 的關鍵字來處理。
```objectivec
// Objective-C
@interface Color : NSObject
 
- (void)getRed:(nullable CGFloat *)red
         green:(nullable CGFloat *)green
          blue:(nullable CGFloat *)blue
         alpha:(nullable CGFloat *)alpha NS_REFINED_FOR_SWIFT;
 
@end

```
> 範例來自 Apple Developer Documentation [註 2]
```swift
// Swift
extension Color {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0
        __getRed(red: &r, green: &g, blue: &b, alpha: &a)
        return (red: r, green: g, blue: b, alpha: a)
    }
}
```
請注意的是 `__getRed` 是不存在於 Swift interface 的。
![](https://i.imgur.com/DqkoT25.png)

## 註記
1. [Renaming Objective-C APIs for Swift - Apple Developer Documentation](https://developer.apple.com/documentation/swift/objective-c_and_c_code_customization/renaming_objective-c_apis_for_swift)
2. [Improving Objective-C API Declarations for Swift - Apple Developer Documentation](https://developer.apple.com/documentation/swift/objective-c_and_c_code_customization/improving_objective-c_api_declarations_for_swift)

## 簡單測驗
1. Swift 官方有所謂的 API 編寫規範，請問在哪裡可以找到？
2. [進階] Swift interface 透過哪些機制將 Objective-C API 自動轉譯為 Swift API
