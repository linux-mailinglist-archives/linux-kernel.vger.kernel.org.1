Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE8E2C4FEE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 09:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388579AbgKZIC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 03:02:27 -0500
Received: from smtprelay0132.hostedemail.com ([216.40.44.132]:51274 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726392AbgKZIC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 03:02:26 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 9F0B71801EA65;
        Thu, 26 Nov 2020 08:02:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 10,1,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:559:599:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2828:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3315:3353:3622:3653:3865:3866:3867:3868:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6119:6235:7514:7557:9025:10004:10400:10848:11026:11232:11658:11914:12043:12294:12297:12438:12555:12740:12895:12986:13255:13439:13894:14181:14659:14721:21080:21324:21451:21627:21660:21811:21891:21939:30012:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:809,LUA_SUMMARY:none
X-HE-Tag: smash37_3e0bf802737d
X-Filterd-Recvd-Size: 2893
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Thu, 26 Nov 2020 08:02:23 +0000 (UTC)
Message-ID: <4b40cac946eaabf875556674a24ad7c9fc1c909b.camel@perches.com>
Subject: Re: [PATCH RFC] checkpatch: add warning for unnecessary use of
 %h[xudi] and %hh[xudi]
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Date:   Thu, 26 Nov 2020 00:02:22 -0800
In-Reply-To: <20201126072840.32681-1-dwaipayanray1@gmail.com>
References: <20201126072840.32681-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-11-26 at 12:58 +0530, Dwaipayan Ray wrote:
> Modifiers %h and %hh should never be used.
> 
> Commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use
> of unnecessary %h[xudi] and %hh[xudi]") specifies that:
> 
> "Standard integer promotion is already done and %hx and %hhx is useless
> so do not encourage the use of %hh[xudi] or %h[xudi]."
> 
> "The "h" and "hh" things should never be used. The only reason for them
> being used if you have an "int", but you want to print it out as a
> "char" (and honestly, that is a really bad reason, you'd be better off
> just using a proper cast to make the code more obvious)."
> 
> Add a new check to emit a warning on finding an unneeded use of %h or
> %hh modifier.
> 
> Link: https://lore.kernel.org/lkml/4910042649a4f3ab22fac93191b8c1fa0a2e17c3.camel@perches.com/
> 
> Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
> ---
>  scripts/checkpatch.pl | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7dc094445d83..47c1017a9973 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -6570,6 +6570,19 @@ sub process {
>  			}
>  		}
>  
> 
> +# check for unnecessary use of %h[xudi] and %hh[xudi]
> +		if ($perl_version_ok &&
> +		    defined $stat &&
> +		    $line =~ /(?:[sd]?print[kfd]|(?:pr_|drm_)(?:info|debug|warn|error))/i) {

Use $logFunctions and please move this close to the lines with
"# check for logging functions with KERN_<LEVEL>"

> +			my $lc = $stat =~ tr@\n@@;
> +			$lc = $lc + $linenr;
> +			my $stat_real = get_stat_real($linenr, $lc);
> +			if ($stat_real =~ /\"[^\"]*%[\d\.\*\-]*h+[idux].*\"/i) {
> +				WARN("UNNECESSARY_MODIFIER",
> +				     "Unnecessary use of length modifiers %h[xudi] or %hh[xudi]\n" . "$here\n$stat_real\n");
> +			}
> +		}
> +
>  # check for naked sscanf
>  		if ($perl_version_ok &&
>  		    defined $stat &&


