# Apple Mail TOC Parser




This repository contains a small Objective-C Parser Class
for the table_of_contents files found in Apple Mail mailboxes
exports. This was written just for fun, it is mainly for the
curious, although it could be useful for handling huge mailboxes.
An example App Xcode target is included in the project.

Usage :

Add AppleMailOCParser.h and AppleMailOCParser.m from the Parser Class
folder to your project. Initialize a parser object with the path of
the table_of_contents file, then the implementation is quite straightforward.
It returns an array of dictionaries each representing an object.

The Dictionary Keys are :

```
senderAddress
emailNumber
emailOffset
emailLength
```

Example

```
AppleMailOCParser tocParser = [[AppleMailTOCParser alloc] initWithPath:pathToTable_of_Contents];

NSArray *emailDictionaries = [tocparser parse];
```
<img src="Images/mbox folder.png" width="715" alt="Sparkle shows familiar update window with release notes">
