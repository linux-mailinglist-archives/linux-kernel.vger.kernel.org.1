Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF13A220812
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 11:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbgGOJEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 05:04:14 -0400
Received: from smtprelay0078.hostedemail.com ([216.40.44.78]:43546 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729856AbgGOJEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:04:11 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 1BD8A182CED5B;
        Wed, 15 Jul 2020 09:04:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2560:2563:2682:2685:2828:2859:2902:2914:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:6248:7903:8700:9010:9025:10004:10400:10848:11232:11289:11658:11914:12043:12297:12555:12740:12760:12895:12986:13069:13311:13357:13439:14096:14097:14180:14181:14659:14721:14777:21060:21080:21433:21627:21811:21819:21939:30003:30022:30054:30060:30062:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:6,LUA_SUMMARY:none
X-HE-Tag: crowd16_1d14ee826ef8
X-Filterd-Recvd-Size: 2534
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Wed, 15 Jul 2020 09:04:08 +0000 (UTC)
Message-ID: <128a9f7de9885257736b3bb2648ea90bcbc2c760.camel@perches.com>
Subject: Re: [PATCH v2] staging: gasket: core: Fix a coding style issue in
 gasket_core.c
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Zhixu Zhao <zhixu001@126.com>, rcy@google.com,
        rspringer@google.com, toddpoynor@google.com
Date:   Wed, 15 Jul 2020 02:04:06 -0700
In-Reply-To: <20200715083727.GY2549@kadam>
References: <20200617161127.32006-1-zhixu001@126.com>
         <20200714234440.27009-1-zhixu001@126.com>
         <20200715071748.GC2305231@kroah.com>
         <23ef3ca9616418b702df891443d0f4864edd58ff.camel@perches.com>
         <20200715075755.GA2516028@kroah.com> <20200715083727.GY2549@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-07-15 at 11:37 +0300, Dan Carpenter wrote:
> On Wed, Jul 15, 2020 at 09:57:55AM +0200, Greg KH wrote:
> > On Wed, Jul 15, 2020 at 12:24:22AM -0700, Joe Perches wrote:
> > > On Wed, 2020-07-15 at 09:17 +0200, Greg KH wrote:
> > > > On Wed, Jul 15, 2020 at 07:44:40AM +0800, Zhixu Zhao wrote:
> > > > > On Thu, Jun 18, 2020 at 12:11:27AM +0800, Zhixu Zhao wrote:
> > > > > > A coding alignment issue is found by checkpatch.pl.
> > > > > > Fix it by using a temporary for gasket_dev->bar_data[bar_num].
> > > > > > 
> > > > > > Signed-off-by: Zhixu Zhao <zhixu001@126.com>
> > > > > 
> > > > > Hi, there~
> > > > > 
> > > > > Does anybody have any further comments on this?
> > > > > Can it be merged?
> > > > 
> > > > I never saw the first version of this, are you sure it got sent to the
> > > > mailing list?  It's not in any archives anywhere.
> > > 
> > > I saw it.  It's here:
> > > https://lore.kernel.org/lkml/20200617161127.32006-1-zhixu001@126.com/
> > 
> > Ah, doh, sorry.
> > 
> > Zhixu, please address the comments given to you on the series and resend
> > it as a new version.
> 
> He responded but not as a reply to my email.  It turns out I made a
> mistake.
> 
> Anyway, just resend, Zhixu.

It's a pity a resend is being requested.

It'd be a better process if the original patch could
be applied via the link akin to a git pull.


