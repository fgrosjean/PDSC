//
//  MailerService.swift
//  PDSC
//
//  Created by Fernando Grosjean on 4/5/19.
//  Copyright © 2019 Fernando Grosjean. All rights reserved.
//

import Foundation

final class MailerService {
    static let instace = MailerService()
    let apiKey = "Bearer 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"
    let sendMailURL = URL(string: "https://api.sendgrid.com/v3/mail/send")!
    
    lazy var headers = [
        "authorization": apiKey,
        "content-type": "application/json"
    ]
    
    private init() { }
    
    func sendEmail(data: Data, onCompletion: @escaping (Error?) -> Void) {
        var request = URLRequest(url: sendMailURL)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = data
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            onCompletion(error != nil ? error : nil)
        }
        
        task.resume()
    }
}
