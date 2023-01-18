//
//  SampleView.swift
//  
//
//  Created by Vaughn on 2023-01-18.
//

import SwiftUI

@available(iOS 13.0, *)
struct SampleView: View {
    @StateObject var taskVM = TaskViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                Button(action: {
                    taskVM.createTask(title: String(taskVM.tasks.count), date: Date(), notes: "Notes on Notes")
                }) {
                    Text("Create")
                }.padding(10)
                
                Button(action: {
                    taskVM.fetchTasks()
                }) {
                    Text("Read")
                }.padding(10)
                
                Button(action: {
                    if taskVM.tasks.count > 0 {
                        taskVM.delete(task: taskVM.tasks[0])
                    }
                }) {
                    Text("Delete")
                }.padding(10)
                
                ForEach(taskVM.tasks, id: \.self) { task in
                    Text("Task title: " + task.title)
                }
            }
            .padding()
        }
    }
}
