Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA912CAC6F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 20:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404332AbgLATdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 14:33:35 -0500
Received: from smtprelay0237.hostedemail.com ([216.40.44.237]:45346 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726148AbgLATdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:33:35 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 4FF3D18028E7E;
        Tue,  1 Dec 2020 19:32:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3867:3868:3870:3871:4321:4362:5007:6119:7514:7875:7903:8531:9545:10004:10400:10848:11026:11232:11658:11914:12043:12295:12296:12297:12555:12740:12895:13095:13439:13894:14093:14097:14181:14659:14721:21080:21221:21433:21451:21611:21627:30025:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: joke83_280d582273ad
X-Filterd-Recvd-Size: 3300
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Tue,  1 Dec 2020 19:32:53 +0000 (UTC)
Message-ID: <7f29e46d73c0b12ce53e659f0bcd3ec194522f2e.camel@perches.com>
Subject: Re: [PATCH v3] checkpatch: fix TYPO_SPELLING check for words with
 apostrophe
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        Peilin Ye <yepeilin.cs@gmail.com>
Date:   Tue, 01 Dec 2020 11:32:51 -0800
In-Reply-To: <20201201190729.169733-1-dwaipayanray1@gmail.com>
References: <20201201190729.169733-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-12-02 at 00:37 +0530, Dwaipayan Ray wrote:
> checkpatch reports a false TYPO_SPELLING warning for some words
> containing an apostrophe when run with --codespell option.

Thanks.
Acked-by: Joe Perches <joe@perches.com>

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
> In addition, highlight the misspelled word location by adding a
> caret below the word.
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Reported-by: Peilin Ye <yepeilin.cs@gmail.com>
> Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
> ---
> Changes in v3:
> - Highlight misspelled word location using a caret
> 
> Changes in v2:
> - Use the default codespell word regex.
> - Modify commit message to specify --codespell usage
> 
>  scripts/checkpatch.pl | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 3c86ea737e9c..e8c1ed0b1fad 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3106,15 +3106,18 @@ sub process {
>  # Check for various typo / spelling mistakes
>  		if (defined($misspellings) &&
>  		    ($in_commit_log || $line =~ /^(?:\+|Subject:)/i)) {
> -			while ($rawline =~ /(?:^|[^a-z@])($misspellings)(?:\b|$|[^a-z@])/gi) {
> +			while ($rawline =~ /(?:^|[^\w\-'`])($misspellings)(?:[^\w\-'`]|$)/gi) {
>  				my $typo = $1;
> +				my $blank = copy_spacing($rawline);
> +				my $ptr = substr($blank, 0, $-[1]) . "^";
> +				my $hereptr = "$hereline$ptr\n";
>  				my $typo_fix = $spelling_fix{lc($typo)};
>  				$typo_fix = ucfirst($typo_fix) if ($typo =~ /^[A-Z]/);
>  				$typo_fix = uc($typo_fix) if ($typo =~ /^[A-Z]+$/);
>  				my $msg_level = \&WARN;
>  				$msg_level = \&CHK if ($file);
>  				if (&{$msg_level}("TYPO_SPELLING",
> -						  "'$typo' may be misspelled - perhaps '$typo_fix'?\n" . $herecurr) &&
> +						  "'$typo' may be misspelled - perhaps '$typo_fix'?\n" . $hereptr) &&
>  				    $fix) {
>  					$fixed[$fixlinenr] =~ s/(^|[^A-Za-z@])($typo)($|[^A-Za-z@])/$1$typo_fix$3/;
>  				}


