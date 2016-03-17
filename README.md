# iOS-Mongol-App-Components

This is a demo app to show how various Mongolian language UI componants cab be used to build Mongolian apps for iOS. 

[File organization!](organization.png)

UI

- UIMongolTableView.swift
- UIMongolTextView.swift
- UIMongolLabel.swift
- Alert (not finished)

Text rendering

- MongolUnicodeRenderer.swift  (used for rendering font glyphs--I don't have a smart font currently)
- ScalarString.swift  (supplemental file for renderer)

Font

- Add ChimeeWhiteMirrored.ttf to project
- In Info.plist file add "Fonts provided by application" with font name "ChimeeWhiteMirrored.ttf"
