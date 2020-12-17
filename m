Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D4B2DCB5F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 04:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgLQDoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 22:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbgLQDoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 22:44:02 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B174C061794;
        Wed, 16 Dec 2020 19:43:22 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id v2so645674pfm.9;
        Wed, 16 Dec 2020 19:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tkZdULlUHpCTLPPLnvYRioU35Xl4oRXIiOGWSipJOsk=;
        b=naJK+sF6BTWwx2gI+Fp66YCAll/8W/IjZ7maOeoXiGnYRhT7yJu0VFGdnprp0DZ06H
         mM+yGyD9z0lVF9t1mR7k0WZOaCfeWcDuh2cc9UYyAZoeYI/oPIPVXpwjusP63QyVyRSn
         xjuPwyi7OZxJ4Lq20qCAh+8RBOPcmYnJanST8fZneUCjiaZEPKRdfg2Nkzi4CKmN4mFQ
         AlamZkC9vNZRlUGMpkhtSenWeJFzVGv9b6GtffaguFjJrOqHW80bBPoue2jOCnkmd1b4
         9fkc6FycbqaoZLI28ocEaXAon5yvjDusDP+pSMWpGCLzcrP/pZpGnyKALPEyHSsyhnrt
         EpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tkZdULlUHpCTLPPLnvYRioU35Xl4oRXIiOGWSipJOsk=;
        b=Ejfxsv2syMKaLBrTsGPkcFGB0lZnI77qLSpwXDrZ7TUvo7MpvY/79qO3nYRqAHOrsE
         iQoTwDz3gt715UnWHFAzb52MRW6Ysc8IEdp2U0EKo2GJJNU1VjW5hc+3fxIMrju/bGlY
         ezXLUk4OeaPQ29hUuVXmNEyV31rawFTJ0WC8kfgnW7vqLNcMm45vHnn3BbRuEe6NE+Gz
         5Z60Gv1lm0LD6iG2DoEzLLFFGKBiUMOxje8OifSYVn4g05ZKH05O6NIRcI/jAXks57ZG
         naY54wuOlMITcBquVzQvUAj/TCuhQCrPnYm1lsn3Mvy53LQwm+ZRQo7zwKZxtJoFCPzK
         TC6g==
X-Gm-Message-State: AOAM530Y0MCpvVCmkCy+XrWa+HArNk9SLQSnD4d5RYEgaz1gzlsomwpU
        GmIIoBztHuxTuLrhOj6VaZ9EPEbz5Zef4VQQ1vQ=
X-Google-Smtp-Source: ABdhPJznguuQh7IRu3aSxMyBje/lCbX2oP9c7FXYlVCM9OjqL/sLyOTWgjUOzEQ2GLBt80IA9/rivRT7iPc7Hb/yiYg=
X-Received: by 2002:a05:6a00:2384:b029:19a:eed3:7f42 with SMTP id
 f4-20020a056a002384b029019aeed37f42mr35475427pfc.4.1608176601666; Wed, 16 Dec
 2020 19:43:21 -0800 (PST)
MIME-Version: 1.0
References: <20201216115125.5886-1-chunfeng.yun@mediatek.com>
 <20201216115125.5886-2-chunfeng.yun@mediatek.com> <CANMq1KDBmuoBNeizm9+f1yJgqF9oMqU5k26KfZrSdjrPQm_LwA@mail.gmail.com>
 <1608171557.23328.53.camel@mhfsdcap03>
