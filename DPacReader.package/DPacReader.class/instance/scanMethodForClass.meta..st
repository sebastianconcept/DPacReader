scanning
scanMethodForClass: class meta: meta
	| itemPosition method selector |
	[ 
	itemPosition := file position.
	method := file nextChunk.
	file skipStyleChunk.
	method size > 0 ]
		whileTrue: [ 
			self
				addItem:
					(ChangeRecord new
						file: file
						position: itemPosition
						type: #method
						class: class
						category: nil
						meta: meta
						stamp: nil)
				text:
					'method: ' , class
						,
							(meta
								ifTrue: [ ' class ' ]
								ifFalse: [ ' ' ])
						,
							((selector := (Smalltalk globals at: class ifAbsent: [ Object ]) compiler parseSelector: method) isNil
								ifTrue: [ 'unparsableSelector' ]
								ifFalse: [ selector ]) ]	"done when double terminators"