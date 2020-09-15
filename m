Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842CF269BE2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 04:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgIOCaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 22:30:08 -0400
Received: from smtprelay0039.hostedemail.com ([216.40.44.39]:59580 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726019AbgIOCaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 22:30:06 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id A2F8618029122;
        Tue, 15 Sep 2020 02:30:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:968:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3873:3874:4321:5007:7903:8603:10004:10400:10848:11026:11232:11658:11914:12296:12297:12740:12760:12895:13069:13071:13161:13229:13255:13311:13357:13439:14180:14659:14721:21080:21433:21451:21627:21939:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:18,LUA_SUMMARY:none
X-HE-Tag: coil86_0f0b38c2710d
X-Filterd-Recvd-Size: 1720
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Tue, 15 Sep 2020 02:30:03 +0000 (UTC)
Message-ID: <00e6faaceed28ceb81777a63caffc512885a6efb.camel@perches.com>
Subject: Re: [PATCH 3/3] staging: rtl8723bs: os_dep: fixed spacing around
 operators issue
From:   Joe Perches <joe@perches.com>
To:     Ross Schmidt <ross.schm.dev@gmail.com>, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Mon, 14 Sep 2020 19:30:02 -0700
In-Reply-To: <20200915001731.28986-3-ross.schm.dev@gmail.com>
References: <20200915001731.28986-1-ross.schm.dev@gmail.com>
         <20200915001731.28986-3-ross.schm.dev@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-09-14 at 19:17 -0500, Ross Schmidt wrote:
> Fixed a coding style issue by adding spaces around operators in
> sdio_ops_linux.c to fix checkpatch checks.

Hello Ross.

If you want to do more than fix whitespace,
please look at the #define for DBG_871X.

All the uses with a KERN_<LEVEL> are broken
and should be modified as _dbgdump is just
printk and DRIVER_PREFIX is "RTL8723BS: "
so the KERN_<LEVEL> after the DRIVER_PREFIX.

That's just broken.

	#define DBG_871X(...)     do {\
		_dbgdump(DRIVER_PREFIX __VA_ARGS__);\
	} while (0)

Realistically, the DBG_871X macro family should just
use pr_debug and all the KERN_<LEVEL> uses should be
removed.

The define and uses of RT_TRACE should also just be
converted to use pr_debug or some other function
to perhaps reduce overall object size


