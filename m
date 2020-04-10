Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD2281A4A90
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 21:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgDJThA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 15:37:00 -0400
Received: from smtprelay0204.hostedemail.com ([216.40.44.204]:32880 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726847AbgDJTg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:36:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 48CFC1802EB4E;
        Fri, 10 Apr 2020 19:36:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:196:355:379:599:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1622:1711:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3653:3865:3866:3867:3868:3871:3872:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:6119:6671:7903:9025:10004:10400:10848:11232:11658:11914:12043:12296:12297:12555:12740:12760:12895:12986:13007:13069:13095:13311:13357:13439:14181:14659:14721:21067:21080:21212:21433:21451:21627:21660:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: time34_3ce4cfa07334d
X-Filterd-Recvd-Size: 2629
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Fri, 10 Apr 2020 19:36:58 +0000 (UTC)
Message-ID: <a5c555e6853e9103a871127cafaea34583f426fb.camel@perches.com>
Subject: Re: [PATCH] checkpatch: check for missing \n at the end of logging
 message
From:   Joe Perches <joe@perches.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        apw@canonical.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Fri, 10 Apr 2020 12:34:56 -0700
In-Reply-To: <20200407204908.10420-1-christophe.jaillet@wanadoo.fr>
References: <20200407204908.10420-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-04-07 at 22:49 +0200, Christophe JAILLET wrote:
> Strings logged with pr_xxx and dev_xxx often lack a trailing '\n'.
> Introduce new tests to try to catch them early.

Unintentional resend?

> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This is more a PoC for now.
> 
> Regex could be improved, merged, ...
> We could also check for surrounding pr_cont...
> 
> This patch is based on idea from [1]. coccinelle spots too many places
> where \n are missing (~ 2800 with the heuristic I've used).
> Fixing them would be painful.
> I instead propose to teach checkpatch.pl about it to try to spot cases
> early and avoid introducing new cases.
> 
> [1]: https://marc.info/?l=kernel-janitors&m=158619533629657&w=4
> ---
>  scripts/checkpatch.pl | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index c392ab8ea12e..792804bd6ad9 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -5676,6 +5676,16 @@ sub process {
>  			}
>  		}
>  
> +# check for missing \n at the end of logging function
> +		if ($line =~ /\bpr_(emerg|alert|crit|err|warning|warn|notice|info|debug|dbg)\s*\("([^"]*(?<!\\n))"/) {
> +			WARN("MISSING NL",
> +			     "Possible missing '\\n' at the end of a log message\n" . $hereprev);
> +		}
> +		if ($line =~ /\bdev_(emerg|alert|crit|err|warning|warn|notice|info|debug|dbg)\s*\([^,]*,\s*"([^"]*(?<!\\n))"/) {
> +			WARN("MISSING NL",
> +			     "Possible missing '\\n' at the end of a log message\n" . $hereprev);
> +		}
> +
>  # check for logging functions with KERN_<LEVEL>
>  		if ($line !~ /printk(?:_ratelimited|_once)?\s*\(/ &&
>  		    $line =~ /\b$logFunctions\s*\(.*\b(KERN_[A-Z]+)\b/) {

