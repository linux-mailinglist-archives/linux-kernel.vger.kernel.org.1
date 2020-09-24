Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B708F277A15
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 22:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgIXUVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 16:21:44 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:45851
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725208AbgIXUVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 16:21:43 -0400
X-IronPort-AV: E=Sophos;i="5.77,299,1596492000"; 
   d="scan'208";a="359990934"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 22:21:39 +0200
Date:   Thu, 24 Sep 2020 22:21:38 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     Joe Perches <joe@perches.com>,
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
In-Reply-To: <87tuvn6i88.fsf@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.22.394.2009242221020.2615@hadrien>
References: <20200818184107.f8af232fb58b17160c570874@linux-foundation.org> <3bf27caf462007dfa75647b040ab3191374a59de.camel@perches.com> <b0fd63e4b379eda69ee85ab098353582b8c054bb.camel@perches.com> <alpine.DEB.2.22.394.2008201021400.2524@hadrien>
 <a5713d8597065ef986f780499428fcc4cd31c003.camel@perches.com> <alpine.DEB.2.22.394.2008201856110.2524@hadrien> <744af177c09f8ce22c99d6e1df458bced558518b.camel@perches.com> <162653.1598067338@turing-police> <3836b482434bd0b9a609959d3696cc6113a93f2f.camel@perches.com>
 <alpine.DEB.2.22.394.2008220905460.3150@hadrien> <87tuvn6i88.fsf@nanos.tec.linutronix.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 24 Sep 2020, Thomas Gleixner wrote:

> On Sat, Aug 22 2020 at 09:07, Julia Lawall wrote:
> > On Fri, 21 Aug 2020, Joe Perches wrote:
> >> True enough for a general statement, though the coccinelle
> >> script Julia provided does not change a single instance of
> >> for loop expressions with commas.
> >>
> >> As far as I can tell, no logic defect is introduced by the
> >> script at all.
> >
> > The script has a rule to ensure that what is changed is part of a top
> > level statement that has the form e1, e2;.  I put that in to avoid
> > transforming cases where the comma is the body of a macro, but it protects
> > against for loop headers as well.
>
> Right. I went through the lot and did not find something dodgy. Except
> for two hunks this still applies. Can someone please send a proper patch
> with changelog/SOB etc. for this?
>
> And of course that script really wants to be part of the kernel cocci
> checks to catch further instances.

I will try to get to it soon.  Thanks for checking all the cases.

julia


>
> Thanks,
>
>         tglx
>
