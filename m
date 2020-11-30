Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F6B2C8AE4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387518AbgK3RZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:25:20 -0500
Received: from smtprelay0248.hostedemail.com ([216.40.44.248]:44760 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387510AbgK3RZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:25:19 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 8B5CF8384367;
        Mon, 30 Nov 2020 17:24:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:1801:2197:2199:2393:2553:2559:2562:2828:2911:3138:3139:3140:3141:3142:3355:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:4184:4250:4321:4425:4605:5007:7875:7903:7974:8531:9545:10004:10400:11026:11232:11658:11783:11914:12043:12296:12297:12555:12679:12740:12895:13019:13180:13229:13439:13894:14093:14097:14180:14181:14659:14721:21060:21080:21221:21433:21451:21627:21740:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: skirt20_52007ab273a3
X-Filterd-Recvd-Size: 4104
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Mon, 30 Nov 2020 17:24:37 +0000 (UTC)
Message-ID: <070109a56817288562a91dfeec74359eb948234e.camel@perches.com>
Subject: Re: [PATCH] checkpatch: fix TYPO_SPELLING check for words with
 apostrophe
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Peilin Ye <yepeilin.cs@gmail.com>
Date:   Mon, 30 Nov 2020 09:24:36 -0800
In-Reply-To: <CABJPP5BLjbx3FbvB3nAOiHfkRLUo7s0n-vboE+AXJqrZXseUNQ@mail.gmail.com>
References: <20201130144515.8320-1-dwaipayanray1@gmail.com>
         <c8eeab847fc09368ce270ea3e06ea0bbbd7d1b7f.camel@perches.com>
         <CABJPP5BLjbx3FbvB3nAOiHfkRLUo7s0n-vboE+AXJqrZXseUNQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-11-30 at 22:33 +0530, Dwaipayan Ray wrote:
> On Mon, Nov 30, 2020 at 10:13 PM Joe Perches <joe@perches.com> wrote:
> > 
> > On Mon, 2020-11-30 at 20:15 +0530, Dwaipayan Ray wrote:
> > > checkpatch reports a false TYPO_SPELLING warning for some words
> > > containing an apostrophe.
> > > 
> > > A false positive is "doesn't". Occurrence of the word causes
> > > checkpatch to emit the following warning:
> > > 
> > > "WARNING: 'doesn'' may be misspelled - perhaps 'doesn't'?"
> > > 
> > > Check the word boundary for such cases so that words like
> > > "doesn't", "zig-zag", etc. aren't misinterpreted due to wrong
> > > splitting of the word by the \b regex metacharacter.
> > []
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > []
> > > @@ -3106,7 +3106,7 @@ sub process {
> > >  # Check for various typo / spelling mistakes
> > >               if (defined($misspellings) &&
> > >                   ($in_commit_log || $line =~ /^(?:\+|Subject:)/i)) {
> > > -                     while ($rawline =~ /(?:^|[^a-z@])($misspellings)(?:\b|$|[^a-z@])/gi) {
> > > +                     while ($rawline =~ /(?:^|[^a-z@])($misspellings)(?:\b(?![^\w]?[a-z@]+)|$|[^a-z@])/gi) {
> > 
> > Wouldn't it be simpler to change the existing [^a-z@] blocks to [^a-z@'-] ?
> > 
> Hi,
> I tried it and it doesn't seem to work. Probably because the first
> group already causes the
> word to be captured. In this case `doesn'` was already captured
> because of the \b group.
> 
> Is the first group modification perhaps okay? Or would you suggest
> something else?

Seems to work for me:

$ git diff --stat -p scripts/checkpatch.pl
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7dc094445d83..a6d4d524ae66 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3106,7 +3106,7 @@ sub process {
 # Check for various typo / spelling mistakes
 		if (defined($misspellings) &&
 		    ($in_commit_log || $line =~ /^(?:\+|Subject:)/i)) {
-			while ($rawline =~ /(?:^|[^a-z@])($misspellings)(?:\b|$|[^a-z@])/gi) {
+			while ($rawline =~ /(?:^|[^a-z@'-])($misspellings)(?:\b|$|[^a-z@'-])/gi) {
 				my $typo = $1;
 				my $typo_fix = $spelling_fix{lc($typo)};
 				$typo_fix = ucfirst($typo_fix) if ($typo =~ /^[A-Z]/);

$ cat t_spell.c
// SPDX-License-Identifier: GPL-2.0-only
void foo(void)
{
	//misspelled arne't word
}

$ ./scripts/checkpatch.pl -f --strict t_spell.c
CHECK: 'arne't' may be misspelled - perhaps 'aren't'?
#4: FILE: t_spell.c:4:
+	//misspelled arne't word

total: 0 errors, 0 warnings, 1 checks, 5 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

t_spell.c has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



