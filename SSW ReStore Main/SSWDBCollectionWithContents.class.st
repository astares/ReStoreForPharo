"
ReStore
©2019 John Aspinall
https://github.com/rko281/ReStore
"
Class {
	#name : 'SSWDBCollectionWithContents',
	#superclass : 'SSWDBObjectWithComponents',
	#category : 'SSW ReStore Main',
	#package : 'SSW ReStore Main'
}

{ #category : 'enumerating' }
SSWDBCollectionWithContents >> componentsIn: aReStore do: aBlock visited: visitedSet evaluated: evaluatedSet [

	((self object _dbProxyIn: aReStore ifNone: [nil]) ifNil: [self object] ifNotNil: [ :prx | prx _proxiedObject]) do:
		[ :each | 
		each withComponents withComponentsIn: aReStore do: aBlock visited: visitedSet evaluated: evaluatedSet]
]
