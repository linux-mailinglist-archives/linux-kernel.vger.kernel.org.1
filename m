Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B089A278F57
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 19:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbgIYRGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 13:06:30 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:53315
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727812AbgIYRGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 13:06:30 -0400
X-IronPort-AV: E=Sophos;i="5.77,302,1596492000"; 
   d="scan'208";a="360082879"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 19:06:21 +0200
Date:   Fri, 25 Sep 2020 19:06:20 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        cocci <cocci@systeme.lip6.fr>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@shadowen.org>
Subject: Re: [Cocci] coccinelle: Convert comma to semicolons (was Re: [PATCH]
 checkpatch: Add test for comma use that should be semicolon)
In-Reply-To: <a53048f738dacc1c58654eb94e229de79d4f94c2.camel@perches.com>
Message-ID: <alpine.DEB.2.22.394.2009251904540.2772@hadrien>
References: <87r1qqvo2d.fsf@nanos.tec.linutronix.de> <a53048f738dacc1c58654eb94e229de79d4f94c2.camel@perches.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 24 Sep 2020, Joe Perches wrote:

> On Thu, 2020-09-24 at 23:53 +0200, Thomas Gleixner wrote:
> > On Thu, Sep 24 2020 at 13:33, Joe Perches wrote:
> > > On Thu, 2020-09-24 at 22:19 +0200, Thomas Gleixner wrote:
> > > > On Sat, Aug 22 2020 at 09:07, Julia Lawall wrote:
> > > > > On Fri, 21 Aug 2020, Joe Perches wrote:
> > > > > > True enough for a general statement, though the coccinelle
> > > > > > script Julia provided does not change a single instance of
> > > > > > for loop expressions with commas.
> > > > > >
> > > > > > As far as I can tell, no logic defect is introduced by the
> > > > > > script at all.
> > > > >
> > > > > The script has a rule to ensure that what is changed is part of a top
> > > > > level statement that has the form e1, e2;.  I put that in to avoid
> > > > > transforming cases where the comma is the body of a macro, but it protects
> > > > > against for loop headers as well.
> > > >
> > > > Right. I went through the lot and did not find something dodgy. Except
> > > > for two hunks this still applies. Can someone please send a proper patch
> > > > with changelog/SOB etc. for this?
> > >
> > > Treewide?
> > >
> > > Somebody no doubt would complain, but there
> > > _really should_ be some mechanism for these
> > > trivial and correct treewide changes...
> >
> > There are lots of mechanisms:
>
> I've tried them all.
>
> None of them work particularly well,
> especially the individual patch route.
>
> >  - Andrew picks such changes up
>
> Generally not treewide.
>
> >  - With a few competent eyeballs on it (reviewers) this can go thorugh
> >    the trivial tree as well. It's more than obvious after all.
>
> Jiri is almost non-existent when it comes to
> trivial treewide patches.
>
> >  - Send the script to Linus with a proper change log attached and ask
> >    him to run it.
>
> Linus has concerns about backports and what he
> deems trivialities.  Generally overblown IMO.
>
> >  - In the worst case if nobody feels responsible, I'll take care.
>
> If Julia doesn't send a new patch in the next few
> days, I will do the apply, fixup and resend of hers.
>
> So, you're on-deck, nearly up...
>
> > All of the above is better than trying to get the attention of a
> > gazillion of maintainters.
>
> True.
>
> And all of the treewide changes depend on some
> generic acceptance of value in the type of change.
>
> Some believe that comma->semicolon conversions
> aren't useful as there isn't a logical change and
> the compiler output wouldn't be different.

I have a script that will cut up the patches and send them to the
appropriate maintainers, so I have no problem with that route.

julia
