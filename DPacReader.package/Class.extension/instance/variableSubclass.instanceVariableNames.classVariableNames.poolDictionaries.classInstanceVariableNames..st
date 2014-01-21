*dpacreader
variableSubclass: t instanceVariableNames: f classVariableNames: d poolDictionaries: s classInstanceVariableNames: civns
	"This is the standard initialization message for creating a new class as a 
	subclass of an existing class (the receiver) in which the subclass is to 
	have indexable pointer variables."

	| aClass |
	aClass := self classBuilder
		superclass: self
		variableSubclass: t
		instanceVariableNames: f
		classVariableNames: d
		poolDictionaries: s
		category: 'Unclassified'.
	aClass class instanceVariableNames: civns.
	^ aClass