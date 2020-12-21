Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD012E0114
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 20:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgLUTgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 14:36:18 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:36530 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgLUTgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 14:36:17 -0500
Received: by mail-ot1-f51.google.com with SMTP id d20so9859741otl.3;
        Mon, 21 Dec 2020 11:36:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rq1jfsES1jNvFyfIPsyO2OkYhszsP8atYxGhkgzfZmI=;
        b=ArgXTgDwOwhIUte2E/8ykbCtwzT8SqOqdA32X8zwBPWrfqMwndW/uGsv7o3Xxb02ce
         OQgnj3VsNiV0drtUqhZSdhjEWnNNJs4cc/pQL2+HKMXg9Qpu+l8pNMolDU8hKiV4gpZn
         aD5O+SPbJ7QfYsgzBf5BCJ4zrw+VVnAz0NVs9+RtRO+LtCayhzglTXDiL4a0/6+Reqe9
         N6WtbAagh1jxlY0GEioIkTmkJ0a1ZNbe0WKqr7ubmGfCjb2c6pHVs5IZJpwyi1zgOG5v
         JhajgACnZ41OtV4WgrtdIrdeuyNWVxsMICnQ0Cc2WsS9CVyCCf4ujPBCg4WCC9TjSrqG
         Cqsg==
X-Gm-Message-State: AOAM532U8AOSSlETdoIGbwMyjbN2fPUBw2aOIdHxLnCG77zpl3ICFTeU
        UR4G9QmH7yQX0NRJh8QnxQ==
X-Google-Smtp-Source: ABdhPJznFP9S536Tgj5gc+682RmlMb2tcCWmJvcDp6wrsmOD79KMuGP4y72iX2hNShHSW23ImuxHxA==
X-Received: by 2002:a9d:3d06:: with SMTP id a6mr12825266otc.368.1608579336621;
        Mon, 21 Dec 2020 11:35:36 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id v23sm3976416otj.68.2020.12.21.11.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 11:35:35 -0800 (PST)
Received: (nullmailer pid 419649 invoked by uid 1000);
        Mon, 21 Dec 2020 19:35:33 -0000
Date:   Mon, 21 Dec 2020 12:35:33 -0700
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Ikjoon Jang <ikjn@chromium.org>
Subject: Re: [PATCH 2/3] usb: xhci-mtk: fix UAS issue by XHCI_BROKEN_STREAMS
 quirk
Message-ID: <20201221193533.GB407645@robh.at.kernel.org>
References: <20201216115125.5886-1-chunfeng.yun@mediatek.com>
 <20201216115125.5886-2-chunfeng.yun@mediatek.com>
 <CANMq1KDBmuoBNeizm9+f1yJgqF9oMqU5k26KfZrSdjrPQm_LwA@mail.gmail.com>
 <1608171557.23328.53.camel@mhfsdcap03>
 <CANMq1KA4L4PPRgHTmeisfSWu4qgjgNVFZRvxeuAOyq2_TimELA@mail.gmail.com>
 <1608186230.23328.78.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608186230.23328.78.camel@mhfsdcap03>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 02:23:50PM +0800, Chunfeng Yun wrote:
> On Thu, 2020-12-17 at 11:32 +0800, Nicolas Boichat wrote:
> > On Thu, Dec 17, 2020 at 10:19 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
> > >
> > > On Wed, 2020-12-16 at 20:28 +0800, Nicolas Boichat wrote:
> > > > On Wed, Dec 16, 2020 at 7:53 PM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
> > > > >
> > > > > The 0.96 xHCI controller on some platforms does not support
> > > > > bulk stream even HCCPARAMS says supporting, due to MaxPSASize
> > > > > is set a non-zero default value by mistake, here use
> > > > > XHCI_BROKEN_STREAMS quirk to fix it.
> > > > >
> > > > > Fixes: 94a631d91ad3 ("usb: xhci-mtk: check hcc_params after adding primary hcd")
> > > > > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > > > ---
> > > > >  drivers/usb/host/xhci-mtk.c | 7 ++++++-
> > > > >  drivers/usb/host/xhci-mtk.h | 1 +
> > > > >  2 files changed, 7 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
> > > > > index 8f321f39ab96..08dab974d847 100644
> > > > > --- a/drivers/usb/host/xhci-mtk.c
> > > > > +++ b/drivers/usb/host/xhci-mtk.c
> > > > > @@ -395,6 +395,9 @@ static void xhci_mtk_quirks(struct device *dev, struct xhci_hcd *xhci)
> > > > >         xhci->quirks |= XHCI_SPURIOUS_SUCCESS;
> > > > >         if (mtk->lpm_support)
> > > > >                 xhci->quirks |= XHCI_LPM_SUPPORT;
> > > > > +
> > > > > +       if (mtk->broken_streams)
> > > > > +               xhci->quirks |= XHCI_BROKEN_STREAMS;
> > > > >  }
> > > > >
> > > > >  /* called during probe() after chip reset completes */
> > > > > @@ -460,6 +463,8 @@ static int xhci_mtk_probe(struct platform_device *pdev)
> > > > >                 return ret;
> > > > >
> > > > >         mtk->lpm_support = of_property_read_bool(node, "usb3-lpm-capable");
> > > > > +       mtk->broken_streams =
> > > > > +               of_property_read_bool(node, "mediatek,broken_streams_quirk");
> > > >
> > > > Would it be better to add a data field to struct of_device_id
> > > > mtk_xhci_of_match, and enable this quirk on mediatek,mt8173-xhci only?
> > > This is the common issue for all SoCs (before 2016.06) with 0.96 xHCI
> > > when the controller don't support bulk stream. If enable this quirk only
> > > for mt8173, then for other SoCs, the compatible need include
> > > "mediatek,mt8173-xhci" in dts, this may be not flexible for some cases,
> > > e.g. a new SoC has the broken stream as mt8173, but also has another
> > > different quirk, the way you suggested will not handle it.
> > 
> > It can, we do this regularly for many other components. One example:
> > https://elixir.bootlin.com/linux/latest/source/drivers/i2c/busses/i2c-mt65xx.c#L402
> > 
> Got it. Indeed works when add compatible private data.
> 
> Due to many SoCs supports USB and not upstream, I'd prefer to avoid
> adding new compatible in driver when support new SoCs, and leave the
> code as simple as possible.

No. The problem is adding new fixes requires updating the DT. That would 
be fine if you knew all possible issues and quirks up front. You may for 
some, but you won't catch them all.

Save DT properties for per board quirks/features, not per SoC ones.

> 
> > > And I plan to remove "mediatek,mt8173-xhci" in mtk_xhci_of_match after
> > > converting the binding to YMAL.
> > >
> > > >
> > > > (IMHO usb3-lpm-capable detection should also be done in the same way)

I tend to agree, but am more tolerable of standard USB features than 
specific IP block quirks.

Rob
