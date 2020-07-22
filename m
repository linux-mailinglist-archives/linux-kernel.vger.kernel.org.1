Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B9422A054
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 21:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732498AbgGVT4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 15:56:09 -0400
Received: from smtprelay0243.hostedemail.com ([216.40.44.243]:39194 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726525AbgGVT4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 15:56:09 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 7C27781EB13E;
        Wed, 22 Jul 2020 19:56:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:966:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2196:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3351:3622:3866:3867:3872:3873:4321:4385:4605:5007:6117:6119:7875:7903:10004:10400:10848:11026:11232:11473:11658:11914:12043:12048:12294:12297:12438:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21451:21627:30012:30034:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: event76_220415b26f38
X-Filterd-Recvd-Size: 1602
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Wed, 22 Jul 2020 19:56:07 +0000 (UTC)
Message-ID: <1e38634d0f1c94eaaa2c9312ffe112734029a316.camel@perches.com>
Subject: Re: [PATCH] staging: octeon: Indent with tabs instead of spaces
From:   Joe Perches <joe@perches.com>
To:     Muhammad Usama Anjum <musamaanjum@gmail.com>,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 22 Jul 2020 12:56:06 -0700
In-Reply-To: <20200722171950.GA6176@PKL-UANJUM-LT.pkl.mentorg.com>
References: <20200722171950.GA6176@PKL-UANJUM-LT.pkl.mentorg.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-07-22 at 22:19 +0500, Muhammad Usama Anjum wrote:
> Remove a coding style error. It makes code more readable.
[]
> diff --git a/drivers/staging/octeon/ethernet-defines.h b/drivers/staging/octeon/ethernet-defines.h
[]
> @@ -27,14 +27,14 @@
>  #define REUSE_SKBUFFS_WITHOUT_FREE  1
>  #endif
>  
> -#define USE_ASYNC_IOBDMA            (CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0)
> +#define USE_ASYNC_IOBDMA		(CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0)
>  
>  /* Maximum number of SKBs to try to free per xmit packet. */
> -#define MAX_OUT_QUEUE_DEPTH 1000
> +#define MAX_OUT_QUEUE_DEPTH		1000
>  
>  #define FAU_TOTAL_TX_TO_CLEAN (CVMX_FAU_REG_END - sizeof(u32))

If you really like alignment to tabstop,
why not align FAU_TOTAL_TX_TO_CLEAN too?


