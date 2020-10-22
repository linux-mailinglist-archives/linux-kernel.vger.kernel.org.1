Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF988295651
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 04:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894972AbgJVCVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 22:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2894966AbgJVCVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 22:21:19 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9EEC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 19:21:19 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id s21so166098oij.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 19:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ubAi3rBrtdzXL869KERynnLnwRD0Qs9+rarRmKHfSPM=;
        b=WhKUzyxcoDDVdx5pPCbPp0upWI1eQBpR59+we54m7jVAi3XPmUZcFy2KNHTe8/Bt1K
         00bRuYLOkRUVl9JthNKKxz6PUP4k4wGZbJQprYj6WdQxNQ7BYcteCXi/1G/0gE2+k21p
         CpjsJs2AlTTwrBcn7gaoCNHNsOvxzVXhg5T6PvQrettdeJpCUbeb5Bo9fGnYwFPjN78+
         qgQEk1rMLtFgxVkFZh/54DikaGaysH2Vio2c/hLVWFaE2oH3p3tflnkh6ywtARU5Hcyp
         vpKxecc5fNxdpvm/A/g1f7xh1Fb2RmSIVeNvfDQSTcGnSSyOg00gBoLHwFq86woKyccZ
         9KMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ubAi3rBrtdzXL869KERynnLnwRD0Qs9+rarRmKHfSPM=;
        b=tZWaDxKbuKru3JwFMtmLWkr/9pQ0dZNOrXep7KLJfidcQMASjSt0grXEWDWKSePMFi
         ae4fZ2AVuA137Qr1HNGPK9s725/k1y363M0q1ZPjWNwOpKM26K39pzqMC8AlwcDwK1d7
         6kELnkRonx98kzFm6oBWS2I5n8unkCMAI0vP7mVg/7tRgDf4ry0FbJIUHg9YfjhqV72F
         9npJ845cMn+QU00cZXYMwZQA/8yEHBsoNKbHYsbUnqmQRBcmBtFVmyjd2DKDTPiTco9/
         Asmno+qjnwa3UBJVX2QieRTaW0bGes2GckWGQh5LtXY6Z+3pJhKXPQB3Hi/xlXU41xGe
         O1lQ==
X-Gm-Message-State: AOAM532nS+bAqXtb54Y4xisPSnFKQOFOkb3CeCx77NLnBeursVjoN5Mc
        Mp6ozhocbeOJAgoE10sFsCdlaI5d54+oqFB+/0m+NQ==
X-Google-Smtp-Source: ABdhPJwhMv1WcYFKossdaXy07p4bNvebNrwEbw2Er4FqmmQfqj7iB1xQTPQfabU0uw+Ev7JXSWFGlf/uhDxLNqld59s=
X-Received: by 2002:a05:6808:578:: with SMTP id j24mr119875oig.10.1603333278313;
 Wed, 21 Oct 2020 19:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <20201021224619.20796-1-john.stultz@linaro.org> <d9c241a5-f31b-b044-bc15-1c5e4d445a69@synopsys.com>
In-Reply-To: <d9c241a5-f31b-b044-bc15-1c5e4d445a69@synopsys.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 21 Oct 2020 19:21:06 -0700
Message-ID: <CALAqxLX30jZvHdpMyPMwJUXzMP9EJRaW-vo9x2gkEvqxSKZaZA@mail.gmail.com>
Subject: Re: [PATCH v2] usb: dwc3: Trigger a GCTL soft reset when switching
 modes in DRD
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     lkml <linux-kernel@vger.kernel.org>, Yu Chen <chenyu56@huawei.com>,
        Felipe Balbi <balbi@kernel.org>,
        Tejas Joglekar <Tejas.Joglekar@synopsys.com>,
        Yang Fei <fei.yang@intel.com>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 6:17 PM Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:
