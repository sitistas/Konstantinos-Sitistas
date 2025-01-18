Language Template.

The fundamental definitions needed by the parser and the verb
library in order to specify the language of play -- that is, the language
used for communications between the story file and the player.

@h Initialisation.
It used to be optional whether or not to include a function of this name in
a language kit: it's now compulsory, even when (as now) it does nothing.

=
[ LanguageInitialise; ];

@h Identification.

=
Constant GREEKLANGUAGEKIT = 1;

@h Pronouns.

=
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

@h Descriptors.

=
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



@h Time.

=
[ LanguageTimeOfDay hours mins i;
    i = hours%12;
    if (i == 0) i = 12;
    if (i < 10) print " ";
    print i, ":", mins/10, mins%10;
    if ((hours/12) > 0) print " μ.μ."; else print " π.μ.";
];

@h Directions.

=
[ LanguageDirection d;
	print (name) d;
];

@h Translation.
These are all opportunities to meddle with the normal (Anglo-centric) running
of things, which we will decline.

Until April 2023, it was optional for a kit to provide |LanguageRefers| and
|LanguagePrintShortName|, but this is now compulsory.

=
[ LanguageToInformese; ];

[ LanguageRefers x y; return -1; ];

[ LanguagePrintShortName obj; rfalse; ];

@h Articles.

=
Constant LanguageAnimateGender   = male;
Constant LanguageInanimateGender = neuter;

Constant LanguageContractionForms = 2;     ! English has two:
                                           ! 0 = starting with a consonant
                                           ! 1 = starting with a vowel
! Πρέπει να αλλαχθεί και για τα ελληνικά αντίστοιχα

[ LanguageContraction text
    ch;
    #Iftrue CHARSIZE == 1;
    ch = text->0;
    #Ifnot;
    ch = text-->0;
    #Endif; ! CHARSIZE
    if (ch == 'a' or 'e' or 'i' or 'o' or 'u'
           or 'A' or 'E' or 'I' or 'O' or 'U') return 1;
    return 0;
];

Array LanguageArticles -->

 !   Contraction form 0:     Contraction form 1:
 !   Cdef   Def    Indef     Cdef   Def    Indef

     "O "   "o "   "enas "   "O "   "o "   "enas "        ! Articles 0
     "The " "the " "some "   "The " "the " "some ";       ! Articles 1

                   !             a           i
                   !             s     p     s     p
                   !             m f n m f n m f n m f n

Array LanguageGNAsToArticles --> 0 0 0 1 1 1 0 0 0 1 1 1;

@h Commands.
|LanguageVerbLikesAdverb| is called by |PrintCommand| when printing an |UPTO_PE|
error or an inference message.  Words which are intransitive verbs, i.e.,
which require a direction name as an adverb ("walk west"), not a noun
("I only understood you as far as wanting to touch the ground"), should
cause the routine to return |true|.

|LanguageVerbMayBeName| is called by |NounDomain| when dealing with
the player's reply to a "Which do you mean, the short stick or the
long stick?" prompt from the parser. If the reply is another verb
(for example, LOOK) then then previous ambiguous command is discarded
unless it is one of these words which could be both a verb and an
adjective in a |name| property.

=
[ LanguageVerb i;
    switch (i) {
      'i//','inv','inventory':
               print "take inventory";
      'l//':   print "look";
      'x//':   print "examine";
      'z//':   print "wait";
      default: rfalse;
    }
    rtrue;
];

[ LanguageVerbLikesAdverb w;
    if (w == 'look' or 'go' or 'push' or 'walk')
        rtrue;
    rfalse;
];

[ LanguageVerbMayBeName w;
    if (w == 'long' or 'short' or 'normal' or 'brief' or 'full' or 'verbose')
        rtrue;
    rfalse;
];

@h Stubs.
To reduce the need for conditional compilation, we provide these stub
routines:

=
[ LanguageIsVerb buffer parse verb_wordnum;
	rfalse;
];