In-Reply-To: <1608171557.23328.53.camel@mhfsdcap03>
From:   Rosen Penev <rosenp@gmail.com>
Date:   Wed, 16 Dec 2020 19:43:10 -0800
Message-ID: <CAKxU2N8q1XjDbWbv5ksqYr7RMEedV7fng7OUccVggsT89Oyf5w@mail.gmail.com>
Subject: Re: [PATCH 2/3] usb: xhci-mtk: fix UAS issue by XHCI_BROKEN_STREAMS quirk
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 6:29 PM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> On Wed, 2020-12-16 at 20:28 +0800, Nicolas Boichat wrote:
> > On Wed, Dec 16, 2020 at 7:53 PM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
> > >
> > > The 0.96 xHCI controller on some platforms does not support
> > > bulk stream even HCCPARAMS says supporting, due to MaxPSASize
> > > is set a non-zero default value by mistake, here use
> > > XHCI_BROKEN_STREAMS quirk to fix it.
> > >
> > > Fixes: 94a631d91ad3 ("usb: xhci-mtk: check hcc_params after adding primary hcd")
> > > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > ---
> > >  drivers/usb/host/xhci-mtk.c | 7 ++++++-
> > >  drivers/usb/host/xhci-mtk.h | 1 +
> > >  2 files changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
> > > index 8f321f39ab96..08dab974d847 100644
> > > --- a/drivers/usb/host/xhci-mtk.c
> > > +++ b/drivers/usb/host/xhci-mtk.c
> > > @@ -395,6 +395,9 @@ static void xhci_mtk_quirks(struct device *dev, struct xhci_hcd *xhci)
> > >         xhci->quirks |= XHCI_SPURIOUS_SUCCESS;
> > >         if (mtk->lpm_support)
> > >                 xhci->quirks |= XHCI_LPM_SUPPORT;
> > > +
> > > +       if (mtk->broken_streams)
> > > +               xhci->quirks |= XHCI_BROKEN_STREAMS;
> > >  }
> > >
> > >  /* called during probe() after chip reset completes */
> > > @@ -460,6 +463,8 @@ static int xhci_mtk_probe(struct platform_device *pdev)
> > >                 return ret;
> > >
> > >         mtk->lpm_support = of_property_read_bool(node, "usb3-lpm-capable");
> > > +       mtk->broken_streams =
> > > +               of_property_read_bool(node, "mediatek,broken_streams_quirk");
> >
> > Would it be better to add a data field to struct of_device_id
> > mtk_xhci_of_match, and enable this quirk on mediatek,mt8173-xhci only?
> This is the common issue for all SoCs (before 2016.06) with 0.96 xHCI
> when the controller don't support bulk stream. If enable this quirk only
> for mt8173, then for other SoCs, the compatible need include
> "mediatek,mt8173-xhci" in dts, this may be not flexible for some cases,
> e.g. a new SoC has the broken stream as mt8173, but also has another
> different quirk, the way you suggested will not handle it.
> And I plan to remove "mediatek,mt8173-xhci" in mtk_xhci_of_match after
> converting the binding to YMAL.
I'm guessing this also applies to mt7621?
>
> >
> > (IMHO usb3-lpm-capable detection should also be done in the same way)
> I prefer to provide a property for common issues, and use the way you
> suggested for the issue only happened at a specific SoC.
>
> Thank you
>
> >
> > Thanks,
> >
> > >         /* optional property, ignore the error if it does not exist */
> > >         of_property_read_u32(node, "mediatek,u3p-dis-msk",
> > >                              &mtk->u3p_dis_msk);
> > > @@ -546,7 +551,7 @@ static int xhci_mtk_probe(struct platform_device *pdev)
> > >         if (ret)
> > >                 goto put_usb3_hcd;
> > >
> > > -       if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
> > > +       if (!mtk->broken_streams && HCC_MAX_PSA(xhci->hcc_params) >= 4)
> > >                 xhci->shared_hcd->can_do_streams = 1;
> > >
> > >         ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
> > > diff --git a/drivers/usb/host/xhci-mtk.h b/drivers/usb/host/xhci-mtk.h
> > > index a93cfe817904..86aa4978915e 100644
> > > --- a/drivers/usb/host/xhci-mtk.h
> > > +++ b/drivers/usb/host/xhci-mtk.h
> > > @@ -147,6 +147,7 @@ struct xhci_hcd_mtk {
> > >         struct phy **phys;
> > >         int num_phys;
> > >         bool lpm_support;
> > > +       bool broken_streams;
> > >         /* usb remote wakeup */
> > >         bool uwk_en;
> > >         struct regmap *uwk;
> > > --
> > > 2.18.0
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
