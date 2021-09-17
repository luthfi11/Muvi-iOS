//
//  File.swift
//  
//
//  Created by Dans Multipro on 09/09/21.
//

import Foundation

public protocol Mapper {
  associatedtype Response
  associatedtype Entity
  associatedtype Domain
  
  func transformResponseToEntity(response: Response) -> Entity
  func transformEntityToDomain(entity: Entity) -> Domain
}
