//
//  AddBookView.swift
//  Bookworm
//
//  Created by junseopLee on 12/11/25.
//
import SwiftData
import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var canSave: Bool {
        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {return false}
        if author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {return false}
        
        return true
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)

                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    LabeledContent("Rating") {
                            RatingView(rating: $rating)
                    }
                }
                
                Section("Write a review") {
                    TextField("Enter your review here...", text: $review, axis: .vertical)
                        .lineLimit(3...5) 
                }

                Section {
                    Button("Save") {
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                        modelContext.insert(newBook)
                        
                        dismiss()
                    }.disabled(!canSave)
                }
            }.navigationTitle("Add Book")
        }
    }
}

#Preview {
    AddBookView()
}
