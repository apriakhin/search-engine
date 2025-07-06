//
//  main.swift
//  SearchEngine
//
//  Created by Anton Priakhin on 7/4/25.
//

import Foundation

let args = CommandLine.arguments.dropFirst()

guard let dirPath = args.first else {
  print("Usage: ./search <directory> [query]")
  exit(1)
}

let query = args.dropFirst().joined(separator: " ")
let documents = loadDocuments(from: dirPath)
let results = search(query: query, in: documents)

guard !results.isEmpty else {
  print("\u{001B}[0;31mNo results found")
  exit(0)
}

for result in results {
  print("\u{001B}[0;32m\(result)")
}

exit(0)
