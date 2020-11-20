Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EE42B9F18
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 01:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgKTALR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 19:11:17 -0500
Received: from smtprelay0096.hostedemail.com ([216.40.44.96]:35014 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726913AbgKTALQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 19:11:16 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 126B1837F24F;
        Fri, 20 Nov 2020 00:11:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2828:2892:2901:3138:3139:3140:3141:3142:3354:3622:3743:3865:3867:3868:3870:3871:3872:3874:4250:4321:5007:6119:6121:7514:7903:8660:9010:10004:10400:10848:11026:11232:11658:11914:12295:12297:12663:12740:12760:12895:13069:13148:13230:13255:13311:13357:13439:14096:14097:14180:14181:14659:14721:21067:21080:21212:21433:21627:21939:30012:30054:30070:30075:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: toy75_2e0778727347
X-Filterd-Recvd-Size: 2707
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Fri, 20 Nov 2020 00:11:12 +0000 (UTC)
Message-ID: <b74517242de5790f8ab0cd9be00a70b9ab96564c.camel@perches.com>
Subject: Re: Proposal for a new checkpatch check; matching _set_drvdata() &
 _get_drvdata()
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Robo Bot <apw@canonical.com>, LKML <linux-kernel@vger.kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        cocci <cocci@systeme.lip6.fr>
Date:   Thu, 19 Nov 2020 16:11:11 -0800
In-Reply-To: <CAHp75VcT5hZH6m0Dri1h_EFjc7=4+1XoE7sRuQyfO75k9A0GKA@mail.gmail.com>
References: <CA+U=Dspy5+RE9agcLr6eY9DCMa1c5+++0JLeugMMBRXz4YLj1w@mail.gmail.com>
         <CAHp75VcT5hZH6m0Dri1h_EFjc7=4+1XoE7sRuQyfO75k9A0GKA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-11-19 at 17:16 +0200, Andy Shevchenko wrote:
> On Thu, Nov 19, 2020 at 4:09 PM Alexandru Ardelean
> <ardeleanalex@gmail.com> wrote:
> > 
> > Hey,
> > 
> > So, I stumbled on a new check that could be added to checkpatch.
> > Since it's in Perl, I'm reluctant to try it.
> > 
> > Seems many drivers got to a point where they now call (let's say)
> > spi_set_drvdata(), but never access that information via
> > spi_get_drvdata().
> > Reasons for this seem to be:
> > 1. They got converted to device-managed functions and there is no
> > longer a remove hook to require the _get_drvdata() access
> > 2. They look like they were copied from a driver that had a
> > _set_drvdata() and when the code got finalized, the _set_drvdata() was
> > omitted
> > 
> > There are a few false positives that I can notice at a quick look,
> > like the data being set via some xxx_set_drvdata() and retrieved via a
> > dev_get_drvdata().
> 
> I can say quite a few. And this makes a difference.
> So, basically all drivers that are using PM callbacks would rather use
> dev_get_drvdata() rather than bus specific.
> 
> > I think checkpatch reporting these as well would be acceptable simply
> > from a reviewability perspective.
> > 
> > I did a shell script to quickly check these. See below.
> > It's pretty badly written but it is enough for me to gather a list.
> > And I wrote it in 5 minutes :P
> > I initially noticed this in some IIO drivers, and then I suspected
> > that this may be more widespread.
> 
> It seems more suitable for coccinelle.

To me as well.


