//
//  HabitDetail.swift
//  iHabit
//
//  Created by junseopLee on 12/2/25.
//

import SwiftUI

struct HabitDetail: View {
    @Binding var item: HabitItem
    
    var body: some View {
        Form {
            Section("Description") {
                if item.description.isEmpty {
                    Text("No description provided.")
                        .foregroundStyle(.secondary)
                        .italic() // 기울임꼴로 "이건 데이터가 아님"을 표현
                } else {
                    Text(item.description)
                        .foregroundStyle(.secondary)
                }
            }
            
            Section {
                LabeledContent("Completed", value: item.count, format: .number)
            }
        }.navigationTitle(item.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button {
                        item.count += 1
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
    }
}
