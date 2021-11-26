//
//  File.swift
//  CatsGallery
//
//  Created by Źmicier Fiedčanka on 20.11.21.
//

import Foundation

enum CTGError: String, Error {
    
    case badURL           = "For some reason, cat API URL is broken. Please, contact support."
    case unableToComplete = "We're unable to complete your request. Please check your internet connection."
    case invalidResponse  = "Invalid response from the server. Please, try again."
    case invalidData      = "The data recieved from server was invalid. Please, try again."
    case cantLoadImage    = "Failed to load image from provided URL."
}
