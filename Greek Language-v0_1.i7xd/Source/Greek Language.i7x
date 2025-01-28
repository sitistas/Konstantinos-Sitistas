Version 0.1 of Greek Language by Konstantinos Sitistas begins here.

"To make Greek the language of play."

[Για την έκδοση 10.2.0 του Inform 7 - Glulx μόνο]

Use authorial modesty.

Volume 1 - Settings

[A language extension is required to set the following variable correctly:]

The language of play is the Greek language.

[The following only needs to be done for inflected languages which distinguish
the genders -- which is why English doesn't do it.]

An object has a grammatical gender.

[Inform initialises this property sensibly. We can easily check the results:

	When play begins:
		repeat with T running through things:
			say "[T] has [grammatical gender of T]."

By default, if Inform can't see any reason to choose a particular gender,
it will use neuter.]

The grammatical gender of a woman is usually feminine gender.
The grammatical gender of an object is usually neuter gender.


[TODO: Now we define any unusual tenses we want to support. Inform allows up to 7
tenses, and it requires tenses 1 to 5 to be present, past, perfect, past
perfect, and future; English stops there, but two slots are left free for
other languages to create. ]

[It's customary to define a constant so that I6 code can conditionally compile
if we're using this extension, though nothing in the I7 compiler needs it.]

Include (-
Constant LIBRARY_GREEK; ! For dependency checking.
-)

Include (-
[ TextStartsWithAVowel txt  cp p letter result;
	if (txt == 0) return 0;
	cp = txt-->0; p == TEXT_TY_Temporarily_Transmute(txt);
	letter = BlkValueRead(txt, 0);
	! If the text is empty, letter will be 0 and the function will return false, as expected.
	if (IsAnA(letter) || IsAnE(letter) || IsAnI(letter) || IsAnO(letter) || IsAnU(letter) || letter == 'h' or 'H' || letter == 'η' or 'Η' or 'ή' or 'Ή' || letter == 'ω' or 'Ω' or 'ώ' or 'Ώ') {
		result = true;
	} else {
		result = false;
	}
	TEXT_TY_Untransmute(txt, p, cp);
	return result;
];
-)

To decide whether (T - a text) starts with a vowel:
	(- (TextStartsWithAVowel({-by-reference:T})) -)

Volume 2 - Language

Part 2.1 - Determiners

Chapter 2.1.1 - Articles

To say ο/η/το/οι/τα (O - object):
	say "[the O]".

To say ένας/μία/ένα (O - object):[Το αόριστο άρθρο δεν έχει πληθυντικό στα ελληνικά]
	say "[a O]".

To say Ο/Η/Το/Οι/Τα (O - object):
	say "[The O]".

To say Ένας/Μία/Ένα (O - object):
	say "[A O]".

[ Include [preform](-
language Greek)

<definite-article> ::=
    /b/ un |				[singular, masculine]
	/c/ une |				[singular, feminine]
	/e/ des					[plural, masculine (by default)]

-) in the Preform grammar. ]



Include (-
Constant LanguageAnimateGender   = male;
Constant LanguageInanimateGender = neuter;

Constant LanguageContractionForms = 2;     ! English has two:
                                           ! 0 = starting with a consonant
                                           ! 1 = starting with a vowel

[ LanguageContraction text;
	if (IsAnA(text->0) || IsAnE(text->0) || IsAnI(text->0) || IsAnO(text->0) || IsAnU(text->0) || text->0 == 'h' or 'H' or 'η' or 'Η' or 'ή' or 'Ή' or 'ω' or 'Ω' or 'ώ' or 'Ώ' or 'κ' or 'Κ' or 'π' or 'Π' or 'τ' or 'Τ' or 'ξ' or 'Ξ' or 'ψ' or 'Ψ') return 1;
    ! TODO: Να προστεθούν οι δίφθογγοι γκ, μπ, ντ, τσ, τζ
	return 0;
];

Array LanguageArticles -->

!   Contraction form 0:     Contraction form 1:
!   Cdef   Def    Indef     Cdef   Def    Indef

	"Ο "   "ο "   "ένας "   "Ο "   "ο "   "ένας "		! 0: masc sing
	"Η "   "η "   "μία "    "Η "   "η "   "μία "		! 1: femi sing
	"Το "  "το "  "ένα "    "Το "  "το "  "ένα "		! 2: neut sing
	"Οι "  "οι "  "κάποιοι ""Οι "  "οι "  "κάποιοι "	! 3: masc plur
	"Οι "  "οι "  "κάποιες ""Οι "  "οι "  "κάποιες "	! 4: femi plur
	"Τα "  "τα "  "κάποια " "Τα "  "τα "  "κάποια ";	! 5: neut plur

			!             a           i
			!             s     p     s     p
			!             m f n m f n m f n m f n

Array LanguageGNAsToArticles --> 0 1 2 3 4 5 0 1 2 3 4 5;


-) replacing "Articles".

Chapter 2.1.2 - Numbers

Include [preform](-
language Greek

<cardinal-number-in-words> ::=
	μηδέν |
	ένα |
	δύο |
	τρία |
	τέσσερα |
	πέντε |
	έξι |
	επτά |
	οκτώ |
	εννέα |
	δέκα |
	έντεκα |
	δώδεκα

-) in the Preform grammar.

Include (-
Array LanguageNumbers table
    'ένα' 1 'δύο' 2 'τρία' 3 'τέσσερα' 4 'πέντε' 5
    'έξι' 6 'επτά' 7 'οκτώ' 8 'εννέα' 9 'δέκα' 10
    'έντεκα' 11 'δώδεκα' 12 'δεκατρία' 13 'δεκατέσσερα' 14 'δεκαπέντε' 15
    'δεκαέξι' 16 'δεκαεπτά' 17 'δεκαοκτώ' 18 'δεκαεννέα' 19 'είκοσι' 20
    'είκοσι ένα' 21 'είκοσι δύο' 22 'είκοσι τρία' 23 'είκοσι τέσσερα' 24
	'είκοσι πέντε' 25 'είκοσι έξι' 26 'είκοσι επτά' 27 'είκοσι οκτώ' 28
	'είκοσι εννέα' 29 'τριάντα' 30 'μία' 1
;
! TODO: Make the following work
! [ LanguageNumber n f;
!     if (n == 0) {
! 		print "μηδέν";
! 		rfalse;
! 	}
! ];
!     if (n < 0) {
!         print "μείον ";
!         n = -n;
!     }

!     if (n >= 1000) {
!         if (n / 1000 == 1) {  ! Αν είναι ακριβώς 1000
!             print "χίλια";
!         } else {  ! Αν είναι μεγαλύτερο από 1000
!             LanguageNumber(n / 1000, false);
!             print " χιλιάδες";
!         }
!         n = n % 1000;
!         if (n) {
!             print " ";
!         } else {
!             return;
!         }
!     }
! ];
-) replacing "Numbers".

