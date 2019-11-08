"
This class exercises the data tree object generated when the run message is called.
"
Class {
	#name : #DataTreeTest,
	#superclass : #TestCase,
	#instVars : [
		'dp',
		'a'
	],
	#category : #'Math-Tests-Accuracy'
}

{ #category : #initialization }
DataTreeTest >> initialize [ 
	super initialize.
	dp := PMAccuracyTestExample decimalPlaces
]

{ #category : #running }
DataTreeTest >> setUp [ 
	super setUp .
	a := PMAccuracyTestExample new.
	PMAccuracyTestExample decimalPlaces: 3.
]

{ #category : #running }
DataTreeTest >> tearDown [ 
	PMAccuracyTestExample decimalPlaces: dp.
]

{ #category : #tests }
DataTreeTest >> testThatNamesAreInitialisationKeys [
	| dataTree |
	a run.
	dataTree := a dataTree.
	self
		assert: (dataTree atPath: #('names' 'data'))
		equals: #('Aaa' 'Bbb' 'Ccc' 'Ddd' 'Eee' 'Fff').
]

{ #category : #tests }
DataTreeTest >> testThatNumberOfIterationsIsOne [
	| dataTree |
	a run.
	dataTree := a dataTree.
	self assert: (dataTree atPath: #('iterations')) equals: 1.
]

{ #category : #tests }
DataTreeTest >> testThatTheKeyedTreeHasArgsDataResultsErrorsAndType [
	| dataTree |
	a run.
	dataTree := a dataTree.
	self
		assert: (dataTree atPath: #('names' 'Aaa' #(1 2) #(4 4)))
		equals:
			(KeyedTree new
				at: 'arguments' put: true;
				at: 'data' put: #(#(1 1));
				at: 'error' put: #(300.0 300.0);
				at: 'expected result' put: #(4 4);
				at: 'result' put: #(1 1);
				at: 'type' put: 'result';
				yourself).
]

{ #category : #tests }
DataTreeTest >> testThatTheTreesForAaaAndBbbAreSetUpCorrectly [
	| dataTree |
	a run.
	dataTree := a dataTree.
	self
		assert: (dataTree atPath: #('names' 'Aaa' 'data'))
		equals: #(#(1 2) #(3 2.8888)).
	self
		assert: (dataTree atPath: #('names' 'Bbb' #(3) 'data'))
		equals: #(#(2) #(3)).
	
]

{ #category : #tests }
DataTreeTest >> testTreesForCccAndFffAreSetUpCorrectly [
	| s dataTree |
	a run.
	dataTree := a dataTree.
	s := dataTree atPath: #('names' 'Ccc' #(3)).
	self assert: s keys size equals: 5.
	s := dataTree atPath: #('names' 'Fff' 'error').
	self
		assert: (s copyFrom: 1 to: 4)
		equals:
			{0.
			Float infinity.
			-100.0.
			Float infinity negated}.
	self assert: (s at: 5) isNaN
]
