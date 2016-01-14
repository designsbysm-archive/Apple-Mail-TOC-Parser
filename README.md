# Apple Mail table-of-contents Parser




This repository contains a small Objective-C Parser Class
for the table_of_contents files found in Apple Mail mailboxes
exports. This was written just for fun, it is mainly for the
curious, although it could be useful for handling huge mailboxes.
An example App Xcode target is included in the project, and a sample
Apple MAil Exported mailbox. It is taken from an apache mailing list,
I hope it can be considered of public domain.

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
AppleMailOCParser *tocParser = [[AppleMailTOCParser alloc] initWithPath:pathToTable_of_Contents];

NSArray *emailDictionaries = [tocparser parse];
```

Appearance of a .mbox folder :

<img src="Images/mbox folder.png" width="715" alt="Sparkle shows familiar update window with release notes">

Appearance of the contents of a .mbox folder :

<img src="Images/mbox folder contents.png" width="715" alt="Sparkle shows familiar update window with release notes">

