Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE812B5400
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 22:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgKPVzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 16:55:49 -0500
Received: from smtprelay0004.hostedemail.com ([216.40.44.4]:39678 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727864AbgKPVzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 16:55:48 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id A099A100E7B49;
        Mon, 16 Nov 2020 21:55:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2525:2560:2563:2682:2685:2689:2731:2828:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3653:3865:3867:3868:3870:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:6119:7875:7903:9010:9025:10004:10400:10848:11232:11658:11914:12043:12297:12555:12740:12895:13161:13229:13439:13894:14181:14659:14721:21080:21433:21451:21627:21740:21939:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: sky93_41062bc2732c
X-Filterd-Recvd-Size: 2867
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Mon, 16 Nov 2020 21:55:45 +0000 (UTC)
Message-ID: <d675ffc7c85c68117c3e2d78d2e35679f778a9c2.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: add fix option for MAINTAINERS_STYLE
From:   Joe Perches <joe@perches.com>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Date:   Mon, 16 Nov 2020 13:55:44 -0800
In-Reply-To: <20201116071930.7733-1-yashsri421@gmail.com>
References: <20201116071930.7733-1-yashsri421@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-11-16 at 12:49 +0530, Aditya Srivastava wrote:
> Checkpatch expects entries in MAINTAINERS file in a specific order and
> warns if the changes made do not follow the specified order.
> 
> E.g., running checkpatch on commit 6f736909f0a4 ("MAINTAINERS: Add
> patchwork link for PWM entry") reports this warning:
> 
> WARNING: Misordered MAINTAINERS entry - list 'Q:' before 'T:'
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git
> +Q:	https://patchwork.ozlabs.org/project/linux-pwm/list/
> 
> Provide a simple fix by swapping the unordered lines

NAK.

This --fix option can't work if a patch merely adds a single line.
The patch context lines would be wrong.

This has to make sure the both lines are additions (start with +)


> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3299,13 +3299,22 @@ sub process {
>  					     "Unknown MAINTAINERS entry type: '$cur'\n" . $herecurr);
>  				} else {
>  					if ($previndex >= 0 && $curindex < $previndex) {
> -						WARN("MAINTAINERS_STYLE",
> -						     "Misordered MAINTAINERS entry - list '$cur:' before '$prev:'\n" . $hereprev);
> +						if (WARN("MAINTAINERS_STYLE",
> +							 "Misordered MAINTAINERS entry - list '$cur:' before '$prev:'\n" . $hereprev) &&
> +						    $fix) {
> +							# swap these lines
> +							$fixed[$fixlinenr - 1] = $rawline;
> +							$fixed[$fixlinenr] = $prevrawline;
> +						}
>  					} elsif ((($prev eq 'F' && $cur eq 'F') ||
>  						  ($prev eq 'X' && $cur eq 'X')) &&
>  						 ($prevval cmp $curval) > 0) {
> -						WARN("MAINTAINERS_STYLE",
> -						     "Misordered MAINTAINERS entry - list file patterns in alphabetic order\n" . $hereprev);
> +						if (WARN("MAINTAINERS_STYLE",
> +							 "Misordered MAINTAINERS entry - list file patterns in alphabetic order\n" . $hereprev) &&
> +						    $fix) {
> +							$fixed[$fixlinenr - 1] = $rawline;
> +							$fixed[$fixlinenr] = $prevrawline;
> +						}
>  					}
>  				}
>  			}


