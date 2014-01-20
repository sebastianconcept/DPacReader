scanning
scanCategory
	"Scan anything that involves more than one chunk; method name is historical only"

	| itemPosition item tokens stamp |
	itemPosition := file position.
	item := file nextChunk.
	((item includesSubstring: 'commentStamp:')
		or: [ 
			(item includesSubstring: 'methodsFor')
				or: [ (item includesSubstring: 'categoriesFor:') or: [ item endsWith: 'reorganize' ] ] ])
		ifFalse: [ 
			"Maybe a preamble, but not one we recognize; bail out with the preamble trick"
			^ self
				addItem: (ChangeRecord new file: file position: itemPosition type: #preamble)
				text: ('preamble: ' , item contractTo: 50) ].
	tokens := item parseLiterals.
	(tokens size >= 2 and: [ tokens last = 'methodsFor' ])
		ifTrue: [ ^ self scanMethodForClass: tokens first meta: tokens second = 'class' ].
	(tokens size >= 3 and: [ tokens second = 'categoriesFor:' or: [ tokens third = 'categoriesFor:' ] ])
		ifTrue: [ ^ self scanCategoryForClass: tokens first meta: tokens second = 'class' selector: tokens last ].
	tokens second == #commentStamp:
		ifTrue: [ 
			stamp := tokens third.
			self
				addItem:
					(ChangeRecord new
						file: file
						position: file position
						type: #classComment
						class: tokens first
						category: nil
						meta: false
						stamp: stamp)
				text:
					'class comment for ' , tokens first
						,
							(stamp isEmpty
								ifTrue: [ '' ]
								ifFalse: [ '; ' , stamp ]).
			file nextChunk.
			^ file skipStyleChunk ].
	self assert: tokens last == #reorganize.
	self
		addItem:
			(ChangeRecord new
				file: file
				position: file position
				type: #reorganize
				class: tokens first
				category: nil
				meta: false
				stamp: stamp)
		text:
			'organization for ' , tokens first
				,
					(tokens second == #class
						ifTrue: [ ' class' ]
						ifFalse: [ '' ]).
	file nextChunk