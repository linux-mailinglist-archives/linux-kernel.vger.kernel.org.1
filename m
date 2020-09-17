Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CA826E322
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgIQSE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgIQSCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:02:51 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2EBC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 11:02:49 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w2so2826932wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 11:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VMjGHIdZoN2oxghKfwIVedc2rc75vIEU71EGKBKi4Vw=;
        b=Rw4H1am04yaRpFiTHOynRZlFoGtQnCuPQuwrQzRGIF6J323Ni+X4epQdP8RPddNlW6
         rBkbIxfyjT2Fnqv+qsog+PE6vumYuQcGK9GAQ68o31h76ft64UNz+J6Egx34Uou0gL5Z
         wk6fLnKW65+lJ4i527oHJy4TGXWyNKPwKnRQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VMjGHIdZoN2oxghKfwIVedc2rc75vIEU71EGKBKi4Vw=;
        b=gvmiCEgEh3CJ7b0kvAExjKDCEAtOSLo55FNGaim0rn5klQWG07XCxy5HJaRFlD3C3h
         Yw/eNsHUKSIbQ1mkFqp+Qts1vaj6BDftewNPDRF2qpPze+RSQHL+NQUYYJkn7UhaBMeK
         M4UcfLxflNFZyxUKKJMYizbG7b0kvDGcwBWqZUWHWxmvIz1dpCaZIKaMm4NAiWiyUg2M
         +rwq6qVubLjtImZeFUw2j/zRivEurgDgG8JrUcGpLKD/O2cdvV/OPnx2Lw7HRJTzeAMC
         a0bywLCqA8+dE62spkMuDJMqo8BFxnHv/zrRtc/fNyAydAh7tYNwk9PrRXX8HpLwhTa4
         IImA==
X-Gm-Message-State: AOAM532TZxLXwOTRjVk1HUJb3PrHP97YjNQFr4vB89GuQx/qncirBkZI
        /ePdX02pmrjJhi4wNg0zJNF4NNoNn6wX8eYVJ7vWlQ==
X-Google-Smtp-Source: ABdhPJwK3mtEBCJ+znIVX4TRVKA++GpeRR4CpX/gV4dLL6lJ47pX6bzp/5So/xiQBELnrZ9ehGsMeKaPsbyIityIEg0=
X-Received: by 2002:a1c:408a:: with SMTP id n132mr10890855wma.45.1600365768299;
 Thu, 17 Sep 2020 11:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200824204002.45500-1-james.quinlan@broadcom.com> <32b000b801202c3d6318da6c5bc52d47ab6947e0.camel@pengutronix.de>
In-Reply-To: <32b000b801202c3d6318da6c5bc52d47ab6947e0.camel@pengutronix.de>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Thu, 17 Sep 2020 14:02:36 -0400
Message-ID: <CA+-6iNwSS0U7zga2WEoWw48bHtOzWzSppKPGV8KEthnNnasH-w@mail.gmail.com>
Subject: Re: [PATCH v1] ata: ahci_brcm: Fix use of BCM7216 reset controller
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jens Axboe <axboe@kernel.dk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 4:16 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> On Mon, 2020-08-24 at 16:40 -0400, Jim Quinlan wrote:
> > From: Jim Quinlan <jquinlan@broadcom.com>
> >
> > A reset controller "rescal" is shared between the AHCI driver and the PCIe
> > driver for the BrcmSTB 7216 chip.  Use
> > devm_reset_control_get_optional_shared() to handle this sharing.
> >
> > Fixes: 272ecd60a636 ("ata: ahci_brcm: BCM7216 reset is self de-asserting")
> > Fixes: c345ec6a50e9 ("ata: ahci_brcm: Support BCM7216 reset controller name")
> > Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> > ---
> >  drivers/ata/ahci_brcm.c | 11 +++--------
> >  1 file changed, 3 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
> > index 6853dbb4131d..d6115bc04b09 100644
> > --- a/drivers/ata/ahci_brcm.c
> > +++ b/drivers/ata/ahci_brcm.c
> > @@ -428,7 +428,6 @@ static int brcm_ahci_probe(struct platform_device *pdev)
> >  {
> >       const struct of_device_id *of_id;
> >       struct device *dev = &pdev->dev;
> > -     const char *reset_name = NULL;
> >       struct brcm_ahci_priv *priv;
> >       struct ahci_host_priv *hpriv;
> >       struct resource *res;
> > @@ -452,11 +451,10 @@ static int brcm_ahci_probe(struct platform_device *pdev)
> >
> >       /* Reset is optional depending on platform and named differently */
> >       if (priv->version == BRCM_SATA_BCM7216)
> > -             reset_name = "rescal";
> > +             priv->rcdev = devm_reset_control_get_optional_shared(&pdev->dev, "rescal");
> >       else
> > -             reset_name = "ahci";
> > +             priv->rcdev = devm_reset_control_get_optional(&pdev->dev, "ahci");
>
> I think it would be cleaner to use two separate reset control handles
> here. It is hard to reason about what the code does when the reset
> control is shared on one platform and exclusive on the other.
>
> > -     priv->rcdev = devm_reset_control_get_optional(&pdev->dev, reset_name);
> >       if (IS_ERR(priv->rcdev))
> >               return PTR_ERR(priv->rcdev);
> >
> > @@ -479,10 +477,7 @@ static int brcm_ahci_probe(struct platform_device *pdev)
> >               break;
> >       }
> >
> > -     if (priv->version == BRCM_SATA_BCM7216)
> > -             ret = reset_control_reset(priv->rcdev);
>
> I think we might have a similar issue currently with
> "usb: dwc3: meson-g12a: fix shared reset control use", where two IP
> cores try to share a pulsed reset line.
>
> > -     else
> > -             ret = reset_control_deassert(priv->rcdev);
> > +     ret = reset_control_deassert(priv->rcdev);
>
> Isn't the shared 'rescal' reset a triggered reset pulse? Looking at the
> reset-brcmstb-rescal reset controller driver, without reset line level
> control implemented, this will turn into a no-op for BCM7216. Yes, the
> reset line will be deasserted after this call, but there is no guarantee
> that the reset line was ever pulsed.

Hi Philipp,

I believe you have observed that our reset-brcmstb-rescal.c driver
sets only the "reset" op and implements a pulse when called (it's
actually more of a "start the engine" operation).  This suits us fine
except such a driver can only fire its reset once in its lifetime.  We
would actually like a "new lifetime" when we emerge from resume()
after being suspended.  This would probably require a modification to
core.c to set triggered_count to 0 on resume_early time.  My instincts
say this approach would upset some apple carts.

What we could do instead is use the deassert op instead of the reset
op so that the pulse and be activated on probe and every time we
resume().

Are you okay with that?

Thanks,
Jim
>
> regards
> Philipp
