Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E738F291084
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 09:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437464AbgJQH23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 03:28:29 -0400
Received: from smtprelay0090.hostedemail.com ([216.40.44.90]:57434 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2436550AbgJQH23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 03:28:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 55DD5100E7B40;
        Sat, 17 Oct 2020 07:28:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 93,11,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:305:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3653:3865:3866:3867:3868:3870:3871:3872:3874:4184:4321:5007:6119:7903:9592:10010:10400:11026:11232:11658:11914:12297:12555:12679:12740:12760:12895:13069:13095:13161:13229:13311:13357:13439:13972:14093:14097:14180:14181:14659:14721:21060:21080:21221:21433:21451:21627:21740:21741:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:1:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: dress26_2a0c37727223
X-Filterd-Recvd-Size: 2977
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Sat, 17 Oct 2020 07:28:27 +0000 (UTC)
Message-ID: <c2f40543564323a5dc3b632df8f1770d61b86633.camel@perches.com>
Subject: Re: [PATCH v3] checkpatch: add new exception to repeated word check
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Sat, 17 Oct 2020 00:28:25 -0700
In-Reply-To: <CABJPP5CBh2TDwo9Z1hoaLPjk=d00N0r4VkLVdwAuMbWPyNbDYA@mail.gmail.com>
References: <20201017052243.17095-1-dwaipayanray1@gmail.com>
         <fc47f1e6babab1044c9dece4b30200e239438931.camel@perches.com>
         <CABJPP5CBh2TDwo9Z1hoaLPjk=d00N0r4VkLVdwAuMbWPyNbDYA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-10-17 at 11:32 +0530, Dwaipayan Ray wrote:
> > Why include a + character here?
> > 
> Hi,
> I tried it without + first, but then lines like
> "The the repeated word."
> didn't register a warning.
> 
> I think checkpatch adds a + to the line when used on
> files. Am not sure but my $rawline was:
> +The the repeated word.

The + is the first character of an added line in a
patch.

That's different from lines in a commit message so
there needs to be an additional mechanism to strip
the leading + when not !$in_commit_log.

Add:
	pos($rawline) = 1 if (!$in_commit_log);

and test the start position too

---
 scripts/checkpatch.pl | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index fab38b493cef..99563b3d5a3e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3050,19 +3050,28 @@ sub process {
 
 # check for repeated words separated by a single space
 		if ($rawline =~ /^\+/ || $in_commit_log) {
+			pos($rawline) = 1 if (!$in_commit_log);
 			while ($rawline =~ /\b($word_pattern) (?=($word_pattern))/g) {
-
 				my $first = $1;
 				my $second = $2;
+				my $start_pos = $-[1];
+				my $end_pos = $+[2];
 
 				if ($first =~ /(?:struct|union|enum)/) {
 					pos($rawline) += length($first) + length($second) + 1;
 					next;
 				}
 
-				next if ($first ne $second);
+				next if (lc($first) ne lc($second));
 				next if ($first eq 'long');
 
+				my $start_char = "";
+				my $end_char = "";
+				$start_char = substr($rawline, $start_pos - 1, 1) if ($start_pos > ($in_commit_log ? 0 : 1));
+				$end_char = substr($rawline, $end_pos, 1) if (length($rawline) > $end_pos);
+				next if ($start_char =~ /^\S$/);
+				next if ($end_char !~ /^[\.\,\s]?$/);
+
 				if (WARN("REPEATED_WORD",
 					 "Possible repeated word: '$first'\n" . $herecurr) &&
 				    $fix) {


