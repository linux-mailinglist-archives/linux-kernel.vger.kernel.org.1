Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85364291008
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 08:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437019AbgJQGNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 02:13:00 -0400
Received: from smtprelay0076.hostedemail.com ([216.40.44.76]:54918 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2436889AbgJQGM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 02:12:59 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave01.hostedemail.com (Postfix) with ESMTP id A74F018014A05;
        Sat, 17 Oct 2020 00:13:25 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id C580C1802926E;
        Sat, 17 Oct 2020 00:11:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3870:3872:4321:4362:5007:6119:7576:7903:10004:10400:10848:11026:11232:11658:11914:12043:12048:12296:12297:12438:12555:12740:12760:12895:12986:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21433:21451:21627:21939:30012:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: act27_2117f0927221
X-Filterd-Recvd-Size: 1735
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Sat, 17 Oct 2020 00:11:45 +0000 (UTC)
Message-ID: <09cd7e609324d460afdf14829baf3c2f1a9cb9cd.camel@perches.com>
Subject: Re: [PATCH] staging: wfx: make a const array static, makes object
 smaller
From:   Joe Perches <joe@perches.com>
To:     Colin King <colin.king@canonical.com>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 16 Oct 2020 17:11:44 -0700
In-Reply-To: <20201016223303.687278-1-colin.king@canonical.com>
References: <20201016223303.687278-1-colin.king@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-10-16 at 23:33 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate const array filter_ies on the stack but instead
> make it static. Makes the object code smaller by 261 bytes.
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   21674	   3166	    448	  25288	   62c8	drivers/staging/wfx/sta.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>   21349	   3230	    448	  25027	   61c3	drivers/staging/wfx/sta.o

Thanks.

It's odd to me it's so large a change as it's only
24 bytes of initialization. (3 entries, each 8 bytes)

This line in the same function:

		hif_set_beacon_filter_table(wvif, 3, filter_ies);

might as well use ARRAY_SIZE(filter_ies) instead of 3


