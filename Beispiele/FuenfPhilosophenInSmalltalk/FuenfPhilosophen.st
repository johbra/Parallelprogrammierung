<?xml version="1.0"?>

<st-source>
<time-stamp>From VisualWorks® Personal Use Edition, 8.1.1 of 10. März 2016 on 23. Oktober 2017 at 20:33:48</time-stamp>


<component-created>
<name>FuenfPhilosophen</name> <type>package</type>
</component-created><!-- Package FuenfPhilosophen* -->


<component-created>
<name>FuenfPhilosophen</name> <type>package</type>
</component-created>

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
<package>FuenfPhilosophen</package>
</attributes>
</class>

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
<package>FuenfPhilosophen</package>
</attributes>
</class>

<shared-variable>
<name>Ids</name>
<environment>Philosoph</environment>
<private>false</private>
<constant>false</constant>
<category>As yet unclassified</category>
<attributes>
<package>FuenfPhilosophen</package>
</attributes>
</shared-variable>


<shared-variable>
<name>Mutex</name>
<environment>Philosoph</environment>
<private>false</private>
<constant>false</constant>
<category>As yet unclassified</category>
<attributes>
<package>FuenfPhilosophen</package>
</attributes>
</shared-variable>



<methods>
<class-id>Philosoph class</class-id> <category>accessing</category>

<body package="FuenfPhilosophen" selector="resetIds">resetIds	Ids := 0</body>

<body package="FuenfPhilosophen" selector="resetMutex">resetMutex	Mutex := Semaphore new.	Mutex signal</body>
</methods>

<methods>
<class-id>Philosoph class</class-id> <category>instance creation</category>

<body package="FuenfPhilosophen" selector="new">new	^super new initialize</body>
</methods>


<methods>
<class-id>Philosoph</class-id> <category>neighbours</category>

<body package="FuenfPhilosophen" selector="rightNeighbour">rightNeighbour	""	^self session rightOf: self</body>

<body package="FuenfPhilosophen" selector="leftNeighbour">leftNeighbour	""	^self session leftOf: self</body>
</methods>

<methods>
<class-id>Philosoph</class-id> <category>accessing</category>

<body package="FuenfPhilosophen" selector="id">id	^id</body>

<body package="FuenfPhilosophen" selector="session:">session: aPhilosophers 	session := aPhilosophers</body>

<body package="FuenfPhilosophen" selector="session">session	^session</body>

<body package="FuenfPhilosophen" selector="state">state	^state</body>

<body package="FuenfPhilosophen" selector="process">process	^process</body>

<body package="FuenfPhilosophen" selector="sem">sem	^sem</body>
</methods>

<methods>
<class-id>Philosoph</class-id> <category>initialization</category>

<body package="FuenfPhilosophen" selector="initialize">initialize	id := Ids + 1.	Ids := Ids + 1.	sem := Semaphore new.	state := 'denkend'.	process := 			[| denkzeit denkDelay esszeit essDelay |			denkzeit := Random new next * 10000.			denkDelay := Delay forMilliseconds: denkzeit.			Transcript				cr;				show: 'Phil ' , id printString , ' ';				cr;				tab;				show: 'ich denke jetzt für ' , denkzeit printString , ' Millisekunden.'.			denkDelay wait.						[self takeTwoForks.			esszeit := Random new next * 10000.			essDelay := Delay forMilliseconds: esszeit.			Transcript				cr;				show: 'Phil ' , id printString , ' ';				cr;				tab;				show: 'ich esse jetzt für ' , esszeit printString , ' Millisekunden.'.			essDelay wait.			denkzeit := Random new next * 10000.			denkDelay := Delay forMilliseconds: denkzeit.			Transcript				cr;				show: 'Phil ' , id printString , ' ';				cr;				tab;				show: 'ich denke jetzt für ' , denkzeit printString , ' Millisekunden.'.			self releaseForks.			denkDelay wait] 					repeat] 					newProcess</body>
</methods>

<methods>
<class-id>Philosoph</class-id> <category>eating</category>

<body package="FuenfPhilosophen" selector="try">try	""	state = 'hungrig' &amp; (self leftNeighbour state ~= 'essend') 		&amp; (self rightNeighbour state ~= 'essend') 			ifTrue: 				[state := 'essend'.				sem signal]</body>

<body package="FuenfPhilosophen" selector="releaseForks">releaseForks	""	Mutex critical: 			[state := 'denkend'.			self leftNeighbour try.			self rightNeighbour try]</body>

<body package="FuenfPhilosophen" selector="takeTwoForks">takeTwoForks	""	Mutex critical: 			[state := 'hungrig'.			self try].	sem wait</body>
</methods>


<methods>
<class-id>Philosophers class</class-id> <category>instance creation</category>

<body package="FuenfPhilosophen" selector="new">new	""	^super new initialize</body>
</methods>

<methods>
<class-id>Philosophers class</class-id> <category>example</category>

<body package="FuenfPhilosophen" selector="exampleWs">exampleWs| phils |phils := Philosophers new.(phils philosophers at: 1) process resume.(phils philosophers at: 1) process terminate.phils := Philosophers new.phils philosophers do: [:phil | phil process resume].phils philosophers do: [:phil | phil process terminate].</body>
</methods>


<methods>
<class-id>Philosophers</class-id> <category>neighbours</category>

<body package="FuenfPhilosophen" selector="leftOf:">leftOf: aPhilosoph 	^philosophers 		at: (aPhilosoph id = 1 ifTrue: [5] ifFalse: [aPhilosoph id - 1])</body>

<body package="FuenfPhilosophen" selector="rightOf:">rightOf: aPhilosoph 	^philosophers 		at: (aPhilosoph id = 5 ifTrue: [1] ifFalse: [aPhilosoph id + 1])</body>
</methods>

<methods>
<class-id>Philosophers</class-id> <category>accessing</category>

<body package="FuenfPhilosophen" selector="philosophers">philosophers	""	^philosophers</body>
</methods>

<methods>
<class-id>Philosophers</class-id> <category>initialization</category>

<body package="FuenfPhilosophen" selector="initialize">initialize	"comment stating purpose of message"	philosophers := Array new: 5.	Philosoph resetIds.	Philosoph resetMutex.	1 to: 5		do: 			[:i | 			philosophers at: i put: Philosoph new.			(philosophers at: i) session: self]</body>
</methods>



</st-source>
