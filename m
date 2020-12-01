Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873E32CAA6D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 19:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404260AbgLASCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 13:02:41 -0500
Received: from smtprelay0046.hostedemail.com ([216.40.44.46]:36228 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404253AbgLASCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 13:02:41 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 3D9F7837F24D;
        Tue,  1 Dec 2020 18:02:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 90,9,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3653:3865:3866:3867:3868:3870:3871:4321:5007:6119:7514:7875:8531:9545:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12740:12895:13069:13095:13311:13357:13439:13894:14093:14097:14181:14659:14721:21080:21221:21433:21451:21627:21740:21741:30025:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:6,LUA_SUMMARY:none
X-HE-Tag: lace58_1c0f780273ac
X-Filterd-Recvd-Size: 2679
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Tue,  1 Dec 2020 18:01:59 +0000 (UTC)
Message-ID: <2d507d3042a97613078554b1b5f1169ab8c41b42.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: fix TYPO_SPELLING check for words with
 apostrophe
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        Peilin Ye <yepeilin.cs@gmail.com>
Date:   Tue, 01 Dec 2020 10:01:57 -0800
In-Reply-To: <20201201072320.44544-1-dwaipayanray1@gmail.com>
References: <20201201072320.44544-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-12-01 at 12:53 +0530, Dwaipayan Ray wrote:
> checkpatch reports a false TYPO_SPELLING warning for some words
> containing an apostrophe when run with --codespell option.
> 
> A false positive is "doesn't". Occurrence of the word causes
> checkpatch to emit the following warning:
> 
> "WARNING: 'doesn'' may be misspelled - perhaps 'doesn't'?"
> 
> Modify the regex pattern to be more in line with the codespell
> default word matching regex. This fixes the word capture and
> avoids the false warning.
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Reported-by: Peilin Ye <yepeilin.cs@gmail.com>
> Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
> ---
> Changes in v2:
> - Use the default codespell word regex.
> - Modify commit message to specify --codespell usage
> 
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3106,7 +3106,7 @@ sub process {
>  # Check for various typo / spelling mistakes
>  		if (defined($misspellings) &&
>  		    ($in_commit_log || $line =~ /^(?:\+|Subject:)/i)) {
> -			while ($rawline =~ /(?:^|[^a-z@])($misspellings)(?:\b|$|[^a-z@])/gi) {
> +			while ($rawline =~ /(?:^|[^\w\-'`])($misspellings)(?:[^\w\-'`]|$)/gi) {

This regex seems to work well, thanks.

>  				my $typo = $1;

A trivial improvement might be to highlight the location of the
misspelled word with a caret using

				my $blank = copy_spacing($rawline);
				my $ptr = substr($blank, 0, $-[0] + 1) . "^";
				my $hereptr = "$hereline$ptr\n";

>  				my $typo_fix = $spelling_fix{lc($typo)};
>  				$typo_fix = ucfirst($typo_fix) if ($typo =~ /^[A-Z]/);

and using $hereptr and not $hereline when emitting the message.


