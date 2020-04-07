Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C51D1A1588
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 21:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgDGTFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 15:05:54 -0400
Received: from smtprelay0106.hostedemail.com ([216.40.44.106]:38812 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726736AbgDGTFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 15:05:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id DA3271802CCA2;
        Tue,  7 Apr 2020 19:05:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3867:3870:3871:4250:4321:5007:7903:10004:10400:11026:11232:11658:11914:12043:12297:12438:12555:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21451:21627:21939:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: pipe70_33360acc5b61e
X-Filterd-Recvd-Size: 1868
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Tue,  7 Apr 2020 19:05:51 +0000 (UTC)
Message-ID: <ffdaa916088c95a984b2953334ea446251b2ecd9.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Fix a typo in the regex for $allocFunctions
From:   Joe Perches <joe@perches.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        apw@canonical.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Tue, 07 Apr 2020 12:03:52 -0700
In-Reply-To: <20200407190029.892-1-christophe.jaillet@wanadoo.fr>
References: <20200407190029.892-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-04-07 at 21:00 +0200, Christophe JAILLET wrote:
> Here, we look for function such as 'netdev_alloc_skb_ip_align', so a '_'
> is missing in the regex.
> 
> To make sure:
>    grep -r --include=*.c skbip_a * | wc   ==>   0 results
>    grep -r --include=*.c skb_ip_a * | wc  ==> 112 results

Acked-by: Joe Perches <joe@perches.com>

> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 529c892722b9..c392ab8ea12e 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -479,7 +479,7 @@ our $allocFunctions = qr{(?x:
>  		(?:kv|k|v)[czm]alloc(?:_node|_array)? |
>  		kstrdup(?:_const)? |
>  		kmemdup(?:_nul)?) |
> -	(?:\w+)?alloc_skb(?:ip_align)? |
> +	(?:\w+)?alloc_skb(?:_ip_align)? |
>  				# dev_alloc_skb/netdev_alloc_skb, et al
>  	dma_alloc_coherent
>  )};

