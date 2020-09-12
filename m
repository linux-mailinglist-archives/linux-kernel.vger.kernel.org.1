Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22873267B3B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 17:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgILPZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 11:25:15 -0400
Received: from smtprelay0217.hostedemail.com ([216.40.44.217]:41536 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725846AbgILPZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 11:25:14 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 23EEE18224D8A;
        Sat, 12 Sep 2020 15:25:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2560:2563:2682:2685:2693:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:7514:9010:9012:9025:10004:10400:10848:11232:11658:11914:12043:12297:12555:12740:12760:12895:12986:13069:13161:13229:13311:13357:13439:14096:14097:14181:14659:14721:21080:21611:21627:21749:21811:30054:30062:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: face08_0d076f6270f8
X-Filterd-Recvd-Size: 1871
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Sat, 12 Sep 2020 15:25:08 +0000 (UTC)
Message-ID: <da6f30896a8fd78635b3ca454d77a5292a9aa76d.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: make linux-usb list remarks consistent
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 12 Sep 2020 08:25:07 -0700
In-Reply-To: <20200912124025.GA174230@kroah.com>
References: <20200912121346.2796-1-lukas.bulwahn@gmail.com>
         <alpine.DEB.2.21.2009121416500.3770@felia>
         <20200912124025.GA174230@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-09-12 at 14:40 +0200, Greg Kroah-Hartman wrote:
> On Sat, Sep 12, 2020 at 02:19:02PM +0200, Lukas Bulwahn wrote:
> > 
> > On Sat, 12 Sep 2020, Lukas Bulwahn wrote:
> > 
> > > This patch submission will also show me if linux-usb is moderated or not.
> > > I have not subscribed to linux-usb and if it shows up quickly in the
> > > archive, the list is probably not moderated, and hence, validating the
> > > patch.
> > > 
> > 
> > The patch showed up in the archives within seconds:
> > 
> > https://lore.kernel.org/linux-usb/20200912121346.2796-1-lukas.bulwahn@gmail.com/
> > 
> > So, the linux-usb list is most likely not moderated. Patch validated.
> 
> Yes, it is not moderated, and never has been, no idea where that idea came from.

There's also linux-samsung-soc@vger.kernel.org
that is listed as moderated

Are any of the vger lists actually moderated?


