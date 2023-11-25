// Task 1
typealias Item = String

// Task 2
protocol Storable {
  func serialize() -> Item
  static func deserialize(from item: Item) -> Self?
}

// Task 3
extension Int: Storable {
  func serialize() -> Item {
    return Item(self)
  }
  
  static func deserialize(from item: Item) -> Self? {
    return Int(item)
  }
}

extension Double: Storable {
  func serialize() -> Item {
    return Item(self)
  }
  
  static func deserialize(from item: Item) -> Self? {
    return Double(item)
  }
}

extension String: Storable {
  func serialize() -> Item {
    return self
  }
  
  static func deserialize(from item: Item) -> Self? {
    return item
  }
}

// Task 4
protocol Storage {
  func save<Value: Storable>(key: String, value: Value)
  func retrieve(key: String) -> Optional<Item>
  func remove(key: String)
}

// Task 5
class Cache: Storage {
  var storage: [String: Storable] = [:]

  func save<Value: Storable>(key: String, value: Value) {
    storage[key] = value
  }

  func retrieve(key: String) -> Item? {
    return storage[key]?.serialize()
  }

  func remove(key: String) {
    storage.removeValue(forKey: key)
  }
}

class Disk: Storage {
  var storage: [String: Storable] = [:]

  func save<Value: Storable>(key: String, value: Value) {
    storage[key] = value
  }

  func retrieve(key: String) -> Item? {
    return storage[key]?.serialize()
  }

  func remove(key: String) {
    storage.removeValue(forKey: key)
  }
}

// Example Usage
// -------------
// Demonstrate how to use the above implementations with an example:
let cache = Cache()
let disk = Disk()

cache.save(key: "testInt", value: 123)
disk.save(key: "testString", value: "Hello")

// Retrieve and use the stored values
let retrievedInt = cache.retrieve(key: "testInt")
let deserializedInt = Int.deserialize(from: retrievedInt ?? "")
if let deserializedInt = deserializedInt {
  print("Retrieved Int: \(deserializedInt)")
}

let retrievedString = disk.retrieve(key: "testString")
let deserializedString = String.deserialize(from: retrievedString ?? "")
if let deserializedString = deserializedString {
  print("Retrieved String: \(deserializedString)")
}
