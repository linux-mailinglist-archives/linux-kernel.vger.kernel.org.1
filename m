Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECDF2EF034
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 10:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbhAHJzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 04:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbhAHJzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 04:55:38 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720AFC0612F5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 01:54:57 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id v26so1640759eds.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 01:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IK+44CzzfVfOGuAwRFDtWTWEbsmnaUyfEbndc+LLII0=;
        b=g5gIR+DZeDOkUgh3bwbifA/QvR8Xca1KXNdDaE6fShDjJgoMxK33BxMUJ56GfRGQUu
         0RBWDEtQW/NL3kY1bH/fXuGS2/yEn8TdrlH9B+UIBprw0cgqUonLVtCVSQrCRz4P6+XY
         pDUnYebAcRC+MTAkyoyGQBgZxuGydzUdulvgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IK+44CzzfVfOGuAwRFDtWTWEbsmnaUyfEbndc+LLII0=;
        b=kElVIDkRtLQheu2L9ronHeG0LgMZxhMpMjhUfZN+hEbkcF0STabdsUPXGgxke4cp9K
         /3ImZ8A+2RGs+Q9TSkbJ9zFFgKX4lmf8FkIIb5FeeXbpId0TDRWdz9DRwPrgMcYcvBzZ
         2fv4VqnCaGevkIK/D14YcSMkQRmezh21utJy7xlir92F7QAZPBE8DQjAng10Gv2qjfMI
         YyrQtqFPqI/O0kxxp0dA5s+5FMWjnjmzgBrqgxAGeeD0EQq95bU6DVCh58tWq3lBRYKT
         KBtxQS796HHGEphz6jTzW/3ElTG/M8RMjZwSEpH4Uq22lb8q/Anfl5nWyXEW+T2ZzS8p
         SBpw==
X-Gm-Message-State: AOAM530D2LnqEoDwEvLvKH5GJCeQEVCOkUCQmWwu/Xt8DwigFy7M81jt
        rHfNkyw7EftKV8Q5y3lkJUVqCG3IDyxTmw==
X-Google-Smtp-Source: ABdhPJwZ4dJ2xN1maUVFiwMLprz/GIXw0vy7o6ceXDxeo3gZuM0+pknBVasnIioRE1zTTC8M1S6x+g==
X-Received: by 2002:a05:6402:1352:: with SMTP id y18mr4688557edw.178.1610099695958;
        Fri, 08 Jan 2021 01:54:55 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id g10sm3530623edu.97.2021.01.08.01.54.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jan 2021 01:54:54 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id c124so7279952wma.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 01:54:54 -0800 (PST)
X-Received: by 2002:a7b:c92b:: with SMTP id h11mr2296894wml.99.1610099693765;
 Fri, 08 Jan 2021 01:54:53 -0800 (PST)
MIME-Version: 1.0
References: <20201209080102.26626-1-yong.wu@mediatek.com> <X+MBcmzQn9iQWlVZ@chromium.org>
 <1609239977.26323.292.camel@mhfsdcap03>
In-Reply-To: <1609239977.26323.292.camel@mhfsdcap03>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 8 Jan 2021 18:54:41 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Cz5X5_pm3Vef0HcuARXrZPx9FGxeuxtQeqe9vmWcxZzQ@mail.gmail.com>
Message-ID: <CAAFQd5Cz5X5_pm3Vef0HcuARXrZPx9FGxeuxtQeqe9vmWcxZzQ@mail.gmail.com>
Subject: Re: [PATCH v5 18/27] iommu/mediatek: Add power-domain operation
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
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, anan.sun@mediatek.com,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 8:06 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> On Wed, 2020-12-23 at 17:36 +0900, Tomasz Figa wrote:
> > On Wed, Dec 09, 2020 at 04:00:53PM +0800, Yong Wu wrote:
> > > In the previous SoC, the M4U HW is in the EMI power domain which is
> > > always on. the latest M4U is in the display power domain which may be
> > > turned on/off, thus we have to add pm_runtime interface for it.
> > >
> > > When the engine work, the engine always enable the power and clocks for
> > > smi-larb/smi-common, then the M4U's power will always be powered on
> > > automatically via the device link with smi-common.
> > >
> > > Note: we don't enable the M4U power in iommu_map/unmap for tlb flush.
> > > If its power already is on, of course it is ok. if the power is off,
> > > the main tlb will be reset while M4U power on, thus the tlb flush while
> > > m4u power off is unnecessary, just skip it.
> > >
> > > There will be one case that pm runctime status is not expected when tlb
> > > flush. After boot, the display may call dma_alloc_attrs before it call
> > > pm_runtime_get(disp-dev), then the m4u's pm status is not active inside
> > > the dma_alloc_attrs. Since it only happens after boot, the tlb is clean
> > > at that time, I also think this is ok.
> > >
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > ---
> > >  drivers/iommu/mtk_iommu.c | 41 +++++++++++++++++++++++++++++++++------
> > >  1 file changed, 35 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > > index 6fe3ee2b2bf5..0e9c03cbab32 100644
> > > --- a/drivers/iommu/mtk_iommu.c
> > > +++ b/drivers/iommu/mtk_iommu.c
> > > @@ -184,6 +184,8 @@ static void mtk_iommu_tlb_flush_all(void *cookie)
> > >     struct mtk_iommu_data *data = cookie;
> > >
> > >     for_each_m4u(data) {
> > > +           if (!pm_runtime_active(data->dev))
> > > +                   continue;
> >
> > Is it guaranteed that the status is active in the check above, but then
> > the process is preempted and it goes down here?
> >
> > Shouldn't we do something like below?
> >
> >         ret = pm_runtime_get_if_active();
> >         if (!ret)
> >                 continue;
> >         if (ret < 0)
> >                 // handle error
> >
> >         // Flush
> >
> >         pm_runtime_put();
>
> Make sense. Thanks. There is a comment in arm_smmu.c "avoid touching
> dev->power.lock in fastpaths". To avoid this here too(we have many SoC
> don't have power-domain). then the code will be like:
>
>         bool has_pm = !!data->dev->pm_domain;
>
>         if (has_pm) {
>                 if (pm_runtime_get_if_in_use(data->dev) <= 0)
>                         continue;
>         }
>
>         xxxx
>
>         if (has_pm)
>                 pm_runtime_put(data->dev);

Looks good to me, thanks.

> >
> > Similar comment to the other places being changed by this patch.
> >
> > >             writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
> > >                            data->base + data->plat_data->inv_sel_reg);
> > >             writel_relaxed(F_ALL_INVLD, data->base + REG_MMU_INVALIDATE);
> > > @@ -200,6 +202,10 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
> > >     u32 tmp;
> > >
> > >     for_each_m4u(data) {
> > > +           /* skip tlb flush when pm is not active. */
> > > +           if (!pm_runtime_active(data->dev))
> > > +                   continue;
> > > +
> > >             spin_lock_irqsave(&data->tlb_lock, flags);
> > >             writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
> > >                            data->base + data->plat_data->inv_sel_reg);
> [snip]
