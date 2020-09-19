Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D30270F5F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 18:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgISQPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 12:15:16 -0400
Received: from smtprelay0016.hostedemail.com ([216.40.44.16]:40612 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726463AbgISQPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 12:15:15 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id B7670180A7FF9;
        Sat, 19 Sep 2020 16:15:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:968:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3350:3622:3867:3868:3870:4321:5007:8957:10004:10400:11026:11232:11473:11658:11914:12043:12297:12555:12740:12760:12895:13069:13161:13229:13311:13357:13439:14659:21080:21627:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: trip10_4805ed327135
X-Filterd-Recvd-Size: 1523
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Sat, 19 Sep 2020 16:15:09 +0000 (UTC)
Message-ID: <6c07f1238d48cef82668defcd9cba0e4ccdf4177.camel@perches.com>
Subject: Re: [PATCH 1/3] staging: rtl8192u: clean up blank line style issues
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Sat, 19 Sep 2020 09:15:08 -0700
In-Reply-To: <20200919150823.16923-1-straube.linux@gmail.com>
References: <20200919150823.16923-1-straube.linux@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-09-19 at 17:08 +0200, Michael Straube wrote:
> Add missing and remove unnecessary blank lines to clear checkpatch
> issues.

unrelated trivia:

> diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
[]
> @@ -26,6 +26,7 @@ Major Change History:
>  static u32 edca_setting_DL[HT_IOT_PEER_MAX] = {
>  	0x5e4322, 0x5e4322, 0x5e4322, 0x604322, 0x00a44f, 0x5ea44f
>  };
> +
>  static u32 edca_setting_UL[HT_IOT_PEER_MAX] = {
>  	0x5e4322, 0x00a44f, 0x5e4322, 0x604322, 0x5ea44f, 0x5ea44f
>  };

These could be static const

Here and in drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
and drivers/staging/rtl8723bs/hal/odm_EdcaTurboCheck.c


