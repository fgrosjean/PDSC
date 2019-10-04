//
//  PhotoEmail.swift
//  PDSC
//
//  Created by Fernando Grosjean on 4/8/19.
//  Copyright © 2019 Fernando Grosjean. All rights reserved.
//

import Foundation

struct Email: Codable {
    let personalizations : [Email.Personalizations]
    let from             = Email.From(email: "no-reply@pdsc.com", name: "Prados de San Cristóbal")
    let subject          : String
    let content          : [Email.Content]
    let attachments      : [Attachments]?
}

extension Email {
    struct Personalizations: Codable {
        let to: [To]
    }
    
    struct To: Codable {
        let email : String
        let name  : String
        
        init(email: String, name: String) {
            self.email = email
            self.name = name
        }
    }
    
    struct From: Codable {
        let email : String
        let name  : String
    }
    
    struct Content: Codable {
        let type  : String = "text/html"
        let value : String
    }
    
    struct Attachments: Codable {
        let content    : String
        let filename   : String
        let type       : String
        let content_id : String
        let disposition = "attachment"
    }
}

