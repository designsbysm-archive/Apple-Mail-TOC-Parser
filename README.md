# Apple Mail TOC Parser

This repository contains a small Objective-C Parser Class
for the table_of_contents files found in Apple Mail mailboxes
exports. This was written just for fun, it is mainly for the
curious, although it could be useful for reading huge mailboxes.



Usage :

```
AppleMailOCParser tocParser = [[AppleMailTOCParser alloc] initWithPath:pathToTable_of_Contents];

NSArray *emailDictionaries = [tocparser parse];
```
<img src="Images/mbox folder.png" width="715" alt="Sparkle shows familiar update window with release notes">
