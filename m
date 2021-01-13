Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15EC52F43DE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 06:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbhAMFac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 00:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbhAMFab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 00:30:31 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99678C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 21:29:50 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id q22so1329139eja.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 21:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2NaZcbwSAFQ15OW65EbbMjqTmOC5Pf2iFjcyvx6UbnA=;
        b=SkyiyzJ28uSjHS90XLoXBBlIMxeQbmNuAEQ8qW3qG/lEq4KSFJGvKCe2uo6om+eCht
         oHNmuAbEj1wylSDgYYohrZowWD1TI2mPSkvtOcj1vM82/8Tsr+ruktT1iu//pIsXdvzB
         +NLLMVs4Ps2w7DhXFnSO9Nbs5cVRzog+Vam+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2NaZcbwSAFQ15OW65EbbMjqTmOC5Pf2iFjcyvx6UbnA=;
        b=qWwGPrMSwuNgpogOLMmvbo07cTdVRBjIxlXxJopvmdP4Lwt5GyX1Rd1F3j/TugUics
         uuwqmNy9E/MwDKxofKKKiZz4GHZNaUtRfc63hhES7+LYqKInObC156yRvFWBmkJ29RFo
         rQe60sti1cyS3RrmzUvVENwKMabrx36EPG2GPynL5WRu17rxkgOi97xo/g6wDSRcczke
         Ve83bmW5ynG0diif0uTolOHlwHQhoYLPuq0G8+e3MhxcUzpF5Bet8ZESUQIsp50sct5y
         IPpp7sShdTSV1A0sRf/fZSkE2HIU/81P5br/05o320RLJ/4zfACa/c+73TPY2uuNyFpl
         0zMg==
X-Gm-Message-State: AOAM532d4mCpcM21TSne41XANLdxWBk0uu6198R1RXjfEpsEmNNHOOI1
        H0zF2DfumfiN2rhjObGljZ5KHh+H43Ks6m7O
X-Google-Smtp-Source: ABdhPJxek2jCbhOw5f5YExig90rQNxQNrJ0YNuEOHGQzs7RMDwnnsQS23McD/WC94qrrCrh71wPiew==
X-Received: by 2002:a17:906:f905:: with SMTP id lc5mr320248ejb.177.1610515788991;
        Tue, 12 Jan 2021 21:29:48 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id j22sm243148ejy.106.2021.01.12.21.29.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 21:29:48 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id k10so400794wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 21:29:48 -0800 (PST)
X-Received: by 2002:a1c:c308:: with SMTP id t8mr409738wmf.22.1610515383125;
 Tue, 12 Jan 2021 21:23:03 -0800 (PST)
MIME-Version: 1.0
References: <20201209080102.26626-1-yong.wu@mediatek.com> <20201209080102.26626-5-yong.wu@mediatek.com>
 <X+L8qpO+T7+U2s5r@chromium.org> <1608809212.26323.258.camel@mhfsdcap03>
In-Reply-To: <1608809212.26323.258.camel@mhfsdcap03>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 13 Jan 2021 14:22:50 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CnnHwCUioH52VRWZW=f7V7Q=xBSfbhMM+qJVtaqSf8Pw@mail.gmail.com>
Message-ID: <CAAFQd5CnnHwCUioH52VRWZW=f7V7Q=xBSfbhMM+qJVtaqSf8Pw@mail.gmail.com>
Subject: Re: [PATCH v5 04/27] dt-bindings: memory: mediatek: Add domain definition
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, youlin.pei@mediatek.com,
        linux-devicetree <devicetree@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        chao.hao@mediatek.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Evan Green <evgreen@chromium.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, anan.sun@mediatek.com,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 24, 2020 at 8:27 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> On Wed, 2020-12-23 at 17:15 +0900, Tomasz Figa wrote:
> > Hi Yong,
> >
> > On Wed, Dec 09, 2020 at 04:00:39PM +0800, Yong Wu wrote:
> > > In the latest SoC, there are several HW IP require a sepecial iova
> > > range, mainly CCU and VPU has this requirement. Take CCU as a example,
> > > CCU require its iova locate in the range(0x4000_0000 ~ 0x43ff_ffff).
> >
> > Is this really a domain? Does the address range come from the design of
> > the IOMMU?
>
> It is not a really a domain. The address range comes from CCU HW
> requirement. That HW can only access this iova range. thus I create a
> special iommu domain for it.
>

I guess it's the IOMMU/DT maintainers who have the last word here, but
shouldn't DT just specify the hardware characteristics and then the
kernel configure the hardware appropriately, possibly based on some
other configuration interface (e.g. command line parameters or sysfs)?

How I'd do this is rather than enforcing those arbitrary decisions
onto the DT bindings, I'd add properties to the master devices (e.g.
CCU) that specify which IOVA range they can operate on. Then, the
exact split of the complete address space would be done at runtime,
based on kernel configuration, command line parameters and possibly
sysfs attributes if things could be reconfigured dynamically.

Best regards,
Tomasz

> >
> > Best regards,
> > Tomasz
> >
> > >
> > > In this patch we add a domain definition for the special port. In the
> > > example of CCU, If we preassign CCU port in domain1, then iommu driver
> > > will prepare a independent iommu domain of the special iova range for it,
> > > then the iova got from dma_alloc_attrs(ccu-dev) will locate in its special
> > > range.
> > >
> > > This is a preparing patch for multi-domain support.
> > >
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > Acked-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  include/dt-bindings/memory/mtk-smi-larb-port.h | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/dt-bindings/memory/mtk-smi-larb-port.h b/include/dt-bindings/memory/mtk-smi-larb-port.h
> > > index 7d64103209af..2d4c973c174f 100644
> > > --- a/include/dt-bindings/memory/mtk-smi-larb-port.h
> > > +++ b/include/dt-bindings/memory/mtk-smi-larb-port.h
> > > @@ -7,9 +7,16 @@
> > >  #define __DT_BINDINGS_MEMORY_MTK_MEMORY_PORT_H_
> > >
> > >  #define MTK_LARB_NR_MAX                    32
> > > +#define MTK_M4U_DOM_NR_MAX         8
> > > +
> > > +#define MTK_M4U_DOM_ID(domid, larb, port)  \
> > > +   (((domid) & 0x7) << 16 | (((larb) & 0x1f) << 5) | ((port) & 0x1f))
> > > +
> > > +/* The default dom id is 0. */
> > > +#define MTK_M4U_ID(larb, port)             MTK_M4U_DOM_ID(0, larb, port)
> > >
> > > -#define MTK_M4U_ID(larb, port)             (((larb) << 5) | (port))
> > >  #define MTK_M4U_TO_LARB(id)                (((id) >> 5) & 0x1f)
> > >  #define MTK_M4U_TO_PORT(id)                ((id) & 0x1f)
> > > +#define MTK_M4U_TO_DOM(id)         (((id) >> 16) & 0x7)
> > >
> > >  #endif
> > > --
> > > 2.18.0
> > >
> > > _______________________________________________
> > > iommu mailing list
> > > iommu@lists.linux-foundation.org
> > > https://lists.linuxfoundation.org/mailman/listinfo/iommu
>
