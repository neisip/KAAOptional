<p align="center">
  <a href="https://github.com/neisip/KAAOptional"><img alt="KAAOptional: Optionals for Objective C" src="https://raw.githubusercontent.com/neisip/KAAOptional/master/KAAOptional.PNG"/></a>
</p>

<p align="center">
  <a href="https://travis-ci.org/neisip/KAAOptional"><img alt="Build status" src="https://travis-ci.org/neisip/KAAOptional.svg?branch=master"/></a>
  <a href="http://codecov.io/github/neisip/KAAOptional"><img alt="Code coverage status" src="http://codecov.io/github/neisip/KAAOptional/coverage.svg?branch=master"/></a>
  <a href="https://cocoapods.org/pods/KAAOptional"><img alt="CocoaPods" src="https://img.shields.io/cocoapods/v/KAAOptional.svg"/></a>
    <a href="https://github.com/Carthage/Carthage"><img alt="Carthage" src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat"/></a>
</p>

KAAOptional is Objective-C library which adds Optional support.

- [Features](#features)
- [Usage](#usage)
- [Installation](#installation)

## Features

- [x] Lightweight Generics for content value
- [x] Dictionary now can return Optionals on subscript methods call
- [x] Full Java 8 syntax (streams, control flow, functional extensions: map, flatMap, filter)
- [x] Optional behave same way as swift optional: chaining support, doesn't crash on unrecognised message sent if empty and crashes if not and value cannot respond, proxies messages to it's value, behaves same on equality.
- [x] Dot notation support
- [x] Tested and well documented

## Usage

# Control flow:

> Now in swift 5.0:
```
func fetch() -> String? {
  //Some big work
  ...
  return "123"
}

if let e = fetch() {
  print(e)
} else {
  //Do something
  print("Empty")
}
```
> In Objective-C with KAAOptional:
```
- (nonnull Optional<NSString *> *)fetch {
    //Some big work
    ...
    return Optional.of(@"123");
}

[[self fetch] ifPresent:^(NSNumber * _Nonnull aValue) {
      NSLog(@"%@", aValue);
    } orElse:^{
        NSLog(@"Empty");
}]];
```

# Get functional extensions.

## Now in swift 5.0:

```
var res = "404"

if let e = fetch(),
let r = Int(e),
r > 123 {
    res = e
}
print(res)

```
## In Objective-C with KAAOptional using functional extensions:

```
- (nonnull Optional<NSString *> *)fetch {
    //Some big work
    ...
    return Optional.of(@"123");
}

__auto_type const a = [[[self fetch] filter:^BOOL(NSString * _Nonnull aValue) {
      return aValue.integerValue > 123 && [aValue isKindOfClass:[NSString class]];
  }] orElse:@"404"];

NSLog(@"%@", a);
```  
> or with .dot notation
```
__auto_type const b = [self fetch]
  .filter(^BOOL(NSString * _Nonnull aValue) {
      return aValue.integerValue > 123 && [aValue isKindOfClass:[NSString class]];
  }).orElse(@"404");
NSLog(@"%@", b);
```

Supports Java 8 style
- stream
- map
- flatMap
- filter

# Subscript on Dictionary now returns Optional.

## In swift:
```
var a = ["K": "V"]["K"] // Returns Optional
if let a = a { // Unwraps

}
```
## In Objective-C using Optional

You can enable it pointwise by calling *"op"* method on Dictionary.
Or enable it by default by calling *"[NSDictionary kaa_enableOptionalByDefault]"* once anywhere.
**⚠️⚠️⚠️ WARNING ⚠️⚠️⚠️**
Beware - even though Optional behaves like proxy: `-isEqual`, `-isKindOfClass`, `-isMemberOfClass` will work fine on old code,
calling `+class` and `+superClass` - will return `Optional` and `NSObject`.

```
__auto_type a = @{
                  @"K": @"V"
                 }.op;
NSLog(@"%@", a[@"K"]); //-> <Optional: 0xSomeAddress, Value: @"V">
NSLog(@"%@", a[@"wrongKey"]); //-> <Optional: 0xSomeAddress, Value: nil>
```

> *Note: Following construct will not crash due to internal catch logic. So your old code is safe!*
```
[NSDictionary kaa_enableOptionalByDefault];
...
__auto_type a = [@{
                  @"K": [MyObject new]
                 }[@"K2"] myOldMessage];
// Will react same as nil messaging
NSLog(@"I didn't crash!");

```
> *Note: Following construct will proxy to value. So it's also safe!*
```
[NSDictionary kaa_enableOptionalByDefault];
...
NSUInteger i = [@{@"K": @"V"} length];
NSLog(@"%@", @(i)); // Will output = 1
```

> *You can even chain subscript!!!*

```
__auto_type a = @{
                     @"K": @[@{@"K2": @"V"}]
                     };
   //By using subscript, you get optional! An it can be chained!
   __unused NSString *b = a[@"K"][0][@"K2"].orElse(@"V2");
```

> *And of course - just chain optionals!!!*

```
NSString *a = Optional.of(Optional.of(@"123")).get;
```

# Equality

## In swift
```
var a = ["K": "V"]["K"]
print(a == "V") // true
```

## In Objective-C using KAAOptional
```
[@{@"K": @"V"}.op[@"K"] isEqual:@"K"] // YES
```

## Installation

### CocoaPods

```ruby
target '<Your Target Name>' do
    pod 'KAAOptional', '~> 1.0.2'
end
```

### Carthage

```
github "neisip/KAAOptional"
```

## License

KAAOptional is released under the MIT license. [See LICENSE](https://github.com/neisip/KAAOptional/blob/master/LICENSE) for details.
