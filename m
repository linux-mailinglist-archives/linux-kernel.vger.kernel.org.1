Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38EDF2BA7B6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 11:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgKTKrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 05:47:19 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:54127
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725766AbgKTKrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:47:18 -0500
X-IronPort-AV: E=Sophos;i="5.78,356,1599516000"; 
   d="scan'208";a="365143387"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 11:47:15 +0100
Date:   Fri, 20 Nov 2020 11:47:15 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Robo Bot <apw@canonical.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Proposal for a new checkpatch check; matching _set_drvdata()
 & _get_drvdata()
In-Reply-To: <b74517242de5790f8ab0cd9be00a70b9ab96564c.camel@perches.com>
Message-ID: <alpine.DEB.2.22.394.2011201140480.2750@hadrien>
References: <CA+U=Dspy5+RE9agcLr6eY9DCMa1c5+++0JLeugMMBRXz4YLj1w@mail.gmail.com> <CAHp75VcT5hZH6m0Dri1h_EFjc7=4+1XoE7sRuQyfO75k9A0GKA@mail.gmail.com> <b74517242de5790f8ab0cd9be00a70b9ab96564c.camel@perches.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Nov 2020, Joe Perches wrote:

> On Thu, 2020-11-19 at 17:16 +0200, Andy Shevchenko wrote:
> > On Thu, Nov 19, 2020 at 4:09 PM Alexandru Ardelean
> > <ardeleanalex@gmail.com> wrote:
> > >
> > > Hey,
> > >
> > > So, I stumbled on a new check that could be added to checkpatch.
> > > Since it's in Perl, I'm reluctant to try it.
> > >
> > > Seems many drivers got to a point where they now call (let's say)
> > > spi_set_drvdata(), but never access that information via
> > > spi_get_drvdata().
> > > Reasons for this seem to be:
> > > 1. They got converted to device-managed functions and there is no
> > > longer a remove hook to require the _get_drvdata() access
> > > 2. They look like they were copied from a driver that had a
> > > _set_drvdata() and when the code got finalized, the _set_drvdata() was
> > > omitted
> > >
> > > There are a few false positives that I can notice at a quick look,
> > > like the data being set via some xxx_set_drvdata() and retrieved via a
> > > dev_get_drvdata().
> >
> > I can say quite a few. And this makes a difference.
> > So, basically all drivers that are using PM callbacks would rather use
> > dev_get_drvdata() rather than bus specific.
> >
> > > I think checkpatch reporting these as well would be acceptable simply
> > > from a reviewability perspective.
> > >
> > > I did a shell script to quickly check these. See below.
> > > It's pretty badly written but it is enough for me to gather a list.
> > > And I wrote it in 5 minutes :P
> > > I initially noticed this in some IIO drivers, and then I suspected
> > > that this may be more widespread.
> >
> > It seems more suitable for coccinelle.
>
> To me as well.

To me as well, since it seems to involve nonlocal information.

I'm not sure to understand the original shell script. Is there
something interesting about pci_set_drvdata?

julia
