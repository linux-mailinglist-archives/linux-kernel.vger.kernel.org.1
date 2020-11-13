Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385082B2095
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 17:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgKMQgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 11:36:47 -0500
Received: from smtprelay0114.hostedemail.com ([216.40.44.114]:49716 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726156AbgKMQgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 11:36:47 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 4713618224D63;
        Fri, 13 Nov 2020 16:36:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3421:3622:3865:3867:3868:4321:4361:5007:9108:10004:10400:10471:10848:11026:11232:11658:11914:12043:12114:12295:12297:12438:12740:12895:13069:13255:13311:13357:13439:13894:14180:14181:14659:14721:21080:21451:21627:30030:30054:30083:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: steel67_1e01f7727310
X-Filterd-Recvd-Size: 2245
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Fri, 13 Nov 2020 16:36:45 +0000 (UTC)
Message-ID: <fe5ad7c72eadac32eda6a41b61feaa42c04392b0.camel@perches.com>
Subject: Re: [PATCH 3/2] checkpatch: document the function renaming and
 deprecation around devm_ioremap_resource
From:   Joe Perches <joe@perches.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>
Date:   Fri, 13 Nov 2020 08:36:44 -0800
In-Reply-To: <20201113091157.125766-1-u.kleine-koenig@pengutronix.de>
References: <20201113085327.125041-1-u.kleine-koenig@pengutronix.de>
         <20201113091157.125766-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-11-13 at 10:11 +0100, Uwe Kleine-König wrote:
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> this can also be squashed into the respective patches instead.
> 
> Best regards
> Uwe
> 
>  scripts/checkpatch.pl | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -615,6 +615,11 @@ our %deprecated_apis = (
>  	"rcu_barrier_sched"			=> "rcu_barrier",
>  	"get_state_synchronize_sched"		=> "get_state_synchronize_rcu",
>  	"cond_synchronize_sched"		=> "cond_synchronize_rcu",
> +	"devm_platform_get_and_ioremap_resource" => "devm_platform_get_request_and_ioremap_resource",

Do we really need 46 character length function names?

> +	"devm_platform_ioremap_resource"	=> "devm_platform_request_ioremap_resource",
> +	"devm_platform_ioremap_resource_wc"	=> "devm_platform_request_ioremap_resource_wc",
> +	"devm_ioremap_resource"			=> "devm_request_ioremap_resource",
> +	"devm_ioremap_resource_wc"		=> "devm_request_ioremap_resource_wc",
>  );
>  
> 
>  #Create a search pattern for all these strings to speed up a loop below

And do please send your proposed patches to the appropriate maintainers.


