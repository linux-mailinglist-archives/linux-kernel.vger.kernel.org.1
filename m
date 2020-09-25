Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5CB278F94
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 19:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbgIYR0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 13:26:33 -0400
Received: from smtprelay0115.hostedemail.com ([216.40.44.115]:53060 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726401AbgIYR0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 13:26:33 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id BCB401800822B;
        Fri, 25 Sep 2020 17:26:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1543:1593:1594:1605:1711:1730:1747:1777:1792:1981:2194:2199:2393:2525:2553:2560:2563:2682:2685:2691:2693:2828:2859:2893:2903:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4043:4321:4641:5007:6691:7875:7903:7974:9025:9108:10004:10394:10400:10471:10848:11232:11658:11914:12043:12050:12296:12297:12555:12679:12740:12760:12895:12986:13161:13229:13255:13439:13845:14096:14097:14181:14659:14721:21080:21324:21325:21433:21627:21740:21789:21811:21990:30054:30070:30083:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: songs62_3214a5527169
X-Filterd-Recvd-Size: 4775
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Fri, 25 Sep 2020 17:26:29 +0000 (UTC)
Message-ID: <58673398c6b836ebd7509f787e6f0d10bfd751bc.camel@perches.com>
Subject: Re: [Cocci] coccinelle: Convert comma to semicolons (was Re:
 [PATCH] checkpatch: Add test for comma use that should be semicolon)
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Valdis =?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        cocci <cocci@systeme.lip6.fr>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@shadowen.org>
Date:   Fri, 25 Sep 2020 10:26:27 -0700
In-Reply-To: <alpine.DEB.2.22.394.2009251904540.2772@hadrien>
References: <87r1qqvo2d.fsf@nanos.tec.linutronix.de>
         <a53048f738dacc1c58654eb94e229de79d4f94c2.camel@perches.com>
         <alpine.DEB.2.22.394.2009251904540.2772@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-09-25 at 19:06 +0200, Julia Lawall wrote:
> On Thu, 24 Sep 2020, Joe Perches wrote:
> > On Thu, 2020-09-24 at 23:53 +0200, Thomas Gleixner wrote:
> > > On Thu, Sep 24 2020 at 13:33, Joe Perches wrote:
> > > > On Thu, 2020-09-24 at 22:19 +0200, Thomas Gleixner wrote:
> > > > > On Sat, Aug 22 2020 at 09:07, Julia Lawall wrote:
> > > > > > On Fri, 21 Aug 2020, Joe Perches wrote:
> > > > > > > True enough for a general statement, though the coccinelle
> > > > > > > script Julia provided does not change a single instance of
> > > > > > > for loop expressions with commas.
> > > > > > > 
> > > > > > > As far as I can tell, no logic defect is introduced by the
> > > > > > > script at all.
> > > > > > 
> > > > > > The script has a rule to ensure that what is changed is part of a top
> > > > > > level statement that has the form e1, e2;.  I put that in to avoid
> > > > > > transforming cases where the comma is the body of a macro, but it protects
> > > > > > against for loop headers as well.
> > > > > 
> > > > > Right. I went through the lot and did not find something dodgy. Except
> > > > > for two hunks this still applies. Can someone please send a proper patch
> > > > > with changelog/SOB etc. for this?
> > > > 
> > > > Treewide?
> > > > 
> > > > Somebody no doubt would complain, but there
> > > > _really should_ be some mechanism for these
> > > > trivial and correct treewide changes...
> > > 
> > > There are lots of mechanisms:
> > 
> > I've tried them all.
> > 
> > None of them work particularly well,
> > especially the individual patch route.
> > 
> > >  - Andrew picks such changes up
> > 
> > Generally not treewide.
> > 
> > >  - With a few competent eyeballs on it (reviewers) this can go thorugh
> > >    the trivial tree as well. It's more than obvious after all.
> > 
> > Jiri is almost non-existent when it comes to
> > trivial treewide patches.
> > 
> > >  - Send the script to Linus with a proper change log attached and ask
> > >    him to run it.
> > 
> > Linus has concerns about backports and what he
> > deems trivialities.  Generally overblown IMO.
> > 
> > >  - In the worst case if nobody feels responsible, I'll take care.
> > 
> > If Julia doesn't send a new patch in the next few
> > days, I will do the apply, fixup and resend of hers.
> > 
> > So, you're on-deck, nearly up...
> > 
> > > All of the above is better than trying to get the attention of a
> > > gazillion of maintainters.
> > 
> > True.
> > 
> > And all of the treewide changes depend on some
> > generic acceptance of value in the type of change.
> > 
> > Some believe that comma->semicolon conversions
> > aren't useful as there isn't a logical change and
> > the compiler output wouldn't be different.
> 
> I have a script that will cut up the patches and send them to the
> appropriate maintainers, so I have no problem with that route.

I have a script that does that too.

The complaint I get about its use is
"OMG: My specific commit header style isn't followed"

And the generic individual maintainer apply rate for
each specific patch is always less than 50%.

For instance the patches that converted the comma uses
in if/do/while statements to use braces and semicolons
from a month ago:

https://lore.kernel.org/lkml/cover.1598331148.git.joe@perches.com/

29 patches, 13 applied.

Best of luck.


