Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABE42FE446
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbhAUHqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbhAUHns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:43:48 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537A5C0613C1;
        Wed, 20 Jan 2021 23:43:07 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id g10so743276wrx.1;
        Wed, 20 Jan 2021 23:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kgam/JcAMv4/Hclb81fC+FVrhWIpAb1YZ0aXLXlhAoU=;
        b=tGcaXPu2LOMfxg2jDro99XXVO4QDl9TAdMXYImUZZpAzTfVfLuV+7+4TeKdjso38EZ
         ki/MN1Mbn6qQjl/+vdOiYLRcfAr6TZHUKRhcaecJehpzoYSXcwirGlaOSUK2faF4//7p
         O8zLHUbXiMrKyAPbN2pkwWS05Kl7AsGeAZdNK5v1Idh6D0FwYi+6zjeAg1kVHv7P4v4p
         Ti2M5kTAPCGSzfCqQi8knReYvvqdvVeHrE/Sm8M/jMDbHpIKAtNvZJanq5vL+4+dkzgB
         yXsoFRN2ZZbuK+zLKPNAYkcyOZWgw53p8BzUHcT6j62g6eLz76TTXMRpemvM4LcM4kvP
         LJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kgam/JcAMv4/Hclb81fC+FVrhWIpAb1YZ0aXLXlhAoU=;
        b=YPmKVcEb5wiOwtRogNsw6SAWUPZgRw1uTBJB8nSd21vGLHuAfoVOyQU/skXySJ5N22
         QxCTv4dnK31BQPY0SUakQXk+1fB2m2ZcEF40zK67MvZccG1EODoIw/iZWCTiuxOk8U/7
         Z8tC9vvrfOOm7CeA0XUX9k2jhgpwJvLFNVgjG9N//hhu/PHKWnihK03bgqmwsOjmtePD
         Nqh7yckPc6wfozY0rAeqQHNrZRmLB3RaafL37gynv2u4R28tKWZy5/fPXBlEms7I1SJR
         0BKccxhkwYNuGbiDIa0VAG6CacXU9HPJpM5yeakaQebV9OOgNPOKJZApFGCnxm6YbWrn
         xDWg==
X-Gm-Message-State: AOAM5315R9uiuA8L3XZnSf6uGlzC5u8UI3B9Bn0+d9oVFiDwilOfY7a9
        U+gFAdh+5V0ddTNLeMIkgv/Vhw2//O33NUZLpfw/bQf7/W3igZGe
X-Google-Smtp-Source: ABdhPJwzMl4PpyMqGnMviLbKnQbsLou+EJWi88QswY7xQEmVfHG1Cs+1CbAzbJ4rIlMeILSLe4VqP+/Abfquaw+c/vo=
X-Received: by 2002:adf:9427:: with SMTP id 36mr12828885wrq.271.1611214986136;
 Wed, 20 Jan 2021 23:43:06 -0800 (PST)
MIME-Version: 1.0
References: <20210108113851.354947-1-zhang.lyra@gmail.com> <20210108113851.354947-3-zhang.lyra@gmail.com>
 <47f73502-15fe-5d65-6fc9-22eb078d7797@arm.com> <CAAfSe-vd5eRopOBZMuTi8vq1FqY1qAVSdMHscVuA+uHtL2H=gw@mail.gmail.com>
 <3a2561fc-65a6-4c68-fdb7-a5b670706f43@arm.com>
In-Reply-To: <3a2561fc-65a6-4c68-fdb7-a5b670706f43@arm.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 21 Jan 2021 15:42:30 +0800
Message-ID: <CAAfSe-tgyTp7BYwfhH7xevhdgj5riNET53A=+K6vKsGwrxtFDw@mail.gmail.com>
Subject: Re: [RFC PATCH V2 2/2] iommu: add Unisoc iommu basic driver
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Sheng Xu <sheng.xu@unisoc.com>,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        Kevin Tang <kevin.tang@unisoc.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jan 2021 at 20:29, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-01-20 11:40, Chunyan Zhang wrote:
> [...]
> >>> +     pgt_base_iova = dom->pgt_va +
> >>> +             ((iova - mdata->iova_start) >> SPRD_IOMMU_PAGE_SHIFT);
> >>> +
> >>> +     spin_lock_irqsave(&dom->pgtlock, flags);
> >>> +     for (i = 0; i < page_num; i++) {
> >>> +             pgt_base_iova[i] = pabase >> SPRD_IOMMU_PAGE_SHIFT;
> >>
> >> Out of curiosity, is the pagetable walker cache-coherent, or is this
> >> currently managing to work by pure chance and natural cache churn?
> >
> > ->iotlb_sync_map() was implemented in this driver, I guess that has
> > done what you say here?
>
> No, sync_map only ensures that the previous (invalid) PTE isn't held in
> the IOMMU's TLB. If pgt_va is a regular page allocation then you're
> writing the new PTE to normal kernel memory, with nothing to guarantee
> that write goes any further than the CPU's L1 cache. Thus either the
> IOMMU has capable of snooping the CPU caches in order to see the updated
> PTE value (rather than refetching the stale value from DRAM), or you're
> just incredibly lucky that by the time the IOMMU *does* go to fetch the
> PTE for that address, that updated cache line has already been evicted
> out to DRAM naturally.
>

Got it, thanks for the detailed explanation.
In order to make clear why this code can work, I made a test, and
found that if I wrote more than 1024 PTEs, the value would be updated
to DRAM immediately, otherwise the cache line seems not updated even
if I wrote 1023 PTEs.

> This is not an issue if you use the proper DMA allocator, since that
> will ensure you get a non-cacheable buffer if you need one.
>

I will switch to use dma_alloc_coherent().

Thanks again.

Chunyan

> Robin.