Part 2.2 - Nouns

Chapter 2.2.1 - Pronouns and possessives for the player

The adaptive text viewpoint of the Greek language is second person singular.

When play begins (this is the initialise the story viewpoint rule):
	now the story viewpoint is the second person plural.

To say εσύ:
	now the prior named object is the player;
	if the story viewpoint is first person singular:
		say "εγώ";
	else if the story viewpoint is second person singular:
		say "εσύ";
	else if the story viewpoint is third person singular:
		if the player is male:
			say "αυτός";
		else if the player is female:
			say "αυτή";
		otherwise:
			say "αυτό";
	else if the story viewpoint is first person plural:
		say "εμείς";
	else if the story viewpoint is second person plural:
		say "εσείς";
	else if the story viewpoint is third person plural:
		if the player is male:
			say "αυτοί";
		else if the player is female:
			say "αυτές";
		otherwise:
			say "αυτά".

To say Εσύ:
	now the prior named object is the player;
	if the story viewpoint is first person singular:
		say "Εγώ";
	else if the story viewpoint is second person singular:
		say "Εσύ";
	else if the story viewpoint is third person singular:
		if the player is male:
			say "Αυτός";
		else if the player is female:
			say "Αυτή";
		otherwise:
			say "Αυτό";
	else if the story viewpoint is first person plural:
		say "Εμείς";
	else if the story viewpoint is second person plural:
		say "Εσείς";
	else if the story viewpoint is third person plural:
		if the player is male:
			say "Αυτοί";
		else if the player is female:
			say "Αυτές";
		otherwise:
			say "Αυτά".

[ TODO: Continue from here ]
Chapter 2.2.2 - Pronouns and possessives for other objects

