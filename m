Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E578256F24
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Aug 2020 17:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgH3Pde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Aug 2020 11:33:34 -0400
Received: from smtprelay0126.hostedemail.com ([216.40.44.126]:42808 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727957AbgH3PcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 11:32:21 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 8F66818009132;
        Sun, 30 Aug 2020 15:32:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:966:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2525:2553:2566:2682:2685:2828:2859:2892:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3867:3868:3870:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:4385:5007:6119:6742:7903:9012:9025:10004:10400:10848:11232:11658:11914:12043:12296:12297:12555:12679:12740:12760:12895:12903:13069:13072:13311:13357:13439:14096:14097:14181:14659:14721:14777:21080:21324:21433:21451:21611:21627:21819:21990:30003:30012:30022:30025:30054:30055:30075:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: vest59_190bab027088
X-Filterd-Recvd-Size: 2726
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sun, 30 Aug 2020 15:32:02 +0000 (UTC)
Message-ID: <1d7c6ef2794bedca7e3164e5435f46864eacddfa.camel@perches.com>
Subject: Re: [PATCH v6 2/3] MAINTAINERS: Add Purism Librem 5 section to the
 list
From:   Joe Perches <joe@perches.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, kernel@puri.sm, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        mchehab@kernel.org, Anson.Huang@nxp.com, agx@sigxcpu.org,
        angus@akkea.ca, broonie@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Sun, 30 Aug 2020 08:32:01 -0700
In-Reply-To: <20200830131459.GL32096@dragon>
References: <20200821121755.24599-1-martin.kepplinger@puri.sm>
         <20200821121755.24599-2-martin.kepplinger@puri.sm>
         <20200830131459.GL32096@dragon>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-08-30 at 21:15 +0800, Shawn Guo wrote:
> On Fri, Aug 21, 2020 at 02:17:54PM +0200, Martin Kepplinger wrote:
> > Add development information for the devicetree files for hardware
> > by Purism SPC.
> > 
> > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> 
> I decided to drop this patch from my queue, as I took the suggestion
> from Joe and sent a patch to have get_maintainer report email address
> in the dts file.

It's OK to find maintainers in files, but what about the
B: bug reporting and T: source code repository location lines,

Those seem useful.

> > diff --git a/MAINTAINERS b/MAINTAINERS
[]
> > @@ -14061,6 +14061,13 @@ T:	git git://linuxtv.org/media_tree.git
> >  F:	Documentation/admin-guide/media/pulse8-cec.rst
> >  F:	drivers/media/cec/usb/pulse8/
> >  
> > +PURISM LIBREM 5
> > +M:	Purism Kernel Team <kernel@puri.sm>

People feel like their mails go into a void when no
responses happen after sending to nameless addresses.

It's better to have a named individual as a maintainer
rather than an unspecified exploder address.

It's OK to have both, but just the exploder doesn't
really have that much value as it's faceless.

> > +S:	Supported
> > +B:	https://source.puri.sm/Librem5/linux-next/issues
> > +T:	https://source.puri.sm/Librem5/linux-next

This T: line should be something else.

Perhaps
W;	https://source.puri.sm/Librem5/linux-next
T:	git https://source.puri.sm/Librem5/linux-next.git

> > +F:	arch/arm64/boot/dts/freescale/imx8mq-librem5*


