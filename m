Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071792C8BF2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387860AbgK3SB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 13:01:56 -0500
Received: from smtprelay0169.hostedemail.com ([216.40.44.169]:57346 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387817AbgK3SB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:01:56 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 0A3B6837F27B;
        Mon, 30 Nov 2020 18:01:15 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2553:2559:2562:2828:2911:3138:3139:3140:3141:3142:3353:3622:3653:3865:3866:3867:3870:3871:3872:3873:4250:4321:4425:4605:5007:6119:6691:7875:7974:8531:9545:10004:10400:10848:11026:11232:11658:11914:12043:12297:12555:12679:12740:12760:12895:12986:13069:13180:13229:13311:13357:13439:14096:14097:14181:14659:14721:21080:21221:21433:21451:21611:21627:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: fan15_5b14f8f273a3
X-Filterd-Recvd-Size: 3081
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Mon, 30 Nov 2020 18:01:13 +0000 (UTC)
Message-ID: <40b6e1fa9fc638a7e755f7e91f401b6019fee2fa.camel@perches.com>
Subject: Re: [PATCH] checkpatch: fix TYPO_SPELLING check for words with
 apostrophe
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Peilin Ye <yepeilin.cs@gmail.com>
Date:   Mon, 30 Nov 2020 10:01:12 -0800
In-Reply-To: <CABJPP5BxO20-YzbTZij4gZGm4R63iG_n2kH58pSz5mgyXXwVBw@mail.gmail.com>
References: <20201130144515.8320-1-dwaipayanray1@gmail.com>
         <c8eeab847fc09368ce270ea3e06ea0bbbd7d1b7f.camel@perches.com>
         <CABJPP5BLjbx3FbvB3nAOiHfkRLUo7s0n-vboE+AXJqrZXseUNQ@mail.gmail.com>
         <070109a56817288562a91dfeec74359eb948234e.camel@perches.com>
         <CABJPP5BxO20-YzbTZij4gZGm4R63iG_n2kH58pSz5mgyXXwVBw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-11-30 at 23:02 +0530, Dwaipayan Ray wrote:
> Sorry I think i explained wrong. For words like "doesn't", it still
> has the same problem.

I think you explained it wrong when you didn't mention this is
_only_ a problem when using --codespell.

Likely it'd be better to use "(?:^|\s)($misspellings)(?=\s|$)"

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7dc094445d83..b1783f02f745 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3106,7 +3106,7 @@ sub process {
 # Check for various typo / spelling mistakes
 		if (defined($misspellings) &&
 		    ($in_commit_log || $line =~ /^(?:\+|Subject:)/i)) {
-			while ($rawline =~ /(?:^|[^a-z@])($misspellings)(?:\b|$|[^a-z@])/gi) {
+			while ($rawline =~ /(?:^|\s)($misspellings)(?=\s|$)/gi) {
 				my $typo = $1;
 				my $typo_fix = $spelling_fix{lc($typo)};
 				$typo_fix = ucfirst($typo_fix) if ($typo =~ /^[A-Z]/);

$ cat t_spell.c
// SPDX-License-Identifier: GPL-2.0-only
void foo(void)
{
	//misspelled doesn' doesn't arne't word
}

$ ./scripts/checkpatch.pl -f --strict t_spell.c --codespell --codespellfile /usr/lib/python3/dist-packages/codespell_lib/data/dictionary.txt
CHECK: 'doesn'' may be misspelled - perhaps 'doesn't'?
#4: FILE: t_spell.c:4:
+	//misspelled doesn' doesn't arne't word

CHECK: 'arne't' may be misspelled - perhaps 'aren't'?
#4: FILE: t_spell.c:4:
+	//misspelled doesn' doesn't arne't word

total: 0 errors, 0 warnings, 2 checks, 5 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

t_spell.c has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