Chapter 2.2.3 - Directions

[ North translates into Greek as ο βοράς. ]
[ South translates into Greek as νότια.
East translates into Greek as ανατολικά.
West translates into Greek as δυτικά.
Northeast translates into Greek as βορειοανατολικά.
Southwest translates into Greek as νοτιοδυτικά.
Southeast translates into Greek as νοτιοανατολικά
Northwest translates into Greek as βορειοδυτικά.
Inside translates into Greek as μέσα.
Outside translates into Greek as έξω.
Up translates into Greek as πάνω.
Down translates into Greek as κάτω. ]

[ The indefinite article of ο βοράς is "ο". ]

Chapter 2.2.4 - Kinds

Section 2.2.4.1 - In the Standard Rules

[ An object translates into Greek as ένα αντικείμενο.
Αυτό απαιτεί preform syntax ]

Chapter 2.2.5 - Plurals

Chapter 2.2.6 - Cases

Chapter 2.2.7 - Times of day

Include (-
[ LanguageTimeOfDay hours mins i;
    i = hours%12;
    if (i == 0) i = 12;
    if (i < 10) print " ";
    print i, ":", mins/10, mins%10;
    if ((hours/12) > 0) print " μ.μ."; else print " π.μ.";
];
-) replacing "Time".

[ Include (-
[ PrintTimeOfDay t h;
	if (t < 0) {
		print "<pas d'heure>";
		return;
	}
	h = t / ONE_HOUR;
	print h, "@{A0}h";
	if (t % ONE_HOUR) print "@{A0}", t % ONE_HOUR;
];
-) replacing "Digital Printing". ]

Part 2.3 - Adjectives

Chapter 2.3.1 - Ajectives agreement rules

[Adjectives have six forms: neuter singular, neuter plural, masculine singular,
masculine plural, feminine singular, feminine plural. They're constructed
using tries:

	n.s.		(base text unchanged)
	n.p.		base modified by <adjective-to-plural>
	m.s.		base modified by <adjective-to-masculine-singular>
	m.p.		base modified by <adjective-to-masculine-singular>
				then further by <adjective-to-masculine-plural>
	f.s.		base modified by <adjective-to-feminine-singular>
	f.p.		base modified by <adjective-to-feminine-singular>
				then further by <adjective-to-feminine-plural>]

Chapter 2.3.2 - New adjectives

[ In Greek αναμμένος is an adjective. ]

Part 2.4 - Verbs

Chapter 2.4.1 - Verb conjugations

Chapter 2.4.2 - Verb substitutions

Chapter 2.4.3 - Meaningful verbs

Section 2.4.3.1 - In the Standard Rules

Chapter 2.4.4 - Prepositions

Chapter 2.4.5 - Meaningless verbs

Part 2.5 - Miscellaneous substitutions

To say τώρα:
	if the story tense is present tense, say "τώρα";
	else say "εκείνη την εποχή".

To say εδώ:
	if the story tense is present tense, say "εδώ";
	else say "σε αυτό το μέρος".

To say τώρα:
	if the story tense is present tense, say "Τώρα";
	else say "Εκείνη την εποχή".

To say εδώ:
	if the story tense is present tense, say "Εδώ";
	else say "Σε αυτό το μέρος".

Volume 3 - Responses

Part 3.1 - Responses

Chapter 3.1.1 - In the Standard Rules

[And now the responses from this extension. You can get a full set of these by
trying out any English source text, e.g.,

	The Amphitheatre is a room.

and then typing the command:

	RESPONSES SET 1

This produces text which can be pasted in here before being translated.]

Section 3.1.1.1 - The final question

Section 3.1.1.2 - Standard actions which move the actor

[Going , Entering , Exiting , Getting off]

[ Going ]

    can't go that way rule response (A) is "Δεν μπορείς να πας προς αυτή την κατεύθυνση".

    can't go that way rule response (B) is "Δεν μπορείς να πας τα εκεί".

Part 3.2 - The Final Question

Part 3.3 - Description of the player

Part 3.4 - The banner

Part 3.5 - The bibliographical data

Part 3.6 - Rule replacements

Volume 4 - Command parsing

Part 4.1 - Pronouns and possessives in commands