>
> John Stultz wrote:
> > From: Yu Chen <chenyu56@huawei.com>
> >
> > With the current dwc3 code on the HiKey960 we often see the
> > COREIDLE flag get stuck off in __dwc3_gadget_start(), which
> > seems to prevent the reset irq and causes the USB gadget to
> > fail to initialize.
> >
> > We had seen occasional initialization failures with older
> > kernels but with recent 5.x era kernels it seemed to be becoming
> > much more common, so I dug back through some older trees and
> > realized I dropped this quirk from Yu Chen during upstreaming
> > as I couldn't provide a proper rational for it and it didn't
> > seem to be necessary. I now realize I was wrong.
> >
> > After resubmitting the quirk Thinh Nguyen pointed out that it
> > shouldn't be a quirk and it is actually mentioned in the
> > programming guide that it should be done when switching modes
> > in DRD.
> >
> > So, to avoid these !COREIDLE lockups seen on HiKey960, this
> > patch issues GCTL soft reset when switching modes if the
> > controller is in DRD mode.
> >
> > Cc: Felipe Balbi <balbi@kernel.org>
> > Cc: Tejas Joglekar <tejas.joglekar@synopsys.com>
> > Cc: Yang Fei <fei.yang@intel.com>
> > Cc: YongQin Liu <yongqin.liu@linaro.org>
> > Cc: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> > Cc: Thinh Nguyen <thinhn@synopsys.com>
> > Cc: Jun Li <lijun.kernel@gmail.com>
> > Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: linux-usb@vger.kernel.org
> > Signed-off-by: Yu Chen <chenyu56@huawei.com>
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > ---
> > v2:
> > * Rework to always call the GCTL soft reset in DRD mode,
> >   rather then using a quirk as suggested by Thinh Nguyen
> >
> > ---
> >  drivers/usb/dwc3/core.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index bdf0925da6b6..ca94f3a2a83c 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -114,10 +114,24 @@ void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
> >       dwc->current_dr_role = mode;
> >  }
> >
> > +static void dwc3_gctl_core_soft_reset(struct dwc3 *dwc)
> > +{
> > +     int reg;
> > +
> > +     reg = dwc3_readl(dwc->regs, DWC3_GCTL);
> > +     reg |= (DWC3_GCTL_CORESOFTRESET);
> > +     dwc3_writel(dwc->regs, DWC3_GCTL, reg);
> > +
> > +     reg = dwc3_readl(dwc->regs, DWC3_GCTL);
> > +     reg &= ~(DWC3_GCTL_CORESOFTRESET);
> > +     dwc3_writel(dwc->regs, DWC3_GCTL, reg);
> > +}
> > +
> >  static void __dwc3_set_mode(struct work_struct *work)
> >  {
> >       struct dwc3 *dwc = work_to_dwc(work);
> >       unsigned long flags;
> > +     int hw_mode;
> >       int ret;
> >       u32 reg;
> >
> > @@ -154,6 +168,11 @@ static void __dwc3_set_mode(struct work_struct *work)
> >               break;
> >       }
> >
> > +     /* Execute a GCTL Core Soft Reset when switch mode in DRD*/
> > +     hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
> > +     if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD)
> > +             dwc3_gctl_core_soft_reset(dwc);
> > +
>
> I think this should be done inside the spin_lock.
>
> >       spin_lock_irqsave(&dwc->lock, flags);
> >
> >       dwc3_set_prtcap(dwc, dwc->desired_dr_role);
>
> The DRD mode change sequence should be like this if we want to switch
> from host -> device according to the programming guide (for all DRD IPs):
> 1. Reset controller with GCTL.CoreSoftReset
> 2. Set GCTL.PrtCapDir(device)
> 3. Soft reset with DCTL.CSftRst
> 4. Then follow up with the initializing registers sequence
>
> However, from code review, with this patch, it follows this sequence:
> a. Soft reset with DCTL.CSftRst on driver probe
> b. Reset controller with GCTL.CoreSoftReset
> c. Set GCTL.PrtCapDir(device)
> d. < missing DCTL.CSftRst >
> e. Then follow up with initializing registers sequence
>
> It may work, but it doesn't follow the programming guide.

Much appreciated for the guidance here. I don't believe I have access
to the programming guide (unless its publicly available somewhere?),
so I'm just working with what I can experimentally figure out and
vendor patch history.

So I'll try to translate the above into the driver as best I can, but
again, I really appreciate your review and corrections here!

thanks
-john
