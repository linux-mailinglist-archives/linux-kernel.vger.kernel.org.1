Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEA12CA245
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 13:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390052AbgLAMLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 07:11:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:40536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730756AbgLAMKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 07:10:38 -0500
Received: from mail.kernel.org (ip5f5ad5d9.dynamic.kabel-deutschland.de [95.90.213.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4042C2087C;
        Tue,  1 Dec 2020 12:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606824555;
        bh=GPoU2wUsl9XvvTVStua0GhdtE/dd9zbQwjcn+vzNUT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H9vRvZ5FzFwF6WvoW428iDbOoZXfD6akey1ezsjCVAbjWPIuFDNgGuiqkx7zSHXeD
         MgIqz1k7/5ixOn9QLjA24fI1Aw8jSiP2Llikv+6WuUVfpFQhO3lN/EUiQTyRF6U0eR
         OJhpFGBezgCUBO9tgoTHzovaWNpcApop6EJS2jNQ=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kk4T3-00DGdX-B4; Tue, 01 Dec 2020 13:09:13 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 16/16] scripts: kernel-doc: validate kernel-doc markup with the actual names
Date:   Tue,  1 Dec 2020 13:09:09 +0100
Message-Id: <03ac429b0d41755e491c8fd80ca927d65b87d7d1.1606823973.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1606823973.git.mchehab+huawei@kernel.org>
References: <cover.1606823973.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel-doc currently expects that the kernel-doc markup to come
just before the function/enum/struct/union/typedef prototype.

Yet, if it find things like:

	/**
	 * refcount_add - add a value to a refcount
	 * @i: the value to add to the refcount
	 * @r: the refcount
	 */
	static inline void __refcount_add(int i, refcount_t *r, int *oldp);
	static inline void refcount_add(int i, refcount_t *r);

Kernel-doc will do the wrong thing:

	foobar.h:6: warning: Function parameter or member 'oldp' not described in '__refcount_add'
	.. c:function:: void __refcount_add (int i, refcount_t *r, int *oldp)

	   add a value to a refcount

	**Parameters**

	``int i``
	  the value to add to the refcount

	``refcount_t *r``
	  the refcount

	``int *oldp``
	  *undescribed*

Basically, it will document "__refcount_add" with the kernel-doc
markup for refcount_add.

If both functions have the same arguments, this won't even
produce any warning!

Add a logic to check if the kernel-doc identifier matches the actual
name of the C function or data structure that will be documented.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc | 62 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 46 insertions(+), 16 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 9b6ddeb097e9..919acae23fad 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -353,64 +353,67 @@ my $lineprefix="";
 
 # Parser states
 use constant {
     STATE_NORMAL        => 0,        # normal code
     STATE_NAME          => 1,        # looking for function name
     STATE_BODY_MAYBE    => 2,        # body - or maybe more description
     STATE_BODY          => 3,        # the body of the comment
     STATE_BODY_WITH_BLANK_LINE => 4, # the body, which has a blank line
     STATE_PROTO         => 5,        # scanning prototype
     STATE_DOCBLOCK      => 6,        # documentation block
     STATE_INLINE        => 7,        # gathering doc outside main block
 };
 my $state;
 my $in_doc_sect;
 my $leading_space;
 
 # Inline documentation state
 use constant {
     STATE_INLINE_NA     => 0, # not applicable ($state != STATE_INLINE)
     STATE_INLINE_NAME   => 1, # looking for member name (@foo:)
     STATE_INLINE_TEXT   => 2, # looking for member documentation
     STATE_INLINE_END    => 3, # done
     STATE_INLINE_ERROR  => 4, # error - Comment without header was found.
                               # Spit a warning as it's not
                               # proper kernel-doc and ignore the rest.
 };
 my $inline_doc_state;
 
 #declaration types: can be
 # 'function', 'struct', 'union', 'enum', 'typedef'
 my $decl_type;
 
+# Name of the kernel-doc identifier for non-DOC markups
+my $identifier;
+
 my $doc_start = '^/\*\*\s*$'; # Allow whitespace at end of comment start.
 my $doc_end = '\*/';
 my $doc_com = '\s*\*\s*';
 my $doc_com_body = '\s*\* ?';
 my $doc_decl = $doc_com . '(\w+)';
 # @params and a strictly limited set of supported section names
 my $doc_sect = $doc_com .
     '\s*(\@[.\w]+|\@\.\.\.|description|context|returns?|notes?|examples?)\s*:(.*)';
 my $doc_content = $doc_com_body . '(.*)';
 my $doc_block = $doc_com . 'DOC:\s*(.*)?';
 my $doc_inline_start = '^\s*/\*\*\s*$';
 my $doc_inline_sect = '\s*\*\s*(@\s*[\w][\w\.]*\s*):(.*)';
 my $doc_inline_end = '^\s*\*/\s*$';
 my $doc_inline_oneline = '^\s*/\*\*\s*(@[\w\s]+):\s*(.*)\s*\*/\s*$';
 my $export_symbol = '^\s*EXPORT_SYMBOL(_GPL)?\s*\(\s*(\w+)\s*\)\s*;';
 
 my %parameterdescs;
 my %parameterdesc_start_lines;
 my @parameterlist;
 my %sections;
 my @sectionlist;
 my %section_start_lines;
 my $sectcheck;
 my $struct_actual;
 
 my $contents = "";
 my $new_start_line = 0;
 
 # the canonical section names. see also $doc_sect above.
 my $section_default = "Description";	# default section
 my $section_intro = "Introduction";
 my $section = $section_default;
@@ -1174,64 +1177,69 @@ sub output_declaration {
 ##
 # generic output function - calls the right one based on current output mode.
 sub output_blockhead {
     no strict 'refs';
     my $func = "output_blockhead_" . $output_mode;
     &$func(@_);
     $section_counter++;
 }
 
 ##
 # takes a declaration (struct, union, enum, typedef) and
 # invokes the right handler. NOT called for functions.
 sub dump_declaration($$) {
     no strict 'refs';
     my ($prototype, $file) = @_;
     my $func = "dump_" . $decl_type;
     &$func(@_);
 }
 
 sub dump_union($$) {
     dump_struct(@_);
 }
 
 sub dump_struct($$) {
     my $x = shift;
     my $file = shift;
 
     if ($x =~ /(struct|union)\s+(\w+)\s*\{(.*)\}(\s*(__packed|__aligned|____cacheline_aligned_in_smp|____cacheline_aligned|__attribute__\s*\(\([a-z0-9,_\s\(\)]*\)\)))*/) {
 	my $decl_type = $1;
 	$declaration_name = $2;
 	my $members = $3;
 
+	if ($identifier ne $declaration_name) {
+	    print STDERR "${file}:$.: warning: expecting prototype for $decl_type $identifier. Prototype was for $decl_type $declaration_name instead\n";
+	    return;
+	}
+
 	# ignore members marked private:
 	$members =~ s/\/\*\s*private:.*?\/\*\s*public:.*?\*\///gosi;
 	$members =~ s/\/\*\s*private:.*//gosi;
 	# strip comments:
 	$members =~ s/\/\*.*?\*\///gos;
 	# strip attributes
 	$members =~ s/\s*__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)/ /gi;
 	$members =~ s/\s*__aligned\s*\([^;]*\)/ /gos;
 	$members =~ s/\s*__packed\s*/ /gos;
 	$members =~ s/\s*CRYPTO_MINALIGN_ATTR/ /gos;
 	$members =~ s/\s*____cacheline_aligned_in_smp/ /gos;
 	$members =~ s/\s*____cacheline_aligned/ /gos;
 
 	# replace DECLARE_BITMAP
 	$members =~ s/__ETHTOOL_DECLARE_LINK_MODE_MASK\s*\(([^\)]+)\)/DECLARE_BITMAP($1, __ETHTOOL_LINK_MODE_MASK_NBITS)/gos;
 	$members =~ s/DECLARE_BITMAP\s*\(([^,)]+),\s*([^,)]+)\)/unsigned long $1\[BITS_TO_LONGS($2)\]/gos;
 	# replace DECLARE_HASHTABLE
 	$members =~ s/DECLARE_HASHTABLE\s*\(([^,)]+),\s*([^,)]+)\)/unsigned long $1\[1 << (($2) - 1)\]/gos;
 	# replace DECLARE_KFIFO
 	$members =~ s/DECLARE_KFIFO\s*\(([^,)]+),\s*([^,)]+),\s*([^,)]+)\)/$2 \*$1/gos;
 	# replace DECLARE_KFIFO_PTR
 	$members =~ s/DECLARE_KFIFO_PTR\s*\(([^,)]+),\s*([^,)]+)\)/$2 \*$1/gos;
 
 	my $declaration = $members;
 
 	# Split nested struct/union elements as newer ones
 	while ($members =~ m/(struct|union)([^\{\};]+)\{([^\{\}]*)\}([^\{\}\;]*)\;/) {
 		my $newmember;
 		my $maintype = $1;
 		my $ids = $4;
 		my $content = $3;
 		foreach my $id(split /,/, $ids) {
@@ -1362,150 +1370,165 @@ sub show_warnings($$) {
 			return 0;
 		}
 	}
 	if ($output_selection == OUTPUT_INCLUDE) {
 		if (defined($function_table{$name})) {
 			return 1;
 		} else {
 			return 0;
 		}
 	}
 	die("Please add the new output type at show_warnings()");
 }
 
 sub dump_enum($$) {
     my $x = shift;
     my $file = shift;
     my $members;
 
 
     $x =~ s@/\*.*?\*/@@gos;	# strip comments.
     # strip #define macros inside enums
     $x =~ s@#\s*((define|ifdef)\s+|endif)[^;]*;@@gos;
 
     if ($x =~ /typedef\s+enum\s*\{(.*)\}\s*(\w*)\s*;/) {
 	$declaration_name = $2;
 	$members = $1;
     } elsif ($x =~ /enum\s+(\w*)\s*\{(.*)\}/) {
 	$declaration_name = $1;
 	$members = $2;
     }
 
     if ($members) {
+	if ($identifier ne $declaration_name) {
+	    print STDERR "${file}:$.: warning: expecting prototype for enum $identifier. Prototype was for enum $declaration_name instead\n";
+	    return;
+	}
+
 	my %_members;
 
 	$members =~ s/\s+$//;
 
 	foreach my $arg (split ',', $members) {
 	    $arg =~ s/^\s*(\w+).*/$1/;
 	    push @parameterlist, $arg;
 	    if (!$parameterdescs{$arg}) {
 		$parameterdescs{$arg} = $undescribed;
 	        if (show_warnings("enum", $declaration_name)) {
 			print STDERR "${file}:$.: warning: Enum value '$arg' not described in enum '$declaration_name'\n";
 		}
 	    }
 	    $_members{$arg} = 1;
 	}
 
 	while (my ($k, $v) = each %parameterdescs) {
 	    if (!exists($_members{$k})) {
 	        if (show_warnings("enum", $declaration_name)) {
 		     print STDERR "${file}:$.: warning: Excess enum value '$k' description in '$declaration_name'\n";
 		}
 	    }
         }
 
 	output_declaration($declaration_name,
 			   'enum',
 			   {'enum' => $declaration_name,
 			    'module' => $modulename,
 			    'parameterlist' => \@parameterlist,
 			    'parameterdescs' => \%parameterdescs,
 			    'sectionlist' => \@sectionlist,
 			    'sections' => \%sections,
 			    'purpose' => $declaration_purpose
 			   });
     } else {
 	print STDERR "${file}:$.: error: Cannot parse enum!\n";
 	++$errors;
     }
 }
 
 my $typedef_type = qr { ((?:\s+[\w\*]+){1,8})\s* }x;
 my $typedef_ident = qr { \*?\s*(\w\S+)\s* }x;
 my $typedef_args = qr { \s*\((.*)\); }x;
 
 my $typedef1 = qr { typedef$typedef_type\($typedef_ident\)$typedef_args }x;
 my $typedef2 = qr { typedef$typedef_type$typedef_ident$typedef_args }x;
 
 sub dump_typedef($$) {
     my $x = shift;
     my $file = shift;
 
     $x =~ s@/\*.*?\*/@@gos;	# strip comments.
 
     # Parse function typedef prototypes
     if ($x =~ $typedef1 || $x =~ $typedef2) {
 	$return_type = $1;
 	$declaration_name = $2;
 	my $args = $3;
 	$return_type =~ s/^\s+//;
 
+	if ($identifier ne $declaration_name) {
+	    print STDERR "${file}:$.: warning: expecting prototype for typedef $identifier. Prototype was for typedef $declaration_name instead\n";
+	    return;
+	}
+
 	create_parameterlist($args, ',', $file, $declaration_name);
 
 	output_declaration($declaration_name,
 			   'function',
 			   {'function' => $declaration_name,
 			    'typedef' => 1,
 			    'module' => $modulename,
 			    'functiontype' => $return_type,
 			    'parameterlist' => \@parameterlist,
 			    'parameterdescs' => \%parameterdescs,
 			    'parametertypes' => \%parametertypes,
 			    'sectionlist' => \@sectionlist,
 			    'sections' => \%sections,
 			    'purpose' => $declaration_purpose
 			   });
 	return;
     }
 
     while (($x =~ /\(*.\)\s*;$/) || ($x =~ /\[*.\]\s*;$/)) {
 	$x =~ s/\(*.\)\s*;$/;/;
 	$x =~ s/\[*.\]\s*;$/;/;
     }
 
     if ($x =~ /typedef.*\s+(\w+)\s*;/) {
 	$declaration_name = $1;
 
+	if ($identifier ne $declaration_name) {
+	    print STDERR "${file}:$.: warning: expecting prototype for typedef $identifier. Prototype was for typedef $declaration_name instead\n";
+	    return;
+	}
+
 	output_declaration($declaration_name,
 			   'typedef',
 			   {'typedef' => $declaration_name,
 			    'module' => $modulename,
 			    'sectionlist' => \@sectionlist,
 			    'sections' => \%sections,
 			    'purpose' => $declaration_purpose
 			   });
     }
     else {
 	print STDERR "${file}:$.: error: Cannot parse typedef!\n";
 	++$errors;
     }
 }
 
 sub save_struct_actual($) {
     my $actual = shift;
 
     # strip all spaces from the actual param so that it looks like one string item
     $actual =~ s/\s*//g;
     $struct_actual = $struct_actual . $actual . " ";
 }
 
 sub create_parameterlist($$$$) {
     my $args = shift;
     my $splitter = shift;
     my $file = shift;
     my $declaration_name = shift;
     my $type;
     my $param;
 
     # temporarily replace commas inside function pointer definition
@@ -1767,64 +1790,69 @@ sub dump_function($$) {
         # Function-like macros are not allowed to have spaces between
         # declaration_name and opening parenthesis (notice the \s+).
         $return_type = $1;
         $declaration_name = $2;
         $noret = 1;
     } elsif ($prototype =~ m/^()([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
 	$prototype =~ m/^(\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
 	$prototype =~ m/^(\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
 	$prototype =~ m/^(\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
 	$prototype =~ m/^(\w+\s+\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
 	$prototype =~ m/^(\w+\s+\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
 	$prototype =~ m/^(\w+\s+\w+\s+\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
 	$prototype =~ m/^()([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
 	$prototype =~ m/^(\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
 	$prototype =~ m/^(\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
 	$prototype =~ m/^(\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
 	$prototype =~ m/^(\w+\s+\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
 	$prototype =~ m/^(\w+\s+\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
 	$prototype =~ m/^(\w+\s+\w+\s+\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
 	$prototype =~ m/^(\w+\s+\w+\s+\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
 	$prototype =~ m/^(\w+\s+\w+\s+\w+\s+\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
 	$prototype =~ m/^(\w+\s+\w+\s*\*+\s*\w+\s*\*+\s*)\s*([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/)  {
 	$return_type = $1;
 	$declaration_name = $2;
 	my $args = $3;
 
 	create_parameterlist($args, ',', $file, $declaration_name);
     } else {
 	print STDERR "${file}:$.: warning: cannot understand function prototype: '$prototype'\n";
 	return;
     }
 
+    if ($identifier ne $declaration_name) {
+	print STDERR "${file}:$.: warning: expecting prototype for $identifier(). Prototype was for $declaration_name() instead\n";
+	return;
+    }
+
     my $prms = join " ", @parameterlist;
     check_sections($file, $declaration_name, "function", $sectcheck, $prms);
 
     # This check emits a lot of warnings at the moment, because many
     # functions don't have a 'Return' doc section. So until the number
     # of warnings goes sufficiently down, the check is only performed in
     # verbose mode.
     # TODO: always perform the check.
     if ($verbose && !$noret) {
 	    check_return_section($file, $declaration_name, $return_type);
     }
 
     # The function parser can be called with a typedef parameter.
     # Handle it.
     if ($return_type =~ /typedef/) {
 	output_declaration($declaration_name,
 			   'function',
 			   {'function' => $declaration_name,
 			    'typedef' => 1,
 			    'module' => $modulename,
 			    'functiontype' => $return_type,
 			    'parameterlist' => \@parameterlist,
 			    'parameterdescs' => \%parameterdescs,
 			    'parametertypes' => \%parametertypes,
 			    'sectionlist' => \@sectionlist,
 			    'sections' => \%sections,
 			    'purpose' => $declaration_purpose
 			   });
     } else {
 	output_declaration($declaration_name,
 			   'function',
 			   {'function' => $declaration_name,
@@ -1849,64 +1877,65 @@ sub reset_state {
     @sectionlist = ();
     $sectcheck = "";
     $struct_actual = "";
     $prototype = "";
 
     $state = STATE_NORMAL;
     $inline_doc_state = STATE_INLINE_NA;
 }
 
 sub tracepoint_munge($) {
 	my $file = shift;
 	my $tracepointname = 0;
 	my $tracepointargs = 0;
 
 	if ($prototype =~ m/TRACE_EVENT\((.*?),/) {
 		$tracepointname = $1;
 	}
 	if ($prototype =~ m/DEFINE_SINGLE_EVENT\((.*?),/) {
 		$tracepointname = $1;
 	}
 	if ($prototype =~ m/DEFINE_EVENT\((.*?),(.*?),/) {
 		$tracepointname = $2;
 	}
 	$tracepointname =~ s/^\s+//; #strip leading whitespace
 	if ($prototype =~ m/TP_PROTO\((.*?)\)/) {
 		$tracepointargs = $1;
 	}
 	if (($tracepointname eq 0) || ($tracepointargs eq 0)) {
 		print STDERR "${file}:$.: warning: Unrecognized tracepoint format: \n".
 			     "$prototype\n";
 	} else {
 		$prototype = "static inline void trace_$tracepointname($tracepointargs)";
+		$identifier = "trace_$identifier";
 	}
 }
 
 sub syscall_munge() {
 	my $void = 0;
 
 	$prototype =~ s@[\r\n]+@ @gos; # strip newlines/CR's
 ##	if ($prototype =~ m/SYSCALL_DEFINE0\s*\(\s*(a-zA-Z0-9_)*\s*\)/) {
 	if ($prototype =~ m/SYSCALL_DEFINE0/) {
 		$void = 1;
 ##		$prototype = "long sys_$1(void)";
 	}
 
 	$prototype =~ s/SYSCALL_DEFINE.*\(/long sys_/; # fix return type & func name
 	if ($prototype =~ m/long (sys_.*?),/) {
 		$prototype =~ s/,/\(/;
 	} elsif ($void) {
 		$prototype =~ s/\)/\(void\)/;
 	}
 
 	# now delete all of the odd-number commas in $prototype
 	# so that arg types & arg names don't have a comma between them
 	my $count = 0;
 	my $len = length($prototype);
 	if ($void) {
 		$len = 0;	# skip the for-loop
 	}
 	for (my $ix = 0; $ix < $len; $ix++) {
 		if (substr($prototype, $ix, 1) eq ',') {
 			$count++;
 			if ($count % 2 == 1) {
 				substr($prototype, $ix, 1) = ' ';
@@ -2012,122 +2041,123 @@ sub process_export_file($) {
 	++$errors;
 	return;
     }
 
     while (<IN>) {
 	if (/$export_symbol/) {
 	    next if (defined($nosymbol_table{$2}));
 	    $function_table{$2} = 1;
 	}
     }
 
     close(IN);
 }
 
 #
 # Parsers for the various processing states.
 #
 # STATE_NORMAL: looking for the /** to begin everything.
 #
 sub process_normal() {
     if (/$doc_start/o) {
 	$state = STATE_NAME;	# next line is always the function name
 	$in_doc_sect = 0;
 	$declaration_start_line = $. + 1;
     }
 }
 
 #
 # STATE_NAME: Looking for the "name - description" line
 #
 sub process_name($$) {
     my $file = shift;
-    my $identifier;
     my $descr;
 
     if (/$doc_block/o) {
 	$state = STATE_DOCBLOCK;
 	$contents = "";
 	$new_start_line = $.;
 
 	if ( $1 eq "" ) {
 	    $section = $section_intro;
 	} else {
 	    $section = $1;
 	}
-    }
-    elsif (/$doc_decl/o) {
+    } elsif (/$doc_decl/o) {
 	$identifier = $1;
-	if (/\s*([\w\s]+?)(\(\))?\s*-/) {
+	if (/\s*([\w\s]+?)(\(\))?\s*([-:].*)?$/) {
 	    $identifier = $1;
 	}
+	if ($identifier =~ m/^(struct|union|enum|typedef)\b\s*(\S*)/) {
+	    $decl_type = $1;
+	    $identifier = $2;
+	} else {
+	    $decl_type = 'function';
+	    $identifier =~ s/^define\s+//;
+	}
+	$identifier =~ s/\s+$//;
 
 	$state = STATE_BODY;
 	# if there's no @param blocks need to set up default section
 	# here
 	$contents = "";
 	$section = $section_default;
 	$new_start_line = $. + 1;
-	if (/-(.*)/) {
+	if (/[-:](.*)/) {
 	    # strip leading/trailing/multiple spaces
 	    $descr= $1;
 	    $descr =~ s/^\s*//;
 	    $descr =~ s/\s*$//;
 	    $descr =~ s/\s+/ /g;
 	    $declaration_purpose = $descr;
 	    $state = STATE_BODY_MAYBE;
 	} else {
 	    $declaration_purpose = "";
 	}
 
 	if (($declaration_purpose eq "") && $verbose) {
 	    print STDERR "${file}:$.: warning: missing initial short description on line:\n";
 	    print STDERR $_;
 	    ++$warnings;
 	}
 
-	if ($identifier =~ m/^struct\b/) {
-	    $decl_type = 'struct';
-	} elsif ($identifier =~ m/^union\b/) {
-	    $decl_type = 'union';
-	} elsif ($identifier =~ m/^enum\b/) {
-	    $decl_type = 'enum';
-	} elsif ($identifier =~ m/^typedef\b/) {
-	    $decl_type = 'typedef';
-	} else {
-	    $decl_type = 'function';
+	if ($identifier eq "") {
+	    print STDERR "${file}:$.: warning: wrong kernel-doc identifier on line:\n";
+	    print STDERR $_;
+	    ++$warnings;
+	    $state = STATE_NORMAL;
 	}
 
 	if ($verbose) {
-	    print STDERR "${file}:$.: info: Scanning doc for $identifier\n";
+	    print STDERR "${file}:$.: info: Scanning doc for $decl_type $identifier\n";
 	}
     } else {
 	print STDERR "${file}:$.: warning: Cannot understand $_ on line $.",
 	    " - I thought it was a doc line\n";
 	++$warnings;
 	$state = STATE_NORMAL;
     }
 }
 
 
 #
 # STATE_BODY and STATE_BODY_MAYBE: the bulk of a kerneldoc comment.
 #
 sub process_body($$) {
     my $file = shift;
 
     # Until all named variable macro parameters are
     # documented using the bare name (`x`) rather than with
     # dots (`x...`), strip the dots:
     if ($section =~ /\w\.\.\.$/) {
 	$section =~ s/\.\.\.$//;
 
 	if ($verbose) {
 	    print STDERR "${file}:$.: warning: Variable macro arguments should be documented without dots\n";
 	    ++$warnings;
 	}
     }
 
     if ($state == STATE_BODY_WITH_BLANK_LINE && /^\s*\*\s?\S/) {
 	dump_section($file, $section, $contents);
 	$section = $section_default;
 	$new_start_line = $.;
-- 
2.28.0

