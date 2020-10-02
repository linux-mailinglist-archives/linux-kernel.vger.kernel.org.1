Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2A128110F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 13:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387758AbgJBLOS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 2 Oct 2020 07:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgJBLOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 07:14:18 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC9FC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 04:14:18 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kOJ0y-0002nf-TV; Fri, 02 Oct 2020 13:14:16 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kOJ0y-0004FX-Ay; Fri, 02 Oct 2020 13:14:16 +0200
Message-ID: <87ac087154f461b6cac632bb62b92b8b94d90a67.camel@pengutronix.de>
Subject: Re: [PATCH] reset: Add reset controller API
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-usb@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
Date:   Fri, 02 Oct 2020 13:14:16 +0200
In-Reply-To: <CAHNvnFO=kH25CqrAcndVO4xTQ2pGDFi5ZHEALpFaZaGL=e_c0Q@mail.gmail.com>
References: <20201001132758.12280-1-aouledameur@baylibre.com>
         <CAHNvnFO=kH25CqrAcndVO4xTQ2pGDFi5ZHEALpFaZaGL=e_c0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amjad,

Thank you for the patch, comments below:

On Thu, 2020-10-01 at 15:55 +0200, Amjad Ouled-Ameur wrote:
> An update on the patch title, since we don't add an API but extend it,
> The title should rather be: Add a new call to the reset framework

I think it should even say what functionality is added, for example

"reset: make shared pulsed reset controls re-triggerable"

> Le jeu. 1 oct. 2020 à 15:28, Amjad Ouled-Ameur
> <aouledameur@baylibre.com> a écrit :
> > The current reset framework API does not allow to release what is done by
> > reset_control_reset(), IOW decrement triggered_count. Add the new
> > reset_control_resettable() call to do so.
> > 
> > When reset_control_reset() has been called once, the counter
> > triggered_count, in the reset framework, is incremented i.e the resource
> > under the reset is in-use and the reset should not be done again.
> > reset_control_resettable() would be the way to state that the resource is
> > no longer used and, that from the caller's perspective, the reset can be
> > fired again if necessary.
> > 
> > This patch will fix a usb suspend warning seen on the libretech-cc
> > related to the shared reset line. This warning was addressed by the
> > previously reverted commit 7a410953d1fb ("usb: dwc3: meson-g12a: fix shared
> > reset control use")
> > 
> > Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> > Reported-by: Jerome Brunet <jbrunet@baylibre.com>
> > ---
> >  drivers/reset/core.c  | 57 +++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/reset.h |  1 +
> >  2 files changed, 58 insertions(+)
> > 
> > diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> > index 01c0c7aa835c..53653d4b55c4 100644
> > --- a/drivers/reset/core.c
> > +++ b/drivers/reset/core.c
> > @@ -207,6 +207,19 @@ static int reset_control_array_reset(struct reset_control_array *resets)
> >         return 0;
> >  }
> > 
> > +static int reset_control_array_resettable(struct reset_control_array *resets)
> > +{
> > +       int ret, i;
> > +
> > +       for (i = 0; i < resets->num_rstcs; i++) {
> > +               ret = reset_control_resettable(resets->rstc[i]);
> > +               if (ret)
> > +                       return ret;
> > +       }

This is tricky, as we can't really roll back decrementing
triggered_count in case just one of those fails.

I think reset_control_array_resettable has to be open coded to first
check for errors and only then loop through all controls and decrement
their triggered_count.

> > +
> > +       return 0;
> > +}
> > +
> >  static int reset_control_array_assert(struct reset_control_array *resets)
> >  {
> >         int ret, i;
> > @@ -324,6 +337,50 @@ int reset_control_reset(struct reset_control *rstc)
> >  }
> >  EXPORT_SYMBOL_GPL(reset_control_reset);
> > 
> > +/**
> > + * reset_control_resettable - decrements triggered_count of the controlled device
> > + * @rstc: reset controller

It is more important to document the purpose of the function than the
mechanism by which it is achieved. triggered_count is an implementation
detail.

Maybe "allow shared reset line to be triggered again" or similar. 

> > + *
> > + * On a shared reset line the actual reset pulse is only triggered once for the
> > + * lifetime of the reset_control instance, except if this function is used.
> > + * In fact, It decrements triggered_count that makes sure of not allowing
> > + * a reset if triggered_count is not null.
> > + *
> > + * This is a no-op in case triggered_count is already null i.e shared reset line
> > + * is ready to be triggered.

This is not a good idea IMHO. It would be better to document that calls
to this function must be balanced with calls to reset_control_reset, and
then throw a big warning below in case deassert_count ever dips below 0.

Otherwise nothing stops drivers from silently decrementing other
driver's trigger count by accidentally calling this multiple times.

> > + *
> > + * Consumers must not use reset_control_(de)assert on shared reset lines when
> > + * reset_control_reset has been used.
> > + *
> > + * If rstc is NULL it is an optional clear and the function will just
> > + * return 0.
> > + */
> > +int reset_control_resettable(struct reset_control *rstc)
> > +{
> > +       if (!rstc)
> > +               return 0;
> > +
> > +       if (WARN_ON(IS_ERR(rstc)))
> > +               return -EINVAL;
> > +
> > +       if (reset_control_is_array(rstc))
> > +               return reset_control_array_resettable(rstc_to_array(rstc));
> > +
> > +       if (rstc->shared) {
> > +               if (WARN_ON(atomic_read(&rstc->deassert_count) != 0))
> > +                       return -EINVAL;
> > +
> > +               if (atomic_read(&rstc->triggered_count) > 0)
> > +                       atomic_dec(&rstc->triggered_count);

I think this should be

		WARN_ON(atomic_dec_return(&rstc->triggered_count) < 0);

regards
Philipp
