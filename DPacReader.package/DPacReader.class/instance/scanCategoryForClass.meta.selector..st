scanning
scanCategoryForClass: aClassName meta: isMeta selector: aSelector
	"Add the category to the relevant item. Choose only the first category. I have a bug there ? "

	| tokens item |
	file position.
	item := file nextChunk.
	file position.
	tokens := item parseLiterals.
	1 to: changeList size do: [ :i | 
		(changeList at: i)
			in: [ :each | 
				(each type = #method
					and: [ each methodClassName = aClassName and: [ each isMetaClassChange = isMeta and: [ (list at: i) parseLiterals last = aSelector ] ] ])
					ifTrue: [ each category: tokens first ] ] ].
	file position.
	file nextChunk	"public or private: don't care."