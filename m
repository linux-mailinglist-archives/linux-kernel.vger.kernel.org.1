Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE462918C0
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 20:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgJRSES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 14:04:18 -0400
Received: from smtprelay0236.hostedemail.com ([216.40.44.236]:32862 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725776AbgJRSER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 14:04:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 3CE92180A7FD6;
        Sun, 18 Oct 2020 18:04:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2525:2553:2560:2563:2682:2685:2828:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3355:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:7514:7903:7974:8603:9025:10004:10400:10848:11026:11232:11658:11914:12043:12297:12438:12555:12740:12760:12895:12986:13095:13439:14093:14097:14181:14659:14721:21080:21221:21325:21433:21451:21627:21811:21939:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: face24_0c0baef27230
X-Filterd-Recvd-Size: 3782
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Sun, 18 Oct 2020 18:04:15 +0000 (UTC)
Message-ID: <f5060c275bbe1cc52cab4e4625a0828c0a8a5676.camel@perches.com>
Subject: Re: [PATCH v5] checkpatch: add new exception to repeated word check
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Date:   Sun, 18 Oct 2020 11:04:14 -0700
In-Reply-To: <20201017162732.152351-1-dwaipayanray1@gmail.com>
References: <20201017162732.152351-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-10-17 at 21:57 +0530, Dwaipayan Ray wrote:
> Recently, commit 4f6ad8aa1eac ("checkpatch: move repeated word test")
> moved the repeated word test to check for more file types. But after
> this, if checkpatch.pl is run on MAINTAINERS, it generates several
> new warnings of the type:

Andrew, can you pick this up please?

Acked-by: Joe Perches <joe@perches.com>

> WARNING: Possible repeated word: 'git'
> 
> For example:
> WARNING: Possible repeated word: 'git'
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git
> 
> So, the pattern "git git://..." is a false positive in this case.
> 
> There are several other combinations which may produce a wrong
> warning message, such as "@size size", ":Begin begin", etc.
> 
> Extend repeated word check to compare the characters before and
> after the word matches.
> 
> If there is a non whitespace character before the first word or a
> non whitespace character excluding punctuation characters after
> the second word, then the check is skipped and the warning is avoided.
> 
> Also add case insensitive word matching to the repeated word check.
> 
> Link: https://lore.kernel.org/linux-kernel-mentees/81b6a0bb2c7b9256361573f7a13201ebcd4876f1.camel@perches.com/
> Suggested-by: Joe Perches <joe@perches.com>
> Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
> ---
>  scripts/checkpatch.pl | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index f1a4e61917eb..ec380626bebc 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3052,19 +3052,30 @@ sub process {
>  
>  # check for repeated words separated by a single space
>  		if ($rawline =~ /^\+/ || $in_commit_log) {
> +			pos($rawline) = 1 if (!$in_commit_log);
>  			while ($rawline =~ /\b($word_pattern) (?=($word_pattern))/g) {
>  
>  				my $first = $1;
>  				my $second = $2;
> -
> +				my $start_pos = $-[1];
> +				my $end_pos = $+[2];
>  				if ($first =~ /(?:struct|union|enum)/) {
>  					pos($rawline) += length($first) + length($second) + 1;
>  					next;
>  				}
>  
> -				next if ($first ne $second);
> +				next if (lc($first) ne lc($second));
>  				next if ($first eq 'long');
>  
> +				# check for character before and after the word matches
> +				my $start_char = '';
> +				my $end_char = '';
> +				$start_char = substr($rawline, $start_pos - 1, 1) if ($start_pos > ($in_commit_log ? 0 : 1));
> +				$end_char = substr($rawline, $end_pos, 1) if ($end_pos < length($rawline));
> +
> +				next if ($start_char =~ /^\S$/);
> +				next if (index(" \t.,;?!", $end_char) == -1);
> +
>  				if (WARN("REPEATED_WORD",
>  					 "Possible repeated word: '$first'\n" . $herecurr) &&
>  				    $fix) {

