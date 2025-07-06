# Search Engine
#### Video Demo:  <URL HERE>
#### Description:
SearchEngine is a Swift-based command-line tool created as the final project for the CS50 course. The program is designed to search text files in a specified directory and its subdirectories, ranking files by relevance using the TF-IDF (Term Frequency–Inverse Document Frequency) algorithm.

SearchEngine efficiently searches documents that contain words from a given query and outputs a list of file names sorted by their relevance to the query. The program recursively walks through the file system, indexes text files, and applies text search algorithms to compute the most relevant results.

The program first builds an inverted index, mapping each term to the list of documents in which it appears. During indexing, each file is converted into a sequence of tokens: the text is lowercased, punctuation is removed, and the text is split into words. For each term, the program tracks how many times it appears in the document, as well as the total number of tokens in the document.

When a user enters a search query, the program tokenizes the query using the same rules. It calculates the TF (term frequency in the document) and IDF (a measure of how unique the term is across the collection). The TF-IDF value for each document is the sum of the TF-IDF values of all query terms in that document. The result is a list of file names sorted in descending order of relevance.

This tool is useful for developers, researchers, and students who need to quickly locate text documents matching a specific query. The program can be used for searching large datasets, in automation scripts, or for educational purposes to better understand information retrieval and text ranking algorithms.

SearchEngine is implemented using pure Swift and the Swift Package Manager. It has no external dependencies, making it easy to build and run on macOS and Linux. Thanks to its compact architecture, the code is easy to extend — for example, to add stop-word filtering, stemming support, or result export in various formats.

Project Overview:

*main.swift*

This file contains the main command-line code to run the search program. It retrieves arguments from the command line, checks for the required directory path and an optional search query. Then it loads documents from the specified directory, performs a search based on the query, and prints the results to the console with colored highlighting. This file handles user interaction and controls the main search workflow.

*SearchEngine.swift*

This file implements the search function, which performs a relevance-based search over a collection of documents. The function takes a query string, tokenizes it into terms, and uses a pre-built inverted index to find all documents containing these terms. It accumulates the TF-IDF scores of matching documents across all query terms, sums the scores for documents that appear multiple times, sorts the results by descending relevance, and returns a list of document identifiers ranked by their relevance to the query. This function is the core of the search engine’s retrieval mechanism.

*Document.swift*

This file defines the Document struct, which models a text document with a unique identifier and its full text content. It serves as the fundamental data type for storing and processing documents within the search engine. This simple structure enables efficient handling of documents during indexing and searching operations.

*Utils.swift*

This file provides core utility functions for the search engine project. It includes:

- `getTerms(from:)`: Splits input text into tokens by newlines and whitespace, normalizes each word by lowercasing and removing non-alphanumeric characters, returning an array of clean terms ready for indexing or searching.

- `normalize(_:)`: Helper function that lowercases a word and filters out any characters except letters and numbers, ensuring consistent token formatting.

- `loadDocuments(from:)`: Loads text documents from the given directory path by enumerating all files recursively, reading their contents, and creating an array of Document objects containing file identifiers and text content.

- `getFileURLs(at:)`: Recursively walks through the directory at the specified URL, collecting all file URLs (excluding directories and hidden files), which is used by loadDocuments to find the files to process.

Together, these functions handle text tokenization and document loading, forming the foundation for building the search index and performing queries.

*Posting.swift*

This file defines the Posting struct, which represents an entry in the inverted index of the search engine. Each Posting associates a document identifier (documentId) with a TF-IDF score (tfIdf) that quantifies the relevance of the term in that document. The struct includes an initializer with a default TF-IDF value of 0.0, enabling easy creation and updating of postings during indexing and search ranking processes. This data structure is fundamental for tracking term-document relationships and calculating search relevance.

*InvertedIndex.swift*

This file contains the implementation of the createInvertedIndex function, which builds an inverted index from a collection of documents. The inverted index maps each term to a list of postings, where each posting represents a document containing that term along with its calculated TF-IDF score. The function processes each document by tokenizing its text into terms, counts the occurrences of each term within documents, and calculates term frequency (TF) and inverse document frequency (IDF) values. This data structure enables efficient and relevant search queries over the document set by ranking documents according to term importance.

*Relevance.swift*

This file contains two core functions used to calculate the TF-IDF score components in the search engine.

- `tf(countOfAllTerms:countOfTerm:)`: Computes the term frequency (TF), which is the ratio of the number of times a term appears in a document (countOfTerm) to the total number of terms in that document (countOfAllTerms). This measures how important a term is within a single document.

- `idf(countOfDocuments:countOfPosting:)`: Computes the inverse document frequency (IDF), which measures how rare or common a term is across the entire document collection. It uses a smoothed logarithmic formula to reduce the weight of very common terms and increase the weight of rare terms, improving search relevance.

Together, these functions provide the foundational calculations for ranking documents by relevance in response to search queries.

Installation:
```
git clone git@github.com:apriakhin/search-engine.git
cd search-engine
make
```

Example usage:
```
./search ./documents shoot at me
# Output:
doc2.txt
doc5.txt
doc1.txt
doc4.txt
doc3.txt
```

Example document structure:
```
documents/
├── doc1.txt  # I can't shoot shoot shoot straight unless I've had a pint!
├── doc2.txt  # Don't shoot shoot shoot that thing at me.
├── doc3.txt  # I'm your shooter.
├── doc4.txt  # Shoot to thrill, play to kill.
├── doc5.txt  # Please don't shoot at me with that gun.
```
