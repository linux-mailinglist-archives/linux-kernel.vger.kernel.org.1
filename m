Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF352C7141
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404279AbgK1Vza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:55:30 -0500
Received: from smtprelay0088.hostedemail.com ([216.40.44.88]:46520 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387655AbgK1UJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 15:09:28 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 14B37181D341E;
        Sat, 28 Nov 2020 20:08:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:559:599:800:960:967:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2525:2560:2563:2682:2685:2828:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6119:6235:7514:7557:7875:8957:9010:9025:9036:10004:10400:10848:11026:11232:11658:11914:12043:12291:12294:12297:12438:12555:12740:12895:12986:13095:13255:13439:13894:14181:14659:14721:21063:21080:21221:21324:21433:21451:21627:21660:21740:21811:21939:30012:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: spade01_050cf5f27393
X-Filterd-Recvd-Size: 4048
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Sat, 28 Nov 2020 20:08:45 +0000 (UTC)
Message-ID: <60fdeb69192219bfce0a0caf0ec2ea043b82100f.camel@perches.com>
Subject: Re: [PATCH v4] checkpatch: add warning for unnecessary use of
 %h[xudi] and %hh[xudi]
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Date:   Sat, 28 Nov 2020 12:08:44 -0800
In-Reply-To: <20201128200046.78739-1-dwaipayanray1@gmail.com>
References: <20201128200046.78739-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-11-29 at 01:30 +0530, Dwaipayan Ray wrote:
> Modifiers %h and %hh should never be used.

Seems OK, thanks.

Acked-by: Joe Perches <joe@perches.com>
 
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
> Also add a fix option to the check.
> 
> Link: https://lore.kernel.org/lkml/4910042649a4f3ab22fac93191b8c1fa0a2e17c3.camel@perches.com/
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
> ---
> Changes in v4:
> - Change warning type and message
> - Use $stat_real and calculate line offset during matches
> - fix option now works for any patch line
> - # was added to format block to match %#06hh
> 
> Changes in v3:
> - Change warning message
> - Fix regex match to include capture group
> - Warn on every unnecesary use of %h on a line
> - Add fix option when the format line matches current line
> 
> Changes in v2:
> - Use $logFunctions instead of the manual list.
> - Relocate the check to after logging continuations check.
> - Remove perl_version_ok check
> 
> 
>  scripts/checkpatch.pl | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7dc094445d83..3c86ea737e9c 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -6027,6 +6027,28 @@ sub process {
>  			     "Avoid logging continuation uses where feasible\n" . $herecurr);
>  		}
> 
> +# check for unnecessary use of %h[xudi] and %hh[xudi] in logging functions
> +		if (defined $stat &&
> +		    $line =~ /\b$logFunctions\s*\(/ &&
> +		    index($stat, '"') >= 0) {
> +			my $lc = $stat =~ tr@\n@@;
> +			$lc = $lc + $linenr;
> +			my $stat_real = get_stat_real($linenr, $lc);
> +			pos($stat_real) = index($stat_real, '"');
> +			while ($stat_real =~ /[^\"%]*(%[\#\d\.\*\-]*(h+)[idux])/g) {
> +				my $pspec = $1;
> +				my $h = $2;
> +				my $lineoff = substr($stat_real, 0, $-[1]) =~ tr@\n@@;
> +				if (WARN("UNNECESSARY_MODIFIER",
> +					 "Integer promotion: Using '$h' in '$pspec' is unnecessary\n" . "$here\n$stat_real\n") &&
> +				    $fix && $fixed[$fixlinenr + $lineoff] =~ /^\+/) {
> +					my $nspec = $pspec;
> +					$nspec =~ s/h//g;
> +					$fixed[$fixlinenr + $lineoff] =~ s/\Q$pspec\E/$nspec/;
> +				}
> +			}
> +		}
> +
>  # check for mask then right shift without a parentheses
>  		if ($perl_version_ok &&
>  		    $line =~ /$LvalOrFunc\s*\&\s*($LvalOrFunc)\s*>>/ &&


