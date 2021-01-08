Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48C02EF041
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 10:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbhAHJ5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 04:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbhAHJ5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 04:57:07 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662F5C0612F4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 01:56:27 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id dk8so10672764edb.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 01:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e8wcnpRjmLqWWPjOlKuS2zxtj825HdJfa315uuBxu+E=;
        b=gwT5kI9b3q1yJSSsmO/r1XGlJqaVWHsjszygBZhjqC7h5N6orJ9UZkWUXXLGVsDCdt
         +tUUsJ/rk4gTyjSeuaNo4p41y92lWxoM0ax4HUNKFNs/mTUR5aZErWWuL2rwygC+0SUL
         uaC5iKH2mNmV2MD9P1s6rwULoDm5+wGLeM9Q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e8wcnpRjmLqWWPjOlKuS2zxtj825HdJfa315uuBxu+E=;
        b=WTVtB1Su8jjvS83jNmcAAcaINtwRbyI0w8tsmhEiS46UHLm4QnAPSvmR6LFuL8wD+z
         UBA6RZgZcfjJlp9PdxohTyw4tmWysc1iurkBkEzaW1OFZKUmBexEKw1N5PR8BO6k0luX
         4tntptRHeZFj6ZbpMh49zU55rctgAOxkFTQlZ3B5mlNv6IshJBoIqS4Efd3afSA2gad0
         +VHR13LvqtsHTCJgtPgst6UBHn9uuhX2hImnFCoJXG9JgJuyniVcrW+McWHA/ca0imP5
         VGkHGlujWaPQkUcFlAz/E+YoD4GjCWzPfsd25+n8MbnkQZH2eI23vf1hY0kjscZwBsOk
         YiRA==
X-Gm-Message-State: AOAM5325GuHF1FHgkOs4cRXw6cbGDyFxRno2179JReJa9z/9TwN9JCFL
        HbYEnubFTsK5VWfuzwri0BAXj79GxVQW2g==
X-Google-Smtp-Source: ABdhPJwtn3sUSh7VYQ8ip7KlIeglouZr0vMU5uR4QXQJUfm6cK1njXmMtp5EHn4UmatmcelA0fwIMg==
X-Received: by 2002:a05:6402:b57:: with SMTP id bx23mr4606082edb.191.1610099785505;
        Fri, 08 Jan 2021 01:56:25 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id de12sm3604399edb.82.2021.01.08.01.56.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jan 2021 01:56:23 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id d26so8344519wrb.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 01:56:23 -0800 (PST)
X-Received: by 2002:adf:bb0e:: with SMTP id r14mr2875978wrg.159.1610099783056;
 Fri, 08 Jan 2021 01:56:23 -0800 (PST)
MIME-Version: 1.0
References: <20201216103607.23050-1-yong.wu@mediatek.com> <20201216103607.23050-7-yong.wu@mediatek.com>
 <X+MGKBYKdmPNz7VL@chromium.org> <1de76b46-d9c1-4011-c087-1df236f442c3@arm.com>
In-Reply-To: <1de76b46-d9c1-4011-c087-1df236f442c3@arm.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 8 Jan 2021 18:56:11 +0900
X-Gmail-Original-Message-ID: <CAAFQd5C72ejEEioM=fTeE2=36DgRbDR1cCuWqn-7xnWRVzYPGw@mail.gmail.com>
Message-ID: <CAAFQd5C72ejEEioM=fTeE2=36DgRbDR1cCuWqn-7xnWRVzYPGw@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] iommu/mediatek: Gather iova in iommu_unmap to
 achieve tlb sync once
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        chao.hao@mediatek.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        kernel-team@android.com,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 8:00 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2020-12-23 08:56, Tomasz Figa wrote:
> > On Wed, Dec 16, 2020 at 06:36:06PM +0800, Yong Wu wrote:
> >> In current iommu_unmap, this code is:
> >>
> >>      iommu_iotlb_gather_init(&iotlb_gather);
> >>      ret = __iommu_unmap(domain, iova, size, &iotlb_gather);
> >>      iommu_iotlb_sync(domain, &iotlb_gather);
> >>
> >> We could gather the whole iova range in __iommu_unmap, and then do tlb
> >> synchronization in the iommu_iotlb_sync.
> >>
> >> This patch implement this, Gather the range in mtk_iommu_unmap.
> >> then iommu_iotlb_sync call tlb synchronization for the gathered iova range.
> >> we don't call iommu_iotlb_gather_add_page since our tlb synchronization
> >> could be regardless of granule size.
> >>
> >> In this way, gather->start is impossible ULONG_MAX, remove the checking.
> >>
> >> This patch aims to do tlb synchronization *once* in the iommu_unmap.
> >>
> >> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> >> ---
> >>   drivers/iommu/mtk_iommu.c | 8 +++++---
> >>   1 file changed, 5 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> >> index db7d43adb06b..89cec51405cd 100644
> >> --- a/drivers/iommu/mtk_iommu.c
> >> +++ b/drivers/iommu/mtk_iommu.c
> >> @@ -506,7 +506,12 @@ static size_t mtk_iommu_unmap(struct iommu_domain *domain,
> >>                            struct iommu_iotlb_gather *gather)
> >>   {
> >>      struct mtk_iommu_domain *dom = to_mtk_domain(domain);
> >> +    unsigned long long end = iova + size;
> >>
> >> +    if (gather->start > iova)
> >> +            gather->start = iova;
> >> +    if (gather->end < end)
> >> +            gather->end = end;
> >
> > I don't know how common the case is, but what happens if
> > gather->start...gather->end is a disjoint range from iova...end? E.g.
> >
> >   | gather      | ..XXX... | iova |
> >   |             |          |      |
> >   gather->start |          iova   |
> >                 gather->end       end
> >
> > We would also end up invalidating the TLB for the XXX area, which could
> > affect the performance.
>
> Take a closer look at iommu_unmap() - the gather data is scoped to each
> individual call, so that can't possibly happen.
>
> > Also, why is the existing code in __arm_v7s_unmap() not enough? It seems
> > to call io_pgtable_tlb_add_page() already, so it should be batching the
> > flushes.
>
> Because if we leave io-pgtable in charge of maintenance it will also
> inject additional invalidations and syncs for the sake of strictly
> correct walk cache maintenance. Apparently we can get away without that
> on this hardware, so the fundamental purpose of this series is to
> sidestep it.
>
> It's proven to be cleaner overall to devolve this kind of "non-standard"
> TLB maintenance back to drivers rather than try to cram yet more
> special-case complexity into io-pgtable itself. I'm planning to clean up
> the remains of the TLBI_ON_MAP quirk entirely after this.
>
> Robin.
>
> >>      return dom->iop->unmap(dom->iop, iova, size, gather);
> >>   }
> >>
> >> @@ -523,9 +528,6 @@ static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
> >>      struct mtk_iommu_domain *dom = to_mtk_domain(domain);
> >>      size_t length = gather->end - gather->start;
> >>
> >> -    if (gather->start == ULONG_MAX)
> >> -            return;
> >> -
> >>      mtk_iommu_tlb_flush_range_sync(gather->start, length, gather->pgsize,
> >>                                     dom->data);
> >>   }
> >> --
> >> 2.18.0
> >>
> >> _______________________________________________
> >> iommu mailing list
> >> iommu@lists.linux-foundation.org
> >> https://lists.linuxfoundation.org/mailman/listinfo/iommu
