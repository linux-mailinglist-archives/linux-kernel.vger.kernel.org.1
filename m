Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8788E1EDA09
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 02:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgFDAjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 20:39:51 -0400
Received: from smtprelay0024.hostedemail.com ([216.40.44.24]:51102 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727793AbgFDAjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 20:39:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 14EBB180A7FDD;
        Thu,  4 Jun 2020 00:39:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:2197:2198:2199:2200:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3867:3868:3870:3872:4321:4605:5007:6119:7875:7903:10004:10400:10848:11026:11232:11657:11658:11914:12043:12291:12295:12297:12438:12555:12663:12679:12683:12740:12760:12895:13439:14180:14181:14659:14721:21080:21221:21222:21324:21451:21627:21990:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: gate29_05050f526d93
X-Filterd-Recvd-Size: 4251
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Thu,  4 Jun 2020 00:39:48 +0000 (UTC)
Message-ID: <a3c22bbd360d2148bf097d3c55a89ea13e07b719.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Avoid missing typo suggestions
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Wed, 03 Jun 2020 17:39:47 -0700
In-Reply-To: <202006031618.DA25142@keescook>
References: <202006031618.DA25142@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-06-03 at 16:19 -0700, Kees Cook wrote:
> My codespell dictionary has a lot of capitalized words. For example:
> 
> MSDOS->MS-DOS
> 
> Since checkpatch uses case-insensitive matching, I get an undefined
> variable warning and then empty suggestions for things like this:
> 
> Use of uninitialized value $typo_fix in concatenation (.) or string at ./scripts/checkpatch.pl line 2958.
> 
> WARNING: 'msdos' may be misspelled - perhaps ''?
> +       struct msdos_dir_entry *de;
> 
> This fixes the matcher to avoid the warning, but it's still a rather
> silly suggestion:
> 
> WARNING: 'msdos' may be misspelled - perhaps 'MS-DOS'?
> +       struct msdos_dir_entry *de;
> 
> So I'm not really sure what to do with this ... filter out bad
> suggestions instead?

Hey Kees.

Maybe this?

btw: My codespell dictionary file moved to
/usr/lib/python3/dist-packages/codespell_lib/data/dictionary.txt

and I had to use --codespell --codespellfile=(above) so
maybe there should be multiple lookups for this file
like the array below.

Are there other standard codespell dictionary locations?
---
 scripts/checkpatch.pl | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 5f00df2c3f59..52aa0dd53d80 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -59,7 +59,7 @@ my $minimum_perl_version = 5.10.0;
 my $min_conf_desc_length = 4;
 my $spelling_file = "$D/spelling.txt";
 my $codespell = 0;
-my $codespellfile = "/usr/share/codespell/dictionary.txt";
+my $codespellfile;
 my $conststructsfile = "$D/const_structs.checkpatch";
 my $typedefsfile = "";
 my $color = "auto";
@@ -716,7 +716,20 @@ if (open(my $spelling, '<', $spelling_file)) {
 }
 
 if ($codespell) {
-	if (open(my $spelling, '<', $codespellfile)) {
+	if (!defined($codespellfile)) {
+		my @csfiles = ("/usr/share/codespell/dictionary.txt",
+			       "/usr/lib/python3/dist-packages/codespell_lib/data/dictionary.txt");
+		foreach my $csfile (@csfiles) {
+			if (-f $csfile) {
+				$codespellfile = $csfile;
+				last;
+			}
+		}
+	}
+
+	if (!defined($codespellfile)) {
+		warn "No codespell typos will be found - codespell dictionary not found\n";
+	} elsif (open(my $spelling, '<', $codespellfile)) {
 		while (<$spelling>) {
 			my $line = $_;
 
@@ -2963,13 +2976,21 @@ sub process {
 			while ($rawline =~ /(?:^|[^a-z@])($misspellings)(?:\b|$|[^a-z@])/gi) {
 				my $typo = $1;
 				my $typo_fix = $spelling_fix{lc($typo)};
-				$typo_fix = ucfirst($typo_fix) if ($typo =~ /^[A-Z]/);
-				$typo_fix = uc($typo_fix) if ($typo =~ /^[A-Z]+$/);
+				$typo_fix = $spelling_fix{$typo} if (!defined($typo_fix));
+				$typo_fix = $spelling_fix{uc($typo)} if (!defined($typo_fix));
+				$typo_fix = 'unknown typo fix' if (!defined($typo_fix));
+				if ($typo =~ /^[A-Z]+$/) {
+					$typo_fix = uc($typo_fix);
+				} elsif ($typo =~ /^[A-Z]/) {
+					$typo_fix = ucfirst($typo_fix);
+				}
+
 				my $msg_level = \&WARN;
 				$msg_level = \&CHK if ($file);
 				if (&{$msg_level}("TYPO_SPELLING",
 						  "'$typo' may be misspelled - perhaps '$typo_fix'?\n" . $herecurr) &&
-				    $fix) {
+				    $fix &&
+				    $typo_fix ne 'unknown typo fix') {
 					$fixed[$fixlinenr] =~ s/(^|[^A-Za-z@])($typo)($|[^A-Za-z@])/$1$typo_fix$3/;
 				}
 			}

