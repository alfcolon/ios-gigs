//
//  signup.swift
//  Gigs
//
//  Created by alfredo on 1/21/20.
//  Copyright © 2020 Alfredo. All rights reserved.
//

import Foundation
// - Signing up for the API using a username and password. Once you "sign up", you can then log into the API like you did in the guided project this morning.

extension GigController{
    func signUp(with user: User, completion: @escaping (Error?) -> ()){
        
        //MARK: - URL Request Setup
        
        //complete URL
        let signUpURL = baseURL.appendingPathComponent("users/signup")
        //send request
        var request = URLRequest(url: signUpURL)
        request.httpMethod = HTTPMethod.post.rawValue
        //define format of data being sent
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //MARK: - Encode Swift User Object to JSON
        
        let jsonEncoder = JSONEncoder()
        //encode in do block becuase encoder throws error
        do {
            //encode user data
            let jsonData = try jsonEncoder.encode(user)
            //take JSON data and assign it to the body of the request
            request.httpBody = jsonData
        } catch {
            //Error:
            print("Error encoding user object: \(error)")
            //run completion block to inform UI something went wrong
            completion(error)
            //exit early
            return
        }
        
        //MARK: - Send URL Request

        let task = URLSession.shared.dataTask(with: request) { (_, response, error) in
            
            //MARK: - Error Handling
            
            //Check what type if response was received
            //send error and exit early if response is not 200
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                let errorMessage = NSError(domain: "", code: response.statusCode, userInfo: nil)
                completion(errorMessage)
                return
            }
            //Another check incase an error was sent in
            if error != nil {
                completion(error)
                return
            }
        }
        task.resume()
    }
}
