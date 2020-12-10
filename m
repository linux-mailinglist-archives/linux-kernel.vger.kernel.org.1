Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0207C2D5C1E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 14:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389313AbgLJNlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 08:41:18 -0500
Received: from smtprelay0062.hostedemail.com ([216.40.44.62]:42830 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389278AbgLJNlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 08:41:18 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 612FA837F253;
        Thu, 10 Dec 2020 13:40:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2693:2828:2829:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4022:4321:5007:6119:7576:7903:10004:10400:10450:10455:10848:11232:11658:11914:12043:12295:12297:12740:12895:13019:13069:13095:13161:13229:13311:13357:13439:13846:13894:14096:14097:14180:14181:14659:14721:14777:19904:19999:21060:21080:21433:21627:21881:21939:30012:30026:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: help02_100b57b273f8
X-Filterd-Recvd-Size: 2625
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Thu, 10 Dec 2020 13:40:36 +0000 (UTC)
Message-ID: <8ee5b1f0eaec9c71066027e4e130d473fe6532d7.camel@perches.com>
Subject: Re: checkpatch
From:   Joe Perches <joe@perches.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 10 Dec 2020 05:40:35 -0800
In-Reply-To: <32a8677e1bcf4d69ba019bfcefc9ea59@AcuMS.aculab.com>
References: <87zh2mzw3h.fsf@nanos.tec.linutronix.de>
         <aea0efa93c17e431205eeb932a73efa7e21598a3.camel@perches.com>
         <32a8677e1bcf4d69ba019bfcefc9ea59@AcuMS.aculab.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-12-10 at 09:34 +0000, David Laight wrote:
> From: Joe Perches
> > Sent: 10 December 2020 05:26
> > 
> > On Wed, 2020-12-09 at 19:13 +0100, Thomas Gleixner wrote:
> > > Joe,
> > 
> > Hi Thomas.
> > 
> > > the below made it through my filters for some reason so I actually
> > > looked and immediately wondered why checkpatch.pl did not identify this
> > > as pure garbage.
> > > 
> > >  Original mail is here: lore.kernel.org/r/69cb540a-09d5-4956-b062-071ccded7090@web.de
> > > 
> > > Can you have a look please? Adding brackets in the middle of the code
> > > for absolutely no reason is wrong to begin with and then not indenting
> > > the enclosed code makes it even worse.
> > 
> > Well, maybe something like this, but there are probably some
> > drawbacks with initializations.
> 
> Isn't the other likely problem where an extra code block
> is being squeezed in after a case label without generating
> a double-indent.

Probably not.

A common form for a case label with a brace is like the below
where the code is indented.  There aren't many uses where the
code for the case is at the same indent level as the case.

	case foo:
	{
		definitions;
		code;
		break;
	}

Another puts the break at the same indent as the case.

	case foo:
	{
		definitions;
		code;
	}
	break;

The other form that's used with case statements have the brace
on the line with the case:

	case foo: {
		definitions;
		code;
		break;
	}

There are some uses where the open brace is on a separate
line like the below, but checkpatch already emits a message
like "open brace should be on the previous line" for it.
Now another message will be emitted for the open brace.

	switch (foo)
	{
	case bar:



