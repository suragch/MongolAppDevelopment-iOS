# iOS-Mongol-App-Components

This is a demo app to show how various Mongolian language UI componants cab be used to build Mongolian apps for iOS. 

![File organization](/Mongol%20App%20Componants/organization.png?raw=true)

UI

- UIMongolTableView.swift
- UIMongolTextView.swift
- UIMongolLabel.swift
- UIMongolAlert.swift 
- UIMongolButton.swift

Text rendering

- MongolUnicodeRenderer.swift  (used for rendering font glyphs--I don't have a smart font currently)
- ScalarString.swift  (supplemental file for renderer)
- MongolTextStorage.Swift (helper class for text processing)

Font

- Add ChimeeWhiteMirrored.ttf to project
- In Info.plist file add "Fonts provided by application" with font name "ChimeeWhiteMirrored.ttf"
