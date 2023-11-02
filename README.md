# Nson

[![Swift](https://img.shields.io/badge/Swift-5-orange.svg)](https://github.com/devhplusn/Nson)
[![Platforms](https://img.shields.io/badge/Platforms-iOS|macOS|tvOS|watchOS-black?style=flat)](https://github.com/devhplusn/Nson)
[![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](https://github.com/devhplusn/Nson/blob/master/LICENSE)

Nson provides a more convenient way to handle Decodable and Encodable through Property Wrappers.

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [License](#license)

## Requirements


- Swift 5.0
- iOS 11.0+
- macOS 10.13+
- tvOS 11.0+
- watchOS 4.0+

## Installation


#### Swift Package Manager

You can use The Swift Package Manager to install Nson by adding the proper description to your Package.swift file:

```swift
import PackageDescription

let package = Package(
    name: "YOUR_PROJECT_NAME",
    targets: [],
    dependencies: [
        .package(url: "https://github.com/devhplusn/Nson.git", from: "1.0.0")
    ]
)
```

#### Cocoapods

Nson is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```
pod 'Nson', :tag => '1.0.0', :git => 'https://github.com/devhplusn/Nson'
```

## Usage

### Support alter Key

@Key allows you to process JSON decoding or encoding without CodingKeys and using custom keys.
@Key uses the <- operator or KeyPaths to define how it maps to and from JSON.
The nested key accepts additional keys as arguments.
The object needs to implement the NSON protocol.

#### Example JSON:

```
{
  "name": "tanaka",
  "info": {
    "age": 20,
    "gender": "M",
    "email_address": "tanaka@gmail.com"
  }
}
```

#### vanilla Codable:

```swift

struct Model {

    var name: String
    var age: Int
    var gender: String
    var email: String

    enum CodingKeys: String, CodingKey {
        case name
        case info
    }

    enum InfoKeys: String, CodingKey {
        case age
        case gender
        case email = "email_address"
    }
}

extension Model: Decodable {

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        let nestedContainer = try container.nestedContainer(keyedBy: InfoKeys.self, forKey: .info)
        age = try nestedContainer.decode(Int.self, forKey: .age)
        gender = try nestedContainer.decode(String.self, forKey: .gender)
        email = try nestedContainer.decode(String.self, forKey: .email)
    }
}

extension Model: Encodable {

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        var nestedContainer = container.nestedContainer(keyedBy: InfoKeys.self, forKey: .info)
        try nestedContainer.encode(age, forKey: .age)
        try nestedContainer.encode(gender, forKey: .gender)
        try nestedContainer.encode(email, forKey: .email)
    }
}
```

#### Nson:

```swift

struct Model: Codable, NSON {

    var name: String
    @Key("age" <- ["info", "age"])
    var age: Int
    @Key(to: \.gender, "info", "gender")
    var gender: String
    @Key("email" <- ["info", "email_address"])
    var email: String
}

// Decode
let model = try NSONDecoder().decode(Model.self, from: jsonData)

// Encode
let data = try NSONEncoder().encode(model)
```

### Support flat

When you need to decode flat JSON values into nested structures or encode nested structures into flat JSON, you can handle it through the use of the @Flat property wrapper.

#### Example JSON:

```
{
  "name": "tanaka",
  "info_age": 20,
  "info_gender": "M"
}
```

#### Usage:

```swift

struct Model: Codable {

    var name: String
    @Flat
    var info: ModelInfo
}


struct ModelInfo: Codable, NSON {

    @Key("age" <- "info_age")
    var age: Int
    @Key(to: \.gender, "info_gender")
    var gender: String
}
```

### Support transformer

To add custom transformations, please implement DecodeTransformable, EncodeTransformable, or CodeTransformable for bidirectional transformations.

#### Example JSON:

```
{
    "count": "10"
    "date": "2023-11-01"
}
```

#### Usage:

```swift
struct Object: Decodable {

    @Transform<ToInt>
    var count: Int

    @Transform<ToDate>
    var date: Date?
}

enum ToInt: CodeTransformable {

    typealias Value = Int

    static func transform(decoded: String) throws -> Value {
        Int(decoded) ?? 0
    }

    static func transform(value: Int) throws -> String {
        String(value)
    }
}

enum ToDate: DecodeTransformable {

    public typealias Value = Date?

    public static func transform(decoded: String) throws -> Value {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: decoded)
    }
}

```

### PropertyWrapper Combine

Can combine @Key and @Transform to handle JSON keys and transform decoded values when needed.

#### Example JSON:

```
{
    "count": "10"
}
```

#### Usage:

```swift
struct Object: Decodable {

    @Key("m_count" <- "count")
    @Transform<ToInt>
    var m_count: Int
}

enum ToInt: DecodeTransformable {

    typealias Value = Int

    static func transform(decoded: String) throws -> Value {
        Int(decoded) ?? 0
    }
}
```


## License

These works are available under the MIT license. See the [LICENSE][license] file
for more info.


[license]: LICENSE
