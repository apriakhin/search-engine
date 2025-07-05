//
//  Utils.swift
//  SearchEngine
//
//  Created by Anton Priakhin on 7/4/25.
//

import Foundation

func getTerms(from text: String) -> [String] {
  return text
    .split(whereSeparator: \.isNewline)
    .flatMap {
      $0
        .split(whereSeparator: \.isWhitespace)
        .map(String.init)
        .map(normalize)
    }
}

func normalize(_ word: String) -> String {
  return word
    .lowercased()
    .filter { $0.isLetter || $0.isNumber }
}

func loadDocuments(from directoryPath: String) -> [Document] {
  guard let directoryURL = URL(string: directoryPath) else {
    return []
  }

  return getFileURLs(at: directoryURL).compactMap {
    guard let text = try? String(contentsOf: $0) else {
      return nil
    }

    return Document(
      id: $0.relativePath,
      text: text
    )
  }
}

func getFileURLs(at url: URL) -> [URL] {
  let fileManager = FileManager()
  let resourceKeys = Set<URLResourceKey>([.nameKey, .isDirectoryKey])
  let directoryEnumerator = fileManager.enumerator(at: url, includingPropertiesForKeys: Array(resourceKeys), options: .skipsHiddenFiles)!
  var fileURLs: [URL] = []

  for case let fileURL as URL in directoryEnumerator {
    guard let resourceValues = try? fileURL.resourceValues(forKeys: resourceKeys),
          let isDirectory = resourceValues.isDirectory
    else {
      continue
    }

    if isDirectory {
      directoryEnumerator.skipDescendants()
    } else {
      fileURLs.append(fileURL)
    }
  }

  return fileURLs
}
