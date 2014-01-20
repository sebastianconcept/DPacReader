*dpacreader
subclass: t instanceVariableNames: ins classVariableNames: cls poolDictionaries: pls classInstanceVariableNames: ccls
	| aClass |
	aClass := self
		subclass: t
		instanceVariableNames: ins
		classVariableNames: cls
		poolDictionaries: pls
		category: 'Unclassified'.
	aClass class instanceVariableNames: ccls.
	^ aClass