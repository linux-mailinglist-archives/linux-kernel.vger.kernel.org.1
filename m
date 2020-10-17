Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03172912C5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 17:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437591AbgJQPyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 11:54:38 -0400
Received: from smtprelay0198.hostedemail.com ([216.40.44.198]:33272 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2436623AbgJQPyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 11:54:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 47FCB18224504;
        Sat, 17 Oct 2020 15:54:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2553:2559:2562:2691:2828:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3867:3868:3870:3871:3872:4321:5007:7903:8603:9010:10004:10400:10848:11026:11232:11658:11914:12043:12297:12679:12740:12760:12895:13095:13439:14093:14097:14181:14659:14721:21080:21221:21433:21451:21627:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: nest32_481265327227
X-Filterd-Recvd-Size: 3377
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Sat, 17 Oct 2020 15:54:35 +0000 (UTC)
Message-ID: <d2254db39f798b408bdd16237c86dea1617bcfac.camel@perches.com>
Subject: Re: [PATCH v4] checkpatch: add new exception to repeated word check
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Date:   Sat, 17 Oct 2020 08:54:34 -0700
In-Reply-To: <20201017075131.47566-1-dwaipayanray1@gmail.com>
References: <20201017075131.47566-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-10-17 at 13:21 +0530, Dwaipayan Ray wrote:
> Recently, commit 4f6ad8aa1eac ("checkpatch: move repeated word test")
> moved the repeated word test to check for more file types. But after
> this, if checkpatch.pl is run on MAINTAINERS, it generates several
> new warnings of the type:
> 
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
> after the word matches. If the preceding or succeeding character
> belongs to the exception list, the warning is avoided.

Not true.

This excludes any non-space character before the first word
and excludes space or punctuation after the second word.

This also adds case insensitive word matching.

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
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

case-insensitive matching

>  				next if ($first eq 'long');
>  
> +				# check for character before and after the word matches
> +				my $start_char = '';
> +				my $end_char = '';
> +				$start_char = substr($rawline, $start_pos - 1, 1) if ($start_pos > ($in_commit_log? 0 : 1));
> +				$end_char = substr($rawline, $end_pos, 1) if ($end_pos < length($rawline));
> +
> +				next if ($start_char =~ /^\S$/);

non-space

> +				next if ($end_char !~ /^[\.\,\;\?\!\s]?$/);

space or punctuation.

trivia:

I believe using index would be ~50% faster than !~ here
Perhaps more readable too.

				next if (index(" \t.,;?!", $end_char) >= 0);

> +
>  				if (WARN("REPEATED_WORD",
>  					 "Possible repeated word: '$first'\n" . $herecurr) &&
>  				    $fix) {

