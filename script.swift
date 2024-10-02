import Foundation

// Task class that represents a single task
class Task {
    var id: Int
    var content: String
    var dateGenerated: Date
    
    init(id: Int, content: String) {
        self.id = id
        self.content = content
        self.dateGenerated = Date()
    }
}

// ToDoList class that represents the list of tasks
class ToDoList {
    private var tasks: [Task] = []
    private var nextId: Int = 1

    func addTask(content: String) {
        if !content.isEmpty {
            let task = Task(id: nextId, content: content)
            tasks.append(task)
            print("Task '\(content)' added with ID \(task.id).")
            nextId += 1
        } else {
            print("Error: Task cannot be empty.")
        }
    }

    func deleteTask(byId id: Int) {
        if let index = tasks.firstIndex(where: { $0.id == id }) {
            let deletedTask = tasks.remove(at: index)
            print("Task '\(removedTask.content)' deleted.")
        } else {
            print("Error: Task with ID \(id) not found.")
        }
    }

    func editTask(byId id: Int, newContent: String) {
        if let index = tasks.firstIndex(where: { $0.id == id }) {
            if !newContent.isEmpty {
                tasks[index].content = newContent
                print("Task ID \(id) updated to '\(newContent)'.")
            } else {
                print("Error: Task content cannot be empty.")
            }
        } else {
            print("Error: Task with ID \(id) not found.")
        }
    }

    func searchTasks(query: String) {
        let filteredTasks = tasks.filter { $0.content.lowercased().contains(query.lowercased()) }
        if filteredTasks.isEmpty {
            print("No tasks found matching '\(query)'.")
        } else {
            print("Search results for '\(query)':")
            for task in filteredTasks {
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                let formattedDate = dateFormatter.string(from: task.dateGenerated)
                print("ID: \(task.id), Task: \(task.content), Date: \(formattedDate)")
            }
        }
    }

    func displayTasks() {
        if tasks.isEmpty {
            print("Your to-do list is empty.")
        } else {
            print("To-Do List:")
            for task in tasks {
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                let formattedDate = dateFormatter.string(from: task.dateGenerated)
                print("ID: \(task.id), Task: \(task.content), Date: \(formattedDate)")
            }
        }
    }
}

// Function to display the menu
func displayMenu() {
    print("\n=== To-Do List Manager ===")
    print("1. Add Task")
    print("2. View Tasks")
    print("3. Remove Task")
    print("4. Edit Task")
    print("5. Search Task")
    print("6. Exit")
}

// Main program loop
let todoList = ToDoList()
var shouldContinue = true

while shouldContinue {
    displayMenu()
    print("Choose an option (1-6):")

    if let choice = readLine() {
        switch choice {
        case "1":
            print("Enter task:")
            if let taskContent = readLine() {
                todoList.addTask(content: taskContent)
            }
        case "2":
            todoList.displayTasks()
        case "3":
            print("Enter the ID of the task to delete:")
            if let input = readLine(), let id = Int(input) {
                todoList.removeTask(byId: id)
            } else {
                print("Error: Invalid input. Please enter a valid task ID.")
            }
        case "4":
            print("Enter the ID of the task to edit:")
            if let input = readLine(), let id = Int(input) {
                print("Enter new content for task ID \(id):")
                if let newContent = readLine() {
                    todoList.editTask(byId: id, newContent: newContent)
                }
            } else {
                print("Error: Invalid input. Please enter a valid task ID.")
            }
        case "5":
            print("Enter text to search:")
            if let query = readLine() {
                todoList.searchTasks(query: query)
            }
        case "6":
            shouldContinue = false
            print("Exiting the program. Goodbye!")
        default:
            print("Error: Invalid choice. Please select a valid option.")
        }
    } else {
        print("Error: Failed to read input.")
    }
}
