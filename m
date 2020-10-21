Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D53B295444
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 23:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506228AbgJUVdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 17:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506220AbgJUVdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 17:33:53 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F44CC0613D2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 14:33:53 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id t15so3268135otk.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 14:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XCjYvUCIgbQ3TCtD4YfecFPhaqfiZUwN7ivTobgZQY0=;
        b=lx4WkpT2GzaDerBpdUAWiK7Fk5vr7DQ65sS1KJ5w9QzgSXXyi1BcdYVoDIaXXrWft2
         yC4htW78VmVnZz6BIcXn5NCdHwKSfCMa2P2uw8B6RVUVzzpTYLAkcOgy0f4LhDikDhh4
         O+fIkWJPhWeQac0XW7kwgXkButPH3W8HhOQujJC2+2w+GIMEFkmYYHWeYHQFLeiO3iyZ
         ED/m5VEzlWFv5k7F3+aVCm3m4XX9wEK0lxjyR/0+e9IXmZ56qWY3SP3CJw3s6T5PoRWf
         1E0u6XOCinCRV31hLekEZJjzyNArUBgyoR0GBWhujH6Nl5x7JGF1zMbK/GCMHbte2Ei7
         mb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XCjYvUCIgbQ3TCtD4YfecFPhaqfiZUwN7ivTobgZQY0=;
        b=aO1QIz8wjRNJYpfUpW40QjIXfDkCrJguUcDyRqOFw/VPR4bYC81PGawAUmTthBjkXR
         eLnmY/7IUuIoDYcZNvm7u0i+GM4eGdaHZobR4af7iXabU2GkKNk4ySZb47NomCiahbi6
         l5nJSI0NkdpzC39wJobhNZtXqWHuG3kyNgYvMISjVh1dWk01d2rASxC2wK+yOowBffTO
         3UelwXwywPkLDFxwsIrzYkKXELMblCyLyJKq1v2Jmr+iGINemVCQz7/PS/3YiuNarmCL
         6BvkkEpmLDHBNeWJCxf9BfIBXuHkR4VNUX+v5YCn5AVeAWYG9YPAseNjSYtZacAjhmjy
         8pNg==
X-Gm-Message-State: AOAM532drQWZgcURoTwKZBnL5UBVraM+AmTY8iWGOPOEt/cCJH48iEUi
        jPeNHf4EizIkBQGR2rnwL4Mt3JQd2Bt0RCf49YkZMA==
X-Google-Smtp-Source: ABdhPJxQft8N8pQfRzj0OP/DL2xjFlTkw1NWDG+V/uw4WSqVGubKlth/Yii+jjfy9m4PYJyes8XdUPNOygcqb5fQfrI=
X-Received: by 2002:a05:6830:1558:: with SMTP id l24mr2909744otp.352.1603316032781;
 Wed, 21 Oct 2020 14:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201021181803.79650-1-john.stultz@linaro.org> <77de4aaa-14a5-6078-bd0b-c4942e97ab36@synopsys.com>
In-Reply-To: <77de4aaa-14a5-6078-bd0b-c4942e97ab36@synopsys.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 21 Oct 2020 14:33:41 -0700
Message-ID: <CALAqxLVyszFbOnWAOMekQuWbGgmMZpEfFiY6gyAPYmGXPz5sHA@mail.gmail.com>
Subject: Re: [RFC][PATCH] usb: dwc3: Add quirk to trigger a GCTL soft reset
 for Hisilicon Kirin Soc Platform
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     lkml <linux-kernel@vger.kernel.org>, Yu Chen <chenyu56@huawei.com>,
        Felipe Balbi <balbi@kernel.org>,
        Tejas Joglekar <Tejas.Joglekar@synopsys.com>,
        Yang Fei <fei.yang@intel.com>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 12:14 PM Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:
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
> > On the upside, I can now understand more why such a quirk is
> > needed.
>
> This shouldn't be a quirk. It's part of the programming guide when
> switching mode in DRD. I don't know how we missed this.

Ah! That's great, as it should simplify the patch a bit and avoid
introducing another dt bindings!


> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index bdf0925da6b6..b138c67e3892 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -114,6 +114,19 @@ void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
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
> > @@ -178,6 +191,10 @@ static void __dwc3_set_mode(struct work_struct *work)
> >               }
> >               break;
> >       case DWC3_GCTL_PRTCAP_DEVICE:
> > +             /* Execute a GCTL Core Soft Reset when switch mode */
> > +             if (dwc->gctl_reset_quirk)
> > +                     dwc3_gctl_core_soft_reset(dwc);
> > +
>
> This should be done before dwc3_set_prtcap(), and this applies when
> switching from device to host mode also. Make sure to check if the
> controller is DRD before doing this.

Sorry, by checking that the controller is DRD, I'm not sure exactly
what you mean.
Checking DWC3_GHWPARAMS0_MODE_DRD?  Or something else?

Thanks so much for the review and feedback!
-john