Include (-
Array LanguagePronouns table

    ! word        possible GNAs                   connected
    !             to follow:                      to:
    !             a     i
    !             s  p  s  p
    !             mfnmfnmfnmfn

    'αυτός'     $$100000100000                    NULL
    'αυτή'      $$010000010000                    NULL
    'αυτό'      $$001000001000                    NULL
    'αυτοί'     $$000100000100                    NULL
    'αυτές'     $$000010000010                    NULL
    'αυτά'      $$000001000001                    NULL;
-) replacing "Pronouns".

Include(-

Array LanguageDescriptors table

  ! word        possible GNAs   descriptor      connected
  !             to follow:      type:           to:
  !             a     i
  !             s  p  s  p
  !             mfnmfnmfnmfn

    'μου'     $$111111111111    POSSESS_PK      0
    'this'    $$111111111111    POSSESS_PK      0
    'this'    $$111111111111    POSSESS_PK      0
    'this'    $$111111111111    POSSESS_PK      0
    'these'   $$000111000111    POSSESS_PK      0
    'that'    $$111111111111    POSSESS_PK      1
    'those'   $$000111000111    POSSESS_PK      1
    'his'     $$111111111111    POSSESS_PK      'him'
    'her'     $$111111111111    POSSESS_PK      'her'
    'their'   $$111111111111    POSSESS_PK      'them'
    'its'     $$111111111111    POSSESS_PK      'it'
    'ο'       $$100000100000    DEFART_PK       NULL
    'του'     $$101000101000    DEFART_PK       NULL
    'τον'     $$100000100000    DEFART_PK       NULL
    'στον'    $$100000100000    DEFART_PK       NULL
    'η'       $$010000010000    DEFART_PK       NULL
    'της'     $$010000010000    DEFART_PK       NULL
    'την'     $$010000010000    DEFART_PK       NULL
    'στην'    $$010000010000    DEFART_PK       NULL
    'το'      $$001000001000    DEFART_PK       NULL
    'στο'     $$001000001000    DEFART_PK       NULL
    'οι'      $$000110000110    DEFART_PK       NULL
    'των'     $$000111000111    DEFART_PK       NULL
    'τους'    $$000100000100    DEFART_PK       NULL
    'στους'   $$000100000100    DEFART_PK       NULL
    'τις'     $$000010000010    DEFART_PK       NULL
    'στις'    $$000010000010    DEFART_PK       NULL
    'τα'      $$000001000001    DEFART_PK       NULL
    'στα'     $$000001000001    DEFART_PK       NULL
    'ένας'    $$100000100000    INDEFART_PK     NULL
    'ενός'    $$101000101000    INDEFART_PK     NULL
    'έναν'    $$100000100000    INDEFART_PK     NULL
    'μία'     $$010000010000    INDEFART_PK     NULL
    'μίας'    $$010000010000    INDEFART_PK     NULL
    'ένα'     $$001000001000    INDEFART_PK     NULL
    ! Το κάποιος/α/ο... βγάζει complexity error οπότε το αγνοούμε προς το παρόν
    'lit'     $$111111111111    LIGHTED_PK      NULL
    'lighted' $$111111111111    LIGHTED_PK      NULL
    'unlit'   $$111111111111    UNLIGHTED_PK    NULL;
-) replacing "Descriptors".

Part 4.2 - Understand grammar

Chapter 4.2.1 - New Grammar Tokens

Chapter 4.2.2 - Standard actions concerning the actor's possessions

Chapter 4.2.3 - Standard actions which move the actor

Chapter 4.2.4 - Standard actions concerning the actor's vision

Chapter 4.2.5 - Standard actions which change the state of things

Chapter 4.2.6 - Standard actions concerning other people

Chapter 4.2.7 - Standard actions which are checked but then do nothing unless rules intervene

Chapter 4.2.8 - Standard actions which always do nothing unless rules intervene

Chapter 4.2.9 - Standard actions which happen out of world

Chapter 4.2.10 - Miscellaneous

Part 4.3 - Additional language-specific actions

Chapter 4.3.1 - InGoing

Chapter 4.3.2 - OutGoing

Chapter 4.3.3 - DownGoing

Chapter 4.3.4 - UpGoing

Chapter 4.3.5 - UpStanding

Part 4.4 - Clarifying the parser's choice of something

Part 4.5 - Actions specifications

Chapter 4.5.1 - Standard actions concerning the actor's possessions

Chapter 4.5.2 - Standard actions which move the actor

