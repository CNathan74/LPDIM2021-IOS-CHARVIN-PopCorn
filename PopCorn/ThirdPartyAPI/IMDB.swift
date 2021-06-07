//
//  IMDB.swift
//  Project
//
//  Created by Nathan on 29/05/2021.
//

import Foundation

let API_KEY = "341ded117d53a82070941b2644fa1443"
let CATEGORY_LIST_URL = "https://api.themoviedb.org/3/genre/movie/list?api_key=" + API_KEY + "&language=fr-FR"

let CATEGORY_TYPE_MOVIE_LIST = "https://api.themoviedb.org/3/discover/movie?api_key=" + API_KEY + "&language=fr-FR&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres="
let MOVIELIST_URL_SUB = "&with_watch_monetization_types=flatrate"
let MOVIE_DETAIL_URL = ""


let MOVIE_VIDEO = "https://api.themoviedb.org/3/movie/"
let MOVIE_VIDEO_API_KEY = "/videos?api_key=" + API_KEY + "&language=fr-FR"
