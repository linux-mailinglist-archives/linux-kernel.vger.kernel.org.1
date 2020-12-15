Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E773E2DA981
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 09:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgLOIxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 03:53:19 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:55109 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726982AbgLOIxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 03:53:18 -0500
X-IronPort-AV: E=Sophos;i="5.78,420,1599516000"; 
   d="scan'208";a="483005226"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 09:52:36 +0100
Date:   Tue, 15 Dec 2020 09:52:36 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Maxime Ripard <maxime@cerno.tech>
cc:     Wolfram Sang <wsa@the-dreams.de>, michal.lkml@markovi.net,
        Gilles.Muller@lip6.fr, Mark Brown <broonie@kernel.org>,
        nicolas.palix@imag.fr, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] coccinnelle: Remove ptr_ret script
In-Reply-To: <20201215084823.towbaqay5tgdh7dw@gilmour>
Message-ID: <alpine.DEB.2.22.394.2012150950440.2879@hadrien>
References: <20200107073629.325249-1-maxime@cerno.tech> <alpine.DEB.2.21.2001071106420.3004@hadrien> <20200107102954.GB1135@ninjato> <20201215084823.towbaqay5tgdh7dw@gilmour>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 Dec 2020, Maxime Ripard wrote:

> Hi,
>
> On Tue, Jan 07, 2020 at 11:29:54AM +0100, Wolfram Sang wrote:
> > On Tue, Jan 07, 2020 at 11:06:56AM +0100, Julia Lawall wrote:
> > >
> > >
> > > On Tue, 7 Jan 2020, Maxime Ripard wrote:
> > >
> > > > The ptr_ret script script addresses a number of situations where we end up
> > > > testing an error pointer, and if it's an error returning it, or return 0
> > > > otherwise to transform it into a PTR_ERR_OR_ZERO call.
> > > >
> > > > So it will convert a block like this:
> > > >
> > > > if (IS_ERR(err))
> > > >     return PTR_ERR(err);
> > > >
> > > > return 0;
> > > >
> > > > into
> > > >
> > > > return PTR_ERR_OR_ZERO(err);
> > > >
> > > > While this is technically correct, it has a number of drawbacks. First, it
> > > > merges the error and success path, which will make it harder for a reviewer
> > > > or reader to grasp.
> > > >
> > > > It's also more difficult to extend if we were to add some code between the
> > > > error check and the function return, making the author essentially revert
> > > > that patch before adding new lines, while it would have been a trivial
> > > > addition otherwise for the rewiever.
> > > >
> > > > Therefore, since that script is only about cosmetic in the first place,
> > > > let's remove it since it's not worth it.
> > > >
> > > > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > > > Cc: Mark Brown <broonie@kernel.org>
> > > > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > >
> > > Acked-by: Julia Lawall <julia.lawall@inria.fr>
> >
> > Convincing patch description, good catch!
> >
> > Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> It looks like this patch was never applied, whose tree should it go
> through?

Sorry.  I can take it.  I'm not sure that I still have the original
message, though.  If you have it handy, that would be helpful.

julia
