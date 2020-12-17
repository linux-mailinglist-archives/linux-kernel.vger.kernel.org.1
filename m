Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75782DD5A4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 18:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgLQRDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 12:03:50 -0500
Received: from smtprelay0116.hostedemail.com ([216.40.44.116]:47858 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726613AbgLQRDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 12:03:49 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 3C7751E1C;
        Thu, 17 Dec 2020 17:03:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:966:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2196:2198:2199:2200:2393:2525:2553:2560:2563:2682:2685:2828:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:4385:4560:4605:5007:6117:6119:7514:7807:7903:8784:9025:10004:10400:10848:11026:11232:11473:11658:11914:12043:12114:12262:12296:12297:12438:12555:12679:12740:12895:13019:13161:13229:13439:13894:14096:14097:14181:14659:14721:21080:21365:21433:21451:21627:21939:30034:30054:30056:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: board56_600c13927436
X-Filterd-Recvd-Size: 3691
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Thu, 17 Dec 2020 17:03:07 +0000 (UTC)
Message-ID: <94d6a56174c56ef13c9794186fdbfcc12c376c00.camel@perches.com>
Subject: Re: [PATCH] checkpatch: fix false positive for COMMIT_LOG_LONG_LINE
 with URLs
From:   Joe Perches <joe@perches.com>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 17 Dec 2020 09:03:06 -0800
In-Reply-To: <20201217134221.16178-1-yashsri421@gmail.com>
References: <20201217134221.16178-1-yashsri421@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-12-17 at 19:12 +0530, Aditya Srivastava wrote:
> Currently checkpatch warns for long line in commit messages even for
> URL lines.
> 
> An evaluation over v4.13..v5.8 showed that out of ~11000 warnings for
> this class, around 790 are due to the line containing link.
> 
> E.g. running checkpatch on commit 3cde818cd02b ("ASoC: topology:
> Consolidate how dtexts and dvalues are freed") reports this warning:
> 
> WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
> https://mailman.alsa-project.org/pipermail/alsa-devel/2019-January/144761.html
> 
> Avoid giving users warning for character limit, instead suggest them to
> prefix the URLs with "Link:"
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
> ---
>  scripts/checkpatch.pl | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3032,8 +3032,14 @@ sub process {
>  		      $line =~ /^\s*(?:Fixes:|Link:|$signature_tags)/i ||
>  					# A Fixes: or Link: line or signature tag line
>  		      $commit_log_possible_stack_dump)) {
> -			WARN("COMMIT_LOG_LONG_LINE",
> -			     "Possible unwrapped commit description (prefer a maximum 75 chars per line)\n" . $herecurr);
> +			if ($line =~ /(?:http|https|ftp):\/\//) {
> +				WARN("COMMIT_LOG_LONG_LINE",
> +				     "Consider prefixing the URL with 'Link:'\n" . $herecurr);
> +			}
> +			else {
> +				WARN("COMMIT_LOG_LONG_LINE",
> +				     "Possible unwrapped commit description (prefer a maximum 75 chars per line)\n" . $herecurr);
> +			}

NAK.

Aditya, you've submitted several patches to checkpatch and
you should know better by now what coding style is necessary
for acceptance.

			} else {

Make the URI/URL check follow the styles allowed by RFC 3986.
Look at the long_line check around line 3500 introduced by
commit 2e4bbbc550be336cbb3defc67430fc0700aa1426
Author: Andreas Brauchli <a.brauchli@elementarea.net>
Date:   Tue Feb 6 15:38:45 2018 -0800
checkpatch: allow long lines containing URL

Also likely the URI should not be allowed to exceed the line
maximum unless it's the first non-whitespace of the line and
not starting after some other word in the line.

Lastly, this sets $commit_log_long_line even for lines that
are now nominally exempted from the long line check.

The number of nominal fixes you showed above is not correct.

Retrospective testing of checkpatch using --git history
should be aware of changes to checkpatch.

This should count only lines from 75 to 80 chars for the
commit range you tested and only for 75 to 100 for commits
after checkpatch changed its allowed long line maximum in
commit bdc48fa11e46f867ea4d75fa59ee87a7f48be144
checkpatch/coding-style: deprecate 80-column warning



