Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3383B24CCAE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 06:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgHUEZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 00:25:07 -0400
Received: from smtprelay0149.hostedemail.com ([216.40.44.149]:49976 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725270AbgHUEZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 00:25:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 9DBFB173086C;
        Fri, 21 Aug 2020 04:25:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3870:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4362:5007:7974:8985:9025:10004:10400:10848:11232:11658:11914:12043:12048:12297:12555:12740:12760:12895:12986:13069:13311:13357:13439:14096:14097:14180:14181:14659:14721:21060:21080:21325:21627:21811:30041:30054:30083:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: sheet48_5e1546627036
X-Filterd-Recvd-Size: 1931
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Fri, 21 Aug 2020 04:25:04 +0000 (UTC)
Message-ID: <9230a7f0b80b4a984f18c979ca3c703edd7d6f98.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: Fix the usage of capture group ( ... )
From:   Joe Perches <joe@perches.com>
To:     Mrinal Pandey <mrinalmni@gmail.com>, apw@canonical.com,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        skhan@linuxfoundation.org,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Thu, 20 Aug 2020 21:25:03 -0700
In-Reply-To: <20200820045232.tmun7jlppeeesg4p@mrinalpandey>
References: <20200714032352.f476hanaj2dlmiot@mrinalpandey>
         <alpine.DEB.2.21.2007300746330.13710@felia>
         <a2773089a844047407855f2da7bd72c2970d2e6b.camel@perches.com>
         <20200820045232.tmun7jlppeeesg4p@mrinalpandey>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-08-20 at 10:22 +0530, Mrinal Pandey wrote:
> On 20/07/30 12:31AM, Joe Perches wrote:
> > On Thu, 2020-07-30 at 07:58 +0200, Lukas Bulwahn wrote:
> > > Hi Joe,
> > > 
> > > did you see this quick fix to checkpatch.pl? Can you comment on the 
> > > commit and can we get a quick ack on that fix, please?
> > 
> > Yes, in a bit.
> > 
> > > General question on patches for ./scripts/checkpatch.pl:
> > > How do they travel to Linus?
> > 
> > Generally via Andrew Morton.
> > 
> > > Do you pick those patches and provide them to Andrew Morton?
> > > Or do you just ack them and we need to send them to Andrew Morton to get 
> > > them into mainline?
> > 
> > Generally, ack and forward.

https://lore.kernel.org/lkml/20200714032352.f476hanaj2dlmiot@mrinalpandey/

Andrew, can you pick up this patch please.

Thanks

