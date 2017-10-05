<?xml version="1.0"?>

<st-source>



<class>
<name>Philosoph</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>process sem state id session </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>FuenfPhilosophen</category>
<attributes>
<package>(none)</package>
</attributes>
</class>

<shared-variable>
<name>Ids</name>
<environment>Philosoph</environment>
<private>false</private>
<constant>false</constant>
<category>As yet unclassified</category>
<attributes>
<package>(none)</package>
</attributes>
</shared-variable>

<shared-variable>
<name>Mutex</name>
<environment>Philosoph</environment>
<private>false</private>
<constant>false</constant>
<category>As yet unclassified</category>
<attributes>
<package>(none)</package>
</attributes>
</shared-variable>

<!-- -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -   -->


<methods>
<class-id>Philosoph class</class-id> <category>instance creation</category>

<body package="(none)">new
	^super new initialize</body>
</methods>

<methods>
<class-id>Philosoph class</class-id> <category>accessing</category>

<body package="(none)">resetIds
	Ids := 0</body>

<body package="(none)">resetMutex
	Mutex := Semaphore new.
	Mutex signal</body>
</methods>

<!-- -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -   -->


<methods>
<class-id>Philosoph</class-id> <category>accessing</category>

<body package="(none)">id
	^id</body>

<body package="(none)">process
	^process</body>

<body package="(none)">sem
	^sem</body>

<body package="(none)">session
	^session</body>

<body package="(none)">session: aPhilosophers 
	session := aPhilosophers</body>

<body package="(none)">state
	^state</body>
</methods>

<methods>
<class-id>Philosoph</class-id> <category>eating</category>

<body package="(none)">releaseForks
	""

	Mutex critical: 
			[state := 'denkend'.
			self leftNeighbour try.
			self rightNeighbour try]</body>

<body package="(none)">takeTwoForks
	""

	Mutex critical: 
			[state := 'hungrig'.
			self try].
	sem wait</body>

<body package="(none)">try
	""

	state = 'hungrig' &amp; (self leftNeighbour state ~= 'essend') 
		&amp; (self rightNeighbour state ~= 'essend') 
			ifTrue: 
				[state := 'essend'.
				sem signal]</body>
</methods>

<methods>
<class-id>Philosoph</class-id> <category>initialization</category>

<body package="(none)">initialize
	id := Ids + 1.
	Ids := Ids + 1.
	sem := Semaphore new.
	state := 'denkend'.
	process := 
			[| denkzeit denkDelay esszeit essDelay |
			denkzeit := Random new next * 10000.
			denkDelay := Delay forMilliseconds: denkzeit.
			Transcript
				cr;
				show: 'Phil ' , id printString , ' ';
				cr;
				tab;
				show: 'ich denke jetzt für ' , denkzeit printString , ' Millisekunden.'.
			denkDelay wait.
			
			[self takeTwoForks.
			esszeit := Random new next * 10000.
			essDelay := Delay forMilliseconds: esszeit.
			Transcript
				cr;
				show: 'Phil ' , id printString , ' ';
				cr;
				tab;
				show: 'ich esse jetzt für ' , esszeit printString , ' Millisekunden.'.
			essDelay wait.
			denkzeit := Random new next * 10000.
			denkDelay := Delay forMilliseconds: denkzeit.
			Transcript
				cr;
				show: 'Phil ' , id printString , ' ';
				cr;
				tab;
				show: 'ich denke jetzt für ' , denkzeit printString , ' Millisekunden.'.
			self releaseForks.
			denkDelay wait] 
					repeat] 
					newProcess</body>
</methods>

<methods>
<class-id>Philosoph</class-id> <category>neighbours</category>

<body package="(none)">leftNeighbour
	""

	^self session leftOf: self</body>

<body package="(none)">rightNeighbour
	""

	^self session rightOf: self</body>
</methods>
<new-page/>


<class>
<name>Philosophers</name>
<environment>Smalltalk</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>philosophers </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>FuenfPhilosophen</category>
<attributes>
<package>(none)</package>
</attributes>
</class>

<!-- -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -   -->


<methods>
<class-id>Philosophers class</class-id> <category>instance creation</category>

<body package="(none)">new
	""

	^super new initialize</body>
</methods>

<!-- -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -   -->


<methods>
<class-id>Philosophers</class-id> <category>initialization</category>

<body package="(none)">initialize
	"comment stating purpose of message"

	philosophers := Array new: 5.
	Philosoph resetIds.
	Philosoph resetMutex.
	1 to: 5
		do: 
			[:i | 
			philosophers at: i put: Philosoph new.
			(philosophers at: i) session: self]</body>
</methods>

<methods>
<class-id>Philosophers</class-id> <category>accessing</category>

<body package="(none)">philosophers
	""

	^philosophers</body>
</methods>

<methods>
<class-id>Philosophers</class-id> <category>neighbours</category>

<body package="(none)">leftOf: aPhilosoph 
	^philosophers 
		at: (aPhilosoph id = 1 ifTrue: [5] ifFalse: [aPhilosoph id - 1])</body>

<body package="(none)">rightOf: aPhilosoph 
	^philosophers 
		at: (aPhilosoph id = 5 ifTrue: [1] ifFalse: [aPhilosoph id + 1])</body>
</methods>































</st-source>
