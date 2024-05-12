//
//  ChooseCategoryView.swift
//  Quotify Watch App
//
//  Created by Anuza Simkhada on 12/05/2024.
//

import Foundation
import SwiftUI


struct ChooseCategoryView: View {
    let categories = [
        "Age", "Alone", "Amazing", "Anger", "Architecture", "Art", "Attitude", "Beauty",
        "Best", "Birthday", "Business", "Car", "Change", "Communication", "Computers", "Cool",
        "Courage", "Dad", "Dating", "Death", "Design", "Dreams", "Education", "Environmental",
        "Equality", "Experience", "Failure", "Faith", "Family", "Famous", "Fear", "Fitness",
        "Food", "Forgiveness", "Freedom", "Friendship", "Funny", "Future", "God", "Good",
        "Government", "Graduation", "Great", "Happiness", "Health", "History", "Home", "Hope",
        "Humor", "Imagination", "Inspirational", "Intelligence", "Jealousy", "Knowledge",
        "Leadership", "Learning", "Legal", "Life", "Love", "Marriage", "Medical", "Men", "Mom",
        "Money", "Morning", "Movies", "Success"
    ]
    
    var body: some View {
            NavigationView {
                List(categories, id: \.self) { category in
                    NavigationLink(destination: NewQuotesView(selectedCategory: category)) {
                        Text(category)
                    }
                }
                .padding(.top, 12)
           }
        
                   
       }
    
}

