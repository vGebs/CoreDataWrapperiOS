# CoreDataWrapperiOS

`CoreDataWrapperiOS` is a simple, lightweight wrapper class for Core Data stack. It provides an easy-to-use interface for setting up the Core Data stack and performing common operations, such as creating, fetching, and deleting managed objects.

## Feautures

- create (creates new object of Type T)
- fetch (with custom FetchRequest input)
- saveContext (Saves an object to Persistent Store)
- delete (deletes object and saves Persistent Store)

## Installation

### Swift Package Manager

You can install `NetworkWrapperCombineiOS` using the [Swift Package Manager](https://swift.org/package-manager/).

1. In Xcode, open your project and navigate to File > Swift Packages > Add Package Dependency.
2. Enter the repository URL `https://github.com/vGebs/CoreDataWrapperiOS.git` and click Next.
3. Select the version you want to install, or leave the default version and click Next.
4. In the "Add to Target" section, select the target(s) you want to use `CoreDataWrapperiOS` in and click Finish.

## Usage

### Note

Please note that before using this package, you must define a data model + entities by making a `.xcdatamodeld` file.

### Initialization

The following initialization is an example of how to initalize the CoreDataWrapper, this object can be passed to any/all service classes that are using the same Core Data Model. e.g. the same CoreDataWrapper can used for all entities in a model.

```swift
do {
    let storeURL = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("AppModel.sqlite")
    let coreDataStack = CoreDataWrapper(modelName: "AppModel", storeURL: storeURL)
    self.taskService = try TaskService(coreDataStack: coreDataStack)
} catch {
    fatalError("Error initializing TaskService: \(error)")
}
```

Make sure to only initialize 1 and only 1 instance of the `CoreDataWrapper` for each model, not each entity.

### Sample Service Class

The following class is an example service class thats built on top of the `CoreDataWrapper`

```swift 
class TaskService {
    private let coreDataStack: CoreDataWrapper

    init(coreDataStack: CoreDataWrapper) throws {
        self.coreDataStack = coreDataStack
    }

    func fetchTasks() throws -> [Task] {
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
        return try coreDataStack.fetch(fetchRequest: fetchRequest)
    }
    
    func createTask() -> Task {
        return coreDataStack.create(objectType: Task.self)
    }
    
    func delete(_ task: Task) throws {
        try coreDataStack.delete(object: task)
    }
    
    func save() throws {
        try coreDataStack.saveContext()
    }
}
```

In this example we created a sample service class that manages all interaction with the Task objects from the AppModel.

### Aside

For more information on how to implement, please reference the SampleUsage folder in `Sources/CoreDataWrapperiOS`.

## Error Handling

Functions fetch, saveContext, and delete are throwing functions, so make sure to call them inside of a do-catch block.

```swift
do {
    let tasks = try coreDataStack.fetch(fetchRequest: fetchRequest)
    // use tasks
} catch {
    print(error)
}
```

## License

`CoreDataWrapperiOS` is released under the MIT license. See LICENSE for details.

## Contribution

We welcome contributions to NetworkWrapper. If you have a bug fix or a new feature, please open a pull request.
