//
//  AuthService.swift
//  CineAI
//
//  Created by MB-BTMC001 on 27.08.2025.
//


import UIKit
import FirebaseAuth

protocol AuthServiceProtocol{
    
    func login(with credentials: LoginCredentials,completion: @escaping (Result<Void,Error>) -> Void)
    func register(with credentials: LoginCredentials,completion: @escaping (Result<Void,Error>) -> Void)
    func updateUsername(newUsername: String, completion: @escaping (Result<Void, Error>) -> Void)
}

struct LoginCredentials{
    let email: String
    let password: String
}

enum AuthError: Error {
    case noCurrentUser
    case unknownError
}


class AuthService: AuthServiceProtocol{
    
    func login(with credentials: LoginCredentials, completion: @escaping (Result<Void, Error>) -> Void) {
        
        Auth.auth().signIn(withEmail: credentials.email, password: credentials.password) {result, error in
        
            if let error = error{
                completion(.failure(error))
            }else {
                completion(.success(()))
            }
        }
    }
    
    func register(with credentials: LoginCredentials, completion: @escaping (Result<Void, Error>) -> Void) {
    
        Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) {result, error in
        
            if let error = error {
                completion(.failure(error))
            }else{
                completion(.success(()))
            }
        }
    }
    
    func updateUsername(newUsername: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.failure(AuthError.noCurrentUser))
            return
        }
        
        let changeRequest = user.createProfileChangeRequest()
        changeRequest.displayName = newUsername
        changeRequest.commitChanges { error in
            if let error = error {
                completion(.failure(error))
            } else {
                UserDefaults.standard.set(newUsername, forKey: "currentUsername")
                completion(.success(()))
            }
        }
    }
}

