Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806082B1DEB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgKMPAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:00:55 -0500
Received: from smtprelay0165.hostedemail.com ([216.40.44.165]:47478 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726160AbgKMPAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:00:55 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 2E6B412F8;
        Fri, 13 Nov 2020 15:00:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2903:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3867:3868:3870:3871:3873:3874:4321:5007:7514:7875:10004:10400:10848:11232:11658:11914:12043:12295:12297:12555:12679:12740:12895:13069:13311:13357:13439:13894:14181:14659:14721:14777:21080:21433:21451:21627:21819:30022:30029:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:323,LUA_SUMMARY:none
X-HE-Tag: wind95_1816c962730f
X-Filterd-Recvd-Size: 2748
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Fri, 13 Nov 2020 15:00:52 +0000 (UTC)
Message-ID: <3a0455c93dfd6749cf2050dd973c5bee1cc9f237.camel@perches.com>
Subject: Re: [PATCH] checkpatch: fix typo and remove duplicate word
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Date:   Fri, 13 Nov 2020 07:00:50 -0800
In-Reply-To: <20201113135739.46776-1-dwaipayanray1@gmail.com>
References: <20201113135739.46776-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-11-13 at 19:27 +0530, Dwaipayan Ray wrote:
> Delete repeated word in scripts/checkpatch.pl:
> "are are" -> "are"
> 
> Fix typos:
> "commments" -> "comments"
> "falsly" -> "falsely"
> 
> Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
> ---

style: this should have subject prefix:

"[PATCH V2] checkpatch: Fix spelling errors and remove repeated word"

And here below the --- line you should add a V2 changelog like:

o Add correction for falsly

Other than that, you might consider sending a V3 just to get
used the proper patch resubmission form but thanks.

>  scripts/checkpatch.pl | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 2749f32dffe9..041b82f6669e 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2841,7 +2841,7 @@ sub process {
>  
> 
>  
> 
>  				# stable@vger.kernel.org or stable@kernel.org shouldn't
> -				# have an email name. In addition commments should strictly
> +				# have an email name. In addition comments should strictly
>  				# begin with a #
>  				if ($email =~ /^.*stable\@(?:vger\.)?kernel\.org/i) {
>  					if (($comment ne "" && $comment !~ /^#.+/) ||
> @@ -5000,7 +5000,7 @@ sub process {
>  ## 		    $line !~ /^.\s*$Type\s+$Ident(?:\s*=[^,{]*)?\s*,\s*$Type\s*$Ident.*/) {
>  ##
>  ## 			# Remove any bracketed sections to ensure we do not
> -## 			# falsly report the parameters of functions.
> +## 			# falsely report the parameters of functions.
>  ## 			my $ln = $line;
>  ## 			while ($ln =~ s/\([^\(\)]*\)//g) {
>  ## 			}
> @@ -7109,7 +7109,7 @@ sub process {
>  		exit(0);
>  	}
>  
> 
> -	# This is not a patch, and we are are in 'no-patch' mode so
> +	# This is not a patch, and we are in 'no-patch' mode so
>  	# just keep quiet.
>  	if (!$chk_patch && !$is_patch) {
>  		exit(0);


