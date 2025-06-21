//
//  Book.swift
//  FeedApp
//
//  Created by Renato F. dos Santos Jr on 21/06/25.
//

import Foundation

// MARK: - Book Model
// Represents a single book with basic properties and an image name.
struct Book: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let author: String
    let genre: String
    let isRead: Bool
    let rating: Int // Example: 1-5 rating
    let imageName: String // Name of the image asset in Media.xcassets

    static let sampleBooks: [Book] = [
        Book(title: "Thinking in Bets", author: "Annie Duke", genre: "Decision Making", isRead: true, rating: 5, imageName: "thinkingInBets"),
        Book(title: "Domain-Driven Design", author: "Eric Evans", genre: "Software Engineering", isRead: false, rating: 4, imageName: "domainDrivenDesign"),
        Book(title: "Thinking in Bets", author: "Annie Duke", genre: "Decision Making", isRead: true, rating: 5, imageName: "thinkingInBets"),
        Book(title: "Domain-Driven Design", author: "Eric Evans", genre: "Software Engineering", isRead: false, rating: 4, imageName: "domainDrivenDesign"),
        Book(title: "Thinking in Bets", author: "Annie Duke", genre: "Decision Making", isRead: true, rating: 5, imageName: "thinkingInBets"),
        Book(title: "Domain-Driven Design", author: "Eric Evans", genre: "Software Engineering", isRead: false, rating: 4, imageName: "domainDrivenDesign"),
        Book(title: "Thinking in Bets", author: "Annie Duke", genre: "Decision Making", isRead: true, rating: 5, imageName: "thinkingInBets"),
        Book(title: "Domain-Driven Design", author: "Eric Evans", genre: "Software Engineering", isRead: false, rating: 4, imageName: "domainDrivenDesign"),
        Book(title: "Engenharia de Software Moderna", author: "Vários Autores", genre: "Software Engineering", isRead: true, rating: 3, imageName: "thinkingInBets"), //"engenhariaSoftwareModerna"),
        Book(title: "Arquitetura Limpa na Prática", author: "Otávio Lemos", genre: "Software Architecture", isRead: false, rating: 5, imageName: "domainDrivenDesign"), // "arquiteturaLimpa"),
        Book(title: "The Hitchhiker's Guide to the Galaxy", author: "Douglas Adams", genre: "Science Fiction", isRead: true, rating: 5, imageName: "thinkingInBets"), // "hitchhikersGuide"),
        Book(title: "1984", author: "George Orwell", genre: "Dystopian", isRead: false, rating: 4, imageName: "domainDrivenDesign"), // "nineteenEightyFour"),
        Book(title: "To Kill a Mockingbird", author: "Harper Lee", genre: "Classic", isRead: true, rating: 5, imageName: "thinkingInBets"), // "toKillAMockingbird"),
        Book(title: "Dune", author: "Frank Herbert", genre: "Science Fiction", isRead: true, rating: 5, imageName: "domainDrivenDesign"), // "dune"),
        Book(title: "Sapiens: A Brief History of Humankind", author: "Yuval Noah Harari", genre: "History", isRead: false, rating: 4, imageName: "thinkingInBets"), // "sapiens")
        Book(title: "Sapiens: A Brief History of Humankind", author: "Yuval Noah Harari", genre: "History", isRead: false, rating: 4, imageName: "domainDrivenDesign") // "sapiens")
    ]
}
