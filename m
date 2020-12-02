Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3975B2CC88F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 22:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgLBVEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 16:04:05 -0500
Received: from smtprelay0159.hostedemail.com ([216.40.44.159]:50868 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726318AbgLBVEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 16:04:04 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id B7ABA837F24C;
        Wed,  2 Dec 2020 21:03:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2902:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:4321:5007:7514:7875:7903:8957:10004:10400:10848:11026:11232:11473:11658:11914:12043:12297:12438:12555:12740:12895:12986:13069:13095:13255:13311:13357:13439:13894:14181:14659:14721:21080:21433:21451:21611:21627:21660:21740:21939:30054:30070:30080:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: kick66_3f163df273b6
X-Filterd-Recvd-Size: 2574
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed,  2 Dec 2020 21:03:22 +0000 (UTC)
Message-ID: <51225354b2a533250dad967ef413aaa4f41dfd66.camel@perches.com>
Subject: Re: [PATCH v3] checkpatch: add warning for lines starting with a
 '#' in commit log
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        Peilin Ye <yepeilin.cs@gmail.com>
Date:   Wed, 02 Dec 2020 13:03:21 -0800
In-Reply-To: <20201202205740.127986-1-dwaipayanray1@gmail.com>
References: <20201202205740.127986-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-12-03 at 02:27 +0530, Dwaipayan Ray wrote:
> Commit log lines starting with '#' are dropped by git as comments.
> Add a check to emit a warning for these lines.
> 
> Also add a --fix option to insert a space before the leading '#' in
> such lines.
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Suggested-by: Peilin Ye <yepeilin.cs@gmail.com>
> Tested-by: Peilin Ye <yepeilin.cs@gmail.com>
> Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>

Acked-by: Joe Perches <joe@perches.com>

> ---
> Changes in v3:
> - Modify commit message for more clarity
> - Modify warning message
> - Modify --fix option to substitute single space instead of tab
> 
> Changes in v2:
> - Modify warning message and type
> - Style fixes
> 
>  scripts/checkpatch.pl | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index e8c1ed0b1fad..7940889877ba 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2966,6 +2966,15 @@ sub process {
>  			$commit_log_possible_stack_dump = 0;
>  		}
>  
> 
> +# Check for lines starting with a #
> +		if ($in_commit_log && $line =~ /^#/) {
> +			if (WARN("COMMIT_COMMENT_SYMBOL",
> +				 "Commit log lines starting with '#' are dropped by git as comments\n" . $herecurr) &&
> +			    $fix) {
> +				$fixed[$fixlinenr] =~ s/^/ /;
> +			}
> +		}
> +
>  # Check for git id commit length and improperly formed commit descriptions
>  		if ($in_commit_log && !$commit_log_possible_stack_dump &&
>  		    $line !~ /^\s*(?:Link|Patchwork|http|https|BugLink|base-commit):/i &&


