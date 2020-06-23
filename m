Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725362057DA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 18:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387535AbgFWQs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 12:48:27 -0400
Received: from smtprelay0164.hostedemail.com ([216.40.44.164]:57326 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732640AbgFWQsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:48:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 8432B56F39;
        Tue, 23 Jun 2020 16:48:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:967:968:973:982:988:989:1260:1263:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2525:2561:2564:2682:2685:2693:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3354:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6117:7875:7903:8599:8957:8985:9010:9025:10004:10400:10848:11232:11258:11473:11658:11854:11914:12043:12114:12296:12297:12438:12555:12740:12760:12776:12895:12986:13071:13141:13230:13255:13439:14180:14181:14651:14659:14721:21060:21080:21221:21222:21347:21451:21499:21627:21740:21990:30012:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: thing87_140dc2a26e3d
X-Filterd-Recvd-Size: 4319
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Tue, 23 Jun 2020 16:48:20 +0000 (UTC)
Message-ID: <895052df95b2fc85b07e5a493fbb1ff415d8f62c.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: fix CONST_STRUCT when
 const_structs.checkpatch is missing
From:   Joe Perches <joe@perches.com>
To:     Quentin Monnet <quentin@isovalent.com>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 23 Jun 2020 09:48:19 -0700
In-Reply-To: <20200623103740.25876-1-quentin@isovalent.com>
References: <20200623103740.25876-1-quentin@isovalent.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again.

On Tue, 2020-06-23 at 11:37 +0100, Quentin Monnet wrote:
> Checkpatch reports warnings when some specific structs are not declared
> as const in the code. The list of structs to consider was initially
> defined in the checkpatch.pl script itself, but it was later moved to an
> external file (scripts/const_structs.checkpatch), in commit bf1fa1dae68e
> ("checkpatch: externalize the structs that should be const"). This
> introduced two minor issues:
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -770,7 +770,7 @@ sub read_words {
>  				next;
>  			}
>  
> -			$$wordsRef .= '|' if ($$wordsRef ne "");
> +			$$wordsRef .= '|' if (defined($$wordsRef) && $$wordsRef ne "");

perl is a weird language and the $$wordsRef ne "" test
isn't required as the append will work even if the
thing being appended to isn't defined.

You can read the perlsyn docs
http://perldoc.perl.org/perlsyn.html
or
https://stackoverflow.com/questions/2166575/when-is-it-ok-to-use-an-undefined-variable-in-perl-with-warnings-enabled

so perhaps remove the test and improve the additional
$typedefsfile use too
---
 scripts/checkpatch.pl | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b06093777fd8..9210267a7771 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -62,7 +62,7 @@ my $spelling_file = "$D/spelling.txt";
 my $codespell = 0;
 my $codespellfile = "/usr/share/codespell/dictionary.txt";
 my $conststructsfile = "$D/const_structs.checkpatch";
-my $typedefsfile = "";
+my $typedefsfile;
 my $color = "auto";
 my $allow_c99_comments = 1; # Can be overridden by --ignore C99_COMMENT_TOLERANCE
 # git output parsing needs US English output, so first set backtick child process LANGUAGE
@@ -770,7 +770,7 @@ sub read_words {
 				next;
 			}
 
-			$$wordsRef .= '|' if ($$wordsRef ne "");
+			$$wordsRef .= '|' if (defined($$wordsRef));
 			$$wordsRef .= $line;
 		}
 		close($file);
@@ -780,16 +780,18 @@ sub read_words {
 	return 0;
 }
 
-my $const_structs = "";
-read_words(\$const_structs, $conststructsfile)
-    or warn "No structs that should be const will be found - file '$conststructsfile': $!\n";
+my $const_structs;
+if (show_type("CONST_STRUCT")) {
+	read_words(\$const_structs, $conststructsfile)
+	    or warn "No structs that should be const will be found - file '$conststructsfile': $!\n";
 
-my $typeOtherTypedefs = "";
-if (length($typedefsfile)) {
+
+if (defined($typedefsfile)) {
+	my $typeOtherTypedefs;
 	read_words(\$typeOtherTypedefs, $typedefsfile)
 	    or warn "No additional types will be considered - file '$typedefsfile': $!\n";
+	$typeTypedefs .= '|' . $typeOtherTypedefs if (defined $typeOtherTypedefs);
 }
-$typeTypedefs .= '|' . $typeOtherTypedefs if ($typeOtherTypedefs ne "");
 
 sub build_types {
 	my $mods = "(?x:  \n" . join("|\n  ", (@modifierList, @modifierListFile)) . "\n)";
@@ -6660,7 +6662,8 @@ sub process {
 
 # check for various structs that are normally const (ops, kgdb, device_tree)
 # and avoid what seem like struct definitions 'struct foo {'
-		if ($line !~ /\bconst\b/ &&
+		if (defined($const_structs) &&
+		    $line !~ /\bconst\b/ &&
 		    $line =~ /\bstruct\s+($const_structs)\b(?!\s*\{)/) {
 			WARN("CONST_STRUCT",
 			     "struct $1 should normally be const\n" . $herecurr);


