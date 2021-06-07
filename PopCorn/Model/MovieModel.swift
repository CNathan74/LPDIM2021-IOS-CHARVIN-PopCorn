//
//  MovieModel.swift
//  Project
//
//  Created by Nathan on 28/05/2021.
//

import Foundation
import UIKit

struct movie{
    var title: String?
    var subTitle: String?
    var duaration: String?
    var url: String?
    var date: String?
    var category: String?
    var synasos: String?
    var movieImage: UIImage?
}

struct Category{
    var categoryName: String?
    var movie: [movie]?
}
