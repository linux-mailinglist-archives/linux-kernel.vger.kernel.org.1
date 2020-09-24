Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCF3277B97
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 00:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgIXWXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 18:23:43 -0400
Received: from smtprelay0172.hostedemail.com ([216.40.44.172]:45502 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726280AbgIXWXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 18:23:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 67C1118224D82;
        Thu, 24 Sep 2020 22:23:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:1981:2110:2194:2199:2393:2553:2559:2562:2691:2693:2828:2893:2903:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:4641:5007:6691:7875:7903:7974:10004:10394:10400:10471:10848:11232:11658:11914:12050:12296:12297:12740:12760:12895:13161:13229:13255:13439:14096:14097:14659:14721:21080:21324:21325:21433:21627:21740:21789:21990:30054:30070:30083:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: space69_45180fb27162
X-Filterd-Recvd-Size: 3682
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Thu, 24 Sep 2020 22:23:40 +0000 (UTC)
Message-ID: <a53048f738dacc1c58654eb94e229de79d4f94c2.camel@perches.com>
Subject: Re: [Cocci] coccinelle: Convert comma to semicolons (was Re:
 [PATCH] checkpatch: Add test for comma use that should be semicolon)
From:   Joe Perches <joe@perches.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Julia Lawall <julia.lawall@inria.fr>
Cc:     Valdis =?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        cocci <cocci@systeme.lip6.fr>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@shadowen.org>
Date:   Thu, 24 Sep 2020 15:23:39 -0700
In-Reply-To: <87r1qqvo2d.fsf@nanos.tec.linutronix.de>
References: <87r1qqvo2d.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-09-24 at 23:53 +0200, Thomas Gleixner wrote:
> On Thu, Sep 24 2020 at 13:33, Joe Perches wrote:
> > On Thu, 2020-09-24 at 22:19 +0200, Thomas Gleixner wrote:
> > > On Sat, Aug 22 2020 at 09:07, Julia Lawall wrote:
> > > > On Fri, 21 Aug 2020, Joe Perches wrote:
> > > > > True enough for a general statement, though the coccinelle
> > > > > script Julia provided does not change a single instance of
> > > > > for loop expressions with commas.
> > > > > 
> > > > > As far as I can tell, no logic defect is introduced by the
> > > > > script at all.
> > > > 
> > > > The script has a rule to ensure that what is changed is part of a top
> > > > level statement that has the form e1, e2;.  I put that in to avoid
> > > > transforming cases where the comma is the body of a macro, but it protects
> > > > against for loop headers as well.
> > > 
> > > Right. I went through the lot and did not find something dodgy. Except
> > > for two hunks this still applies. Can someone please send a proper patch
> > > with changelog/SOB etc. for this?
> > 
> > Treewide?
> > 
> > Somebody no doubt would complain, but there
> > _really should_ be some mechanism for these
> > trivial and correct treewide changes...
> 
> There are lots of mechanisms:

I've tried them all.

None of them work particularly well,
especially the individual patch route.

>  - Andrew picks such changes up

Generally not treewide.

>  - With a few competent eyeballs on it (reviewers) this can go thorugh
>    the trivial tree as well. It's more than obvious after all.

Jiri is almost non-existent when it comes to
trivial treewide patches.

>  - Send the script to Linus with a proper change log attached and ask
>    him to run it.

Linus has concerns about backports and what he
deems trivialities.  Generally overblown IMO.

>  - In the worst case if nobody feels responsible, I'll take care.

If Julia doesn't send a new patch in the next few
days, I will do the apply, fixup and resend of hers.

So, you're on-deck, nearly up...

> All of the above is better than trying to get the attention of a
> gazillion of maintainters.

True.

And all of the treewide changes depend on some
generic acceptance of value in the type of change.

Some believe that comma->semicolon conversions
aren't useful as there isn't a logical change and
the compiler output wouldn't be different.

Anyway, cheers, Joe


