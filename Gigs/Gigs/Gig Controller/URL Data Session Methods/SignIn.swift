//
//  Login.swift
//  Gigs
//
//  Created by alfredo on 1/21/20.
//  Copyright © 2020 Alfredo. All rights reserved.
//

import Foundation
//Logging in to the API using a username and password. This will give you back a token in JSON data. Decode a `Bearer` object from this data and set the value of bearer property you made in this `GigController` so you can authenticate the requests that require it tomorrow.
extension GigController{
    func signIn(with user: User, completion: @escaping (Error?) -> ()){
        
        //MARK: - URL Request Setup
        
        //complete URL
        let signInURL = baseURL.appendingPathComponent("users/login")
        //send request
        var request = URLRequest(url: signInURL)
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

        //pass in data
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
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
            
            //MARK: - Check for data
            
            guard let data = data else { completion(NSError()); return }
            
            //MARK: - Decode Data
            
            let decoder = JSONDecoder()
            
            do {
                self.bearer  = try decoder.decode(Bearer.self, from: data) }
            catch {
                print("Error decoding bearer object: \(error)")
                completion(error)
                return }
            completion(nil)
        }
        task.resume()
    }
}
