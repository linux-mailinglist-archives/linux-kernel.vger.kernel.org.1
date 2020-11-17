Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9321F2B58C6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 05:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgKQEUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 23:20:45 -0500
Received: from smtprelay0039.hostedemail.com ([216.40.44.39]:33848 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726826AbgKQEUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 23:20:45 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 83C7A837F24A;
        Tue, 17 Nov 2020 04:20:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 90,9,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2689:2731:2828:3138:3139:3140:3141:3142:3354:3622:3653:3865:3867:3868:3870:4321:4362:5007:6119:7514:7875:7903:9010:10004:10400:10848:11232:11658:11914:12297:12555:12740:12895:13095:13439:13894:14181:14659:14721:21080:21433:21451:21627:21740:21741:21939:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: birth03_35059fb2732e
X-Filterd-Recvd-Size: 3269
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Tue, 17 Nov 2020 04:20:43 +0000 (UTC)
Message-ID: <477496bed101ed007e7e8db6d511ece2fa2d119c.camel@perches.com>
Subject: Re: [PATCH v3] checkpatch: add fix option for MAINTAINERS_STYLE
From:   Joe Perches <joe@perches.com>
To:     Aditya Srivastava <yashsri421@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Date:   Mon, 16 Nov 2020 20:20:42 -0800
In-Reply-To: <20201117040501.21914-1-yashsri421@gmail.com>
References: <20201117040501.21914-1-yashsri421@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-11-17 at 09:35 +0530, Aditya Srivastava wrote:
> Checkpatch expects entries in MAINTAINERS file in a specific order and
> warns if the changes made do not follow the specified order.
> 
> E.g., running checkpatch on commit b33bc2b878e0 ("nexthop: Add entry to
> MAINTAINERS") reports this warning:
> 
> WARNING: Misordered MAINTAINERS entry - list file patterns in
> alphabetic order
> +F:	include/uapi/linux/nexthop.h
> +F:	include/net/netns/nexthop.h

OK, this should work.
Thanks Aditya.

Acked-by: Joe Perches <joe@perches.com>

> 
> Provide a simple fix by swapping the unordered lines, if both the lines
> are additions (start with '+')
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
> ---
> Changes in v2:
> modified commit message
> 
> Changes in v3:
> add check if both the lines are additions(ie start with '+')
> 
>  scripts/checkpatch.pl | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 2749f32dffe9..7ee3f05c354d 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3299,13 +3299,22 @@ sub process {
>  					     "Unknown MAINTAINERS entry type: '$cur'\n" . $herecurr);
>  				} else {
>  					if ($previndex >= 0 && $curindex < $previndex) {
> -						WARN("MAINTAINERS_STYLE",
> -						     "Misordered MAINTAINERS entry - list '$cur:' before '$prev:'\n" . $hereprev);
> +						if (WARN("MAINTAINERS_STYLE",
> +							 "Misordered MAINTAINERS entry - list '$cur:' before '$prev:'\n" . $hereprev) &&
> +						    $fix && $prevrawline =~ /^\+[A-Z]:/) {
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
> +						    $fix && $prevrawline =~ /^\+[A-Z]:/) {
> +							$fixed[$fixlinenr - 1] = $rawline;
> +							$fixed[$fixlinenr] = $prevrawline;
> +						}
>  					}
>  				}
>  			}


