!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'LFC 3/31/2026 18:01:28'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'LFC 3/31/2026 14:18:05'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'LFC 3/31/2026 17:55:49'!
removeCustomerNamed: aName 
 
	(self removeCustomerNamed: aName from: active) ifNotNil: [ :customer | ^customer].
	(self removeCustomerNamed: aName from: suspended) ifNotNil: [ :customer | ^customer].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !


!CustomerBook methodsFor: 'helpers' stamp: 'LFC 3/31/2026 17:55:38'!
removeCustomerNamed: aName from: aCollection
 
	1 to: aCollection size do: 
	[ :index |
		aName = (aCollection at: index)
			ifTrue: [
				aCollection removeAt: index.
				^ aName 
			] 
	].	
	^ nil.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !


!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'LFC 3/31/2026 18:45:58'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self assertThat: [ customerBook addCustomerNamed: 'John Lennon' ]
	takesLessThan: 50
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LFC 3/31/2026 18:45:49'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	
	self assertThat: [ customerBook removeCustomerNamed: paulMcCartney ]
	takesLessThan: 100
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LFC 3/31/2026 18:52:05'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.


	self 
		should: [ customerBook addCustomerNamed: '' ] 
		failWith: Error
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ].		
	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LFC 3/31/2026 18:47:51'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self 
		should: [ customerBook removeCustomerNamed: 'Paul McCartney' ] 
		failWith: NotFound
		do: [ :anError | self assertThat: customerBook hasOnlyOneCustomerNamed: johnLennon ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NR 4/3/2019 10:50:25'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 1 equals: customerBook numberOfSuspendedCustomers.
	self assert: 1 equals: customerBook numberOfCustomers.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NR 4/3/2019 10:50:28'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 0 equals: customerBook numberOfSuspendedCustomers.
	self assert: 0 equals: customerBook numberOfCustomers.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LFC 3/31/2026 18:35:31'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self 
		should: [ customerBook suspendCustomerNamed: 'Ringo Starr' ]
		failWith: CantSuspend 
		do: [ :anError | self assertThat: customerBook hasOnlyOneCustomerNamed: johnLennon]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LFC 3/31/2026 18:34:25'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self 
		should: [ customerBook suspendCustomerNamed: johnLennon ] 
		failWith: CantSuspend 
		do: [ :anError | self assertThat: customerBook hasOnlyOneCustomerNamed: johnLennon ]
! !


!CustomerBookTest methodsFor: 'helpers' stamp: 'LFC 3/31/2026 18:23:38'!
assertThat: aCustomerBook hasOnlyOneCustomerNamed: aName

	self assert: aCustomerBook numberOfCustomers = 1.
	self assert: (aCustomerBook includesCustomerNamed: aName) ! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'LFC 3/31/2026 18:42:44'!
assertThat: aBlock takesLessThan: milliseconds

    | startTime |
    startTime := Time millisecondClockValue * millisecond.
    aBlock value.
    self assert: (Time millisecondClockValue * millisecond - startTime) < (milliseconds * millisecond)! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'LFC 3/31/2026 18:11:41'!
should: aBlock failWith: anErrorClass do: assertionsBlock

	[ 
		aBlock value.
		self fail
	] on: anErrorClass
	  do: assertionsBlock! !
(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(75 65 99 89 76 87 86 90 102 78 80 91 79 92 73 99 80 117 110 90 118 109 123 126 104 121 108 56 99 80 117 110 108 117 112 108 121 112 104 52 107 108 115 52 90 118 109 123 126 104 121 108 52 80 17 75 65 99 89 76 87 86 90 102 78 80 91 79 92 73 99 80 117 110 90 118 109 123 126 104 121 108 56 99 80 117 110 108 117 112 108 121 112 104 52 107 108 115 52 90 118 109 123 126 104 121 108 52 80 99 74 124 112 122 92 117 112 125 108 121 122 112 123 128 52 62 61 59 56 53 112 116 104 110 108 17 94 112 117 58 57 17 61 53 57 17 95 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 100 17 94 112 117 107 118 126 122 17 94 112 117 58 57 39 105 124 112 115 123 39 118 117 39 84 104 121 39 39 56 39 57 55 57 60 39 55 56 65 55 59 65 57 57 39 78 84 91 39 74 118 116 119 112 115 108 121 65 39 59 53 57 53 56 39 74 118 116 119 104 123 112 105 115 108 39 74 115 104 117 110 39 63 53 55 53 56 39 47 123 104 110 122 54 89 76 83 76 72 90 76 102 63 55 56 54 109 112 117 104 115 48 17 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 84 104 121 39 39 56 39 57 55 57 60 17 83 112 125 108 91 128 119 112 117 110 74 118 110 112 123 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 84 104 121 39 39 56 39 57 55 57 60 17 93 84 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 39 75 104 123 108 65 39 84 118 117 39 86 106 123 39 61 39 56 57 65 58 59 65 57 56 39 57 55 57 60 39 74 118 116 116 112 123 79 104 122 111 65 39 108 107 58 60 59 63 61 39 87 115 124 110 112 117 122 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 17 33 191 111 235 17 57 61 53 56 63 59 53 56 55 59 53 57 57 63 17 83 72 52 85 72 93 76 17 83 72 52 85 72 93 76 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 58 52 58 56 91 56 59 65 55 61 65 59 62 53 63 62 60 59 58 58 52 55 58 65 55 55 17 75 65 99 89 76 87 86 90 102 78 80 91 79 92 73 99 80 117 110 90 118 109 123 126 104 121 108 56 99 80 117 110 108 117 112 108 121 112 104 52 107 108 115 52 90 118 109 123 126 104 121 108 52 80 99 76 113 108 121 106 112 106 112 118 55 56 102 74 118 107 112 110 118 89 108 119 108 123 112 107 118 99 74 118 107 112 110 118 89 108 119 108 123 112 107 118 52 76 113 108 121 106 112 106 112 118 52 74 118 117 122 112 110 117 104 53 122 123 17 62 63 56 57 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 58 52 58 56 91 56 64 65 56 57 65 57 58 53 63 60 63 59 58 58 52 55 58 65 55 55 17 75 65 99 89 76 87 86 90 102 78 80 91 79 92 73 99 80 117 110 90 118 109 123 126 104 121 108 56 99 80 117 110 108 117 112 108 121 112 104 52 107 108 115 52 90 118 109 123 126 104 121 108 52 80 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 74 118 107 112 110 118 89 108 119 108 123 112 107 118 52 76 113 108 121 106 112 106 112 118 53 122 123 17 63 56 62 64 17 52 52 52 52 52 52 52 52 52 52 17 17))!