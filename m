Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B9B2EA8F1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 11:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbhAEKiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 05:38:23 -0500
Received: from smtprelay0027.hostedemail.com ([216.40.44.27]:32962 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729244AbhAEKiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 05:38:22 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 2516D182CF66C;
        Tue,  5 Jan 2021 10:37:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:1801:2393:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3653:3865:3870:3871:3874:4321:4362:4605:4823:5007:7514:7652:7903:10004:10400:10848:11026:11232:11473:11658:11914:12043:12297:12438:12555:12740:12895:12986:13439:13894:14181:14659:14721:21080:21451:21627:21990:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: watch31_3a0e7d1274d8
X-Filterd-Recvd-Size: 3854
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Tue,  5 Jan 2021 10:37:38 +0000 (UTC)
Message-ID: <834383f004e107752d21ca8331add97808b3719d.camel@perches.com>
Subject: Re: [PATCH] checkpatch: trivial style fixes
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Date:   Tue, 05 Jan 2021 02:37:37 -0800
In-Reply-To: <20210105103044.40282-1-dwaipayanray1@gmail.com>
References: <20210105103044.40282-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-01-05 at 16:00 +0530, Dwaipayan Ray wrote:
> Indentations should use tabs wherever possible.
> Replace spaces by tabs for indents.

Thanks.

Acked-by: Joe Perches <joe@perches.com>

> 
> Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
> ---
>  scripts/checkpatch.pl | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index e6857bdfcb2d..7a323ca8a177 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2974,7 +2974,7 @@ sub process {
>  				}
>  				if (!defined $lines[$linenr]) {
>  					WARN("BAD_SIGN_OFF",
> -                                             "Co-developed-by: must be immediately followed by Signed-off-by:\n" . "$here\n" . $rawline);
> +					     "Co-developed-by: must be immediately followed by Signed-off-by:\n" . "$here\n" . $rawline);
>  				} elsif ($rawlines[$linenr] !~ /^\s*signed-off-by:\s*(.*)/i) {
>  					WARN("BAD_SIGN_OFF",
>  					     "Co-developed-by: must be immediately followed by Signed-off-by:\n" . "$here\n" . $rawline . "\n" .$rawlines[$linenr]);
> @@ -2997,8 +2997,8 @@ sub process {
>  			if (ERROR("GERRIT_CHANGE_ID",
>  			          "Remove Gerrit Change-Id's before submitting upstream\n" . $herecurr) &&
>  			    $fix) {
> -                                fix_delete_line($fixlinenr, $rawline);
> -                        }
> +				fix_delete_line($fixlinenr, $rawline);
> +			}
>  		}
>  
> 
>  # Check if the commit log is in a possible stack dump
> @@ -3240,10 +3240,10 @@ sub process {
>  				next if ($start_char =~ /^\S$/);
>  				next if (index(" \t.,;?!", $end_char) == -1);
>  
> 
> -                                # avoid repeating hex occurrences like 'ff ff fe 09 ...'
> -                                if ($first =~ /\b[0-9a-f]{2,}\b/i) {
> -                                        next if (!exists($allow_repeated_words{lc($first)}));
> -                                }
> +				# avoid repeating hex occurrences like 'ff ff fe 09 ...'
> +				if ($first =~ /\b[0-9a-f]{2,}\b/i) {
> +					next if (!exists($allow_repeated_words{lc($first)}));
> +				}
>  
> 
>  				if (WARN("REPEATED_WORD",
>  					 "Possible repeated word: '$first'\n" . $herecurr) &&
> @@ -4432,7 +4432,7 @@ sub process {
>  			WARN("STATIC_CONST_CHAR_ARRAY",
>  			     "char * array declaration might be better as static const\n" .
>  				$herecurr);
> -               }
> +		}
>  
> 
>  # check for sizeof(foo)/sizeof(foo[0]) that could be ARRAY_SIZE(foo)
>  		if ($line =~ m@\bsizeof\s*\(\s*($Lval)\s*\)@) {
> @@ -5285,7 +5285,7 @@ sub process {
>  		    $lines[$linenr - 3] !~ /^[ +]\s*$Ident\s*:/) {
>  			WARN("RETURN_VOID",
>  			     "void function return statements are not generally useful\n" . $hereprev);
> -               }
> +		}
>  
> 
>  # if statements using unnecessary parentheses - ie: if ((foo == bar))
>  		if ($perl_version_ok &&


