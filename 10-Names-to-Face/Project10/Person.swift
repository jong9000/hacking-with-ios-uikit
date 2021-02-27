//
//  Person.swift
//  Project10
//
//  Created by Jonathan Gentry on 2/27/21.
//

import UIKit

class Person: NSObject {
  var name: String
  var image: String
  
  init(name: String, image: String) {
    self.name = name
    self.image = image
  }
}
