//
//  File.swift
//  
//
//  Created by Dans Multipro on 09/09/21.
//

import Combine

public protocol UseCase {
  associatedtype Request
  associatedtype Response
  
  func execute(request: Request?) -> AnyPublisher<Response, Error>
}
