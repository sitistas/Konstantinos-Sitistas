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