Chapter 4.5.3 - Standard actions concerning the actor's vision

Chapter 4.5.4 - Standard actions which change the state of things

Chapter 4.5.5 - Standard actions concerning other people

Chapter 4.5.6 - Standard actions which are checked but then do nothing unless rules intervene

Chapter 4.5.7 - Standard actions which always do nothing unless rules intervene

Part 4.6 - Command parser internals

Include (-
Constant AGAIN1__WD     = 'ξανά';
Constant AGAIN2__WD     = 'πάλι';
Constant AGAIN3__WD     = 'again';
Constant OOPS1__WD      = 'λάθος';
Constant OOPS2__WD      = 'σφάλμα';
Constant OOPS3__WD      = 'ουπς';
Constant UNDO1__WD      = 'ακύρωση';
Constant UNDO2__WD      = 'αναίρεση';
Constant UNDO3__WD      = 'undo';

Constant ALL1__WD       = 'όλοι';
Constant ALL2__WD       = 'όλες';
Constant ALL3__WD       = 'όλα';
Constant ALL4__WD       = 'everything';
Constant ALL5__WD       = 'both';
Constant AND1__WD       = 'και';
Constant AND2__WD       = 'κι';
Constant AND3__WD       = 'and';
Constant BUT1__WD       = 'αλλά';
Constant BUT2__WD       = 'εκτός_από';
Constant BUT3__WD       = 'όμως';
Constant BY__WD         = 'από';
Constant ME1__WD        = 'εγώ';
Constant ME2__WD        = 'εμένα';
Constant ME3__WD        = 'με';
Constant OF1__WD        = 'of';
Constant OF2__WD        = 'of';
Constant OF3__WD        = 'of';
Constant OF4__WD        = 'of';
Constant OTHER1__WD     = 'another';
Constant OTHER2__WD     = 'other';
Constant OTHER3__WD     = 'other';
Constant THEN1__WD      = 'έπειτα';
Constant THEN2__WD      = 'μετά';
Constant THEN3__WD      = 'τότε';

Constant NO1__WD        = 'όχι';
Constant NO2__WD        = 'ο//';
Constant NO3__WD        = 'οχι';
Constant YES1__WD       = 'ναι';
Constant YES2__WD       = 'ν//';
Constant YES3__WD       = 'yes';

Constant AMUSING__WD    = 'amusing';
Constant FULLSCORE1__WD = 'αποτέλεσμα';
Constant FULLSCORE2__WD = 'βαθμολογία';
Constant QUIT1__WD      = 'τέλος';
Constant QUIT2__WD      = 'ΤΕΛΟΣ';
Constant RESTART__WD    = 'επανεκκίνηση';
Constant RESTORE__WD    = 'επαναφορά';
-) replacing "Vocabulary".

Part 4.7 - Informese translation of commands

Include (-
[ IsAnA c;
	! αά + κεφαλαία
	if ((c == 'α' or 'Α' or 'ά' or 'Ά') || (c == 'a' or 'A') || (c > 191 && c < 199) || (c > 223 && c < 231)) return true;
	return false;
];
[ IsAnE c;
	! εέ + κεφαλαία
	if ((c == 'ε' or 'Ε' or 'έ' or 'Έ') || (c == 'e' or 'E') || (c > 199 && c < 204) || (c > 231 && c < 236)) return true;
	return false;
];
[ IsAnI c;
	! ιί + κεφαλαία
	if ((c == 'ι' or 'Ι' or 'ί' or 'Ί') || (c == 'i' or 'I') || (c > 203 && c < 208) || (c > 235 && c < 240)) return true;
	return false;
];
[ IsAnO c;
	! οό + κεφαλαία
	if ((c == 'ο' or 'Ο' or 'ό' or 'Ό') || (c == 'o' or 'O') || (c > 209 && c < 215) || (c == 216 or 248 or 338 or 339) || (c > 241 && c < 247)) return true;
	return false;
];
[ IsAnU c;
	! υύ + κεφαλαία
	if ((c == 'υ' or 'Υ' or 'ύ' or 'Ύ') || (c == 'u' or 'U') || (c > 216 && c < 221) || (c > 248 && c < 253)) return true;
	return false;
];
-)

Greek Language ends here.

---- DOCUMENTATION ----

Section: Παρουσίαση

Section: Εγκατάσταση